import 'package:firebase_auth/firebase_auth.dart';
import 'package:rechap/domain/common/result.dart';

class PhoneAuthService {
  final FirebaseAuth _firebaseAuth;

  PhoneAuthService(this._firebaseAuth);

  Future<void> sendOTP({
    required String phoneNumber,
    required void Function(PhoneAuthCredential) onVerificationCompleted,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required void Function(FirebaseAuthException) onVerificationFailed,
    required void Function(String verificationId) onCodeTimeout,
    int? forceResendingToken,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onVerificationCompleted,
      verificationFailed: onVerificationFailed,
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: onCodeTimeout,
    );
  }

  PhoneAuthCredential createCredentials(String verificationId, String smsCode) {
    return PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: smsCode,
    );
  }

  Future<Result<User>> signInWithCredential(
    PhoneAuthCredential credential,
  ) async {
    try {
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      if (userCredential.user == null) {
        return Result.error("Failed to retrieve user data after login");
      }
      return Result.success(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return Result.error(e.code);
    }
  }
}
