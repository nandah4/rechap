import 'package:firebase_auth/firebase_auth.dart';

import 'package:rechap/core/common/result.dart';

import 'package:rechap/features/login/domain/repositories/auth_repository.dart';

typedef VerificationCompleted = void Function(PhoneAuthCredential credential);
typedef VerificationFailed = void Function(FirebaseAuthException e);
typedef CodeSent = void Function(String verificationId, int? resendToken);
typedef CodeAutoRetrievalTimeout = void Function(String verificationId);

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl({
    required this.firebaseAuth,
  });

  /// Through this method, otp code will be sent
  @override
  Future<Result<void>> verifyPhoneNumber({
    required String phoneNumber,
    required VerificationCompleted onVerificationCompleted,
    required VerificationFailed onVerificationFailed,
    required CodeSent onCodeSent,
    required CodeAutoRetrievalTimeout onCodeAutoRetrievalTimeout,
    int? forceResendingToken,
  }) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: onVerificationCompleted,
        verificationFailed: onVerificationFailed,
        codeSent: onCodeSent,
        codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout,
        forceResendingToken: forceResendingToken,
      );

      return Result.success(null);
    } on FirebaseAuthException catch (e) {
      return Result.error("Firebase Auth Exception: ${e.toString()}");
    } catch (e) {
      return Result.error("Unknown Exception: ${e.toString()}");
    }
  }

  @override
  Future<Result<UserCredential>> signInWithCredential(
    PhoneAuthCredential credential,
  ) async {
    try {
      final result = await firebaseAuth.signInWithCredential(credential);

      return Result.success(result);
    } catch (e) {
      return Result.error("Unknown Exception: ${e.toString()}");
    }
  }

  @override 
  PhoneAuthCredential createCredentials(String verificationId, String smsCode) {
    return PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await firebaseAuth.signOut();

      return Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
