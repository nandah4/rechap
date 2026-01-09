import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/data/providers/firebase_providers.dart';

// Eksternal Package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rechap/di/auth_di.dart';
import 'package:rechap/di/user_di.dart';
import 'package:rechap/domain/entities/user_entity.dart';
import 'package:rechap/domain/services/phone_auth_service.dart';
import 'package:rechap/domain/services/phone_validation_service.dart';
import 'package:rechap/ui/auth/widgets/countdown_resend_otp_widget.dart';

// Internal Package
import 'package:rechap/data/model/auth_state.dart';

/// ViewModel to handle bussiness logc for Login Screen via Phone Number
///
/// Uses [FirebaseAuth] and [UserUseCase] to perform authentication and user data management

class LoginViewModel extends Notifier<LoginStateData> {
  late final PhoneValidationService _phoneValidationService;
  late final PhoneAuthService _phoneAuthService;
  @override
  LoginStateData build() {
    _phoneAuthService = ref.read(phoneAuthServiceProvider);
    _phoneValidationService = ref.read(phoneValidationServiceProvider);
    return LoginStateData();
  }

  // Flag to prevent race condition between login via submitOTP (manually) and via autofill
  bool _isVerifying = false;

  /// Method to sending OTP and verify phone is valid
  ///
  /// Parameter [phoneNumber] is the phone number input from user without entry country code

  Future<void> verifyOTP(String phoneNumber) async {
    final validatePhoneResult = _phoneValidationService.validatePhoneNumber(
      phoneNumber,
    );

    if (validatePhoneResult != null) {
      state = state.copyWith(
        status: LoginState.error,
        errorMessage: validatePhoneResult,
      );
      return;
    }

    // Combine phone number and phone country code id
    final fullPhoneNumber = _phoneValidationService.formatPhoneNumberCountry(
      state.countryPhoneId.phoneCode,
      phoneNumber, // Use the parameter, not state.numberPhone!
    );

    try {
      state = state.copyWith(
        status: LoginState.loading,
        numberPhone: fullPhoneNumber,
        errorMessage: null,
      );

      await _phoneAuthService.sendOTP(
        phoneNumber: state.numberPhone,
        onVerificationCompleted: _verificationCompleted,
        onVerificationFailed: _verificationFailed,
        onCodeSent: _codeSent,
        onCodeTimeout: _codeAutoRetrievalTimeout,
      );
    } catch (e) {
      state = state.copyWith(
        status: LoginState.error,
        errorMessage: 'An error occurred while sending OTP.',
      );
    }
  }

  /// Method to submit OTP code for input manually
  ///
  /// Parameter [smsCode] is the OTP code input from user

  Future<void> submitOTP(String smsCode) async {
    if (state.verificationId == null) {
      state = state.copyWith(
        status: LoginState.error,
        errorMessage: 'Your login session was expired',
      );
      return;
    }
    // Set loading state before verification
    state = state.copyWith(status: LoginState.verifying);

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = _phoneAuthService.createCredentials(
      state.verificationId!,
      smsCode,
    );

    await _finalizeVerificationCompleted(credential);
  }

  /// Method to resend OTP code to user's phone number
  Future<void> resendOTP() async {
    if (state.resendCode == null) return;

    try {
      state = state.copyWith(status: LoginState.loading);

      await _phoneAuthService.sendOTP(
        phoneNumber: state.numberPhone,
        forceResendingToken: state.resendCode,
        onVerificationCompleted: _verificationCompleted,
        onVerificationFailed: _verificationFailed,
        onCodeSent: _codeSent,
        onCodeTimeout: _codeAutoRetrievalTimeout,
      );
    } catch (e) {
      state = state.copyWith(
        status: LoginState.error,
        errorMessage: 'An error occurred while resending OTP.',
      );
    }
  }

  /// Method that used by submitOTP and _verificationCompleted
  ///
  /// Parameters [credentials] receive credentials object with [smsCode] and [verificationId]

  Future<void> _finalizeVerificationCompleted(
    PhoneAuthCredential credential,
  ) async {
    if (_isVerifying) return;

    _isVerifying = true;

    try {
      final userUsecase = ref.read(userUseCaseProvider);

      final checkPhoneNumberAvailable = await userUsecase
          .checkPhoneNumberAvailability(state.numberPhone);

      // Sign In user with credential
      final signInResult = await _phoneAuthService.signInWithCredential(
        credential,
      );

      if (!signInResult.success) {
        state = state.copyWith(
          status: LoginState.error,
          errorMessage: "Sign In Failed",
        );

        return;
      }

      if (checkPhoneNumberAvailable.success) {
        state = state.copyWith(
          status: LoginState.success,
          errorMessage: null,
          redirectPath: 'chat-list-screen',
        );

        return;
      }

      final saveUserViaUseCase = await userUsecase.saveUser(
        UserEntity(uid: signInResult.data!.uid, phoneNumber: state.numberPhone),
      );

      if (!saveUserViaUseCase.success) {
        state = state.copyWith(
          status: LoginState.error,
          errorMessage: saveUserViaUseCase.message,
        );
        return;
      }

      state = state.copyWith(
        status: LoginState.success,
        errorMessage: null,
        redirectPath: 'profile-screen',
      );
    } on FirebaseAuthException catch (e) {
      late final String message;

      switch (e.code) {
        case 'invalid-verification-code':
          message = 'Incorrect OTP code. Please try again.';
          break;

        case 'session-expired':
          message = 'The OTP code has expired. Please request a new one.';
          break;

        case 'invalid-verification-id':
          message =
              'The verification session is invalid. Please resend the OTP.';
          break;

        case 'too-many-requests':
          message = 'Too many attempts. Please try again later.';
          break;

        case 'network-request-failed':
          message = 'Network connection error. Please check your internet.';
          break;

        default:
          message = 'OTP verification failed.';
      }

      state = state.copyWith(status: LoginState.error, errorMessage: message);
    } catch (e) {
      state = state.copyWith(
        status: LoginState.error,
        errorMessage: 'An error occurred during OTP verification.',
      );
    } finally {
      _isVerifying = false;
    }
  }

  void _verificationCompleted(PhoneAuthCredential credential) async {
    // reuse _finalizeVerificationCompleted
    await _finalizeVerificationCompleted(credential);
  }

  /// This method caches the [verificationId] and [resendToken] for later use
  ///
  /// and updates the UI state to navigate the user to the OTP input screen.
  void _codeSent(String verificationId, int? resendToken) async {
    state = state.copyWith(
      resendCode: resendToken,
      verificationId: verificationId,
      status: LoginState.codeSent,
      redirectPath: 'otp-screen',
    );

    ref.read(countdownProvider.notifier).start(60);
  }

  /// Method to handle when error happen in firebase side
  void _verificationFailed(FirebaseAuthException e) {
    late final String message;

    switch (e.code) {
      case 'invalid-phone-number':
        message = 'The phone number is invalid.';
        break;

      case 'too-many-requests':
        message = 'Too many requests. Please try again later.';
        break;

      case 'network-request-failed':
        message = 'Network connection problem.';
        break;

      case 'app-not-authorized':
        message =
            'The app is not authorized. Please check your Firebase configuration.';
        break;

      case 'captcha-check-failed':
        message = 'Security verification failed.';
        break;

      default:
        message = 'Failed to send OTP code.';
    }

    state = state.copyWith(status: LoginState.error, errorMessage: message);
  }

  /// Method to handle when firebase can't read sms automatic
  void _codeAutoRetrievalTimeout(String verificationId) {
    state = state.copyWith(
      verificationId: verificationId,
      status: LoginState.timeout,
      errorMessage: "Didn’t receive SMS? Enter code manually.",
    );
  }

  void setSelectedCountryPhoneID(PhoneCountryData country) {
    state = state.copyWith(countryPhoneId: country);
  }
}
