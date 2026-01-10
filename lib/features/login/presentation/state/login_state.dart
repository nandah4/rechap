import 'package:rechap/features/login/presentation/state/phone_country_state.dart';

enum LoginPhase {
  initial,
  loading,
  timeout,
  codeSent,
  verifying,
  success,
  error,
}

class LoginStateData {
  final LoginPhase status;
  final String? errorMessage;
  final String? verificationId;
  final int? resendCode;
  final PhoneCountryData countryPhoneId;
  final String numberPhone;
  final String redirectPath;

  LoginStateData({
    this.status = LoginPhase.initial,
    this.errorMessage,
    this.verificationId,
    this.resendCode,
    this.countryPhoneId = PhoneCountryData.defaultCountryData,
    this.numberPhone = '',
    this.redirectPath = 'otp-screen',
  });

  LoginStateData copyWith({
    LoginPhase? status,
    String? errorMessage,
    String? verificationId,
    int? resendCode,
    PhoneCountryData? countryPhoneId,
    String? numberPhone,
    String? redirectPath,
  }) {
    return LoginStateData(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      verificationId: verificationId ?? this.verificationId,
      resendCode: resendCode ?? this.resendCode,
      countryPhoneId: countryPhoneId ?? this.countryPhoneId,
      numberPhone: numberPhone ?? this.numberPhone,
      redirectPath: redirectPath ?? this.redirectPath,
    );
  }
}
