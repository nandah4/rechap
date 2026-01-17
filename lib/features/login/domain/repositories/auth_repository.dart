import 'package:firebase_auth/firebase_auth.dart';
import 'package:rechap/core/common/result.dart';

typedef VerificationCompleted = void Function(PhoneAuthCredential credential);
typedef VerificationFailed = void Function(FirebaseAuthException e);
typedef CodeSent = void Function(String verificationId, int? resendToken);
typedef CodeAutoRetrievalTimeout = void Function(String verificationId);

abstract class AuthRepository {
  Future<Result<void>> verifyPhoneNumber({
    required String phoneNumber,
    required VerificationCompleted onVerificationCompleted,
    required VerificationFailed onVerificationFailed,
    required CodeSent onCodeSent,
    required CodeAutoRetrievalTimeout onCodeAutoRetrievalTimeout,
    int? forceResendingToken,
  });

  Future<Result<UserCredential>> signInWithCredential(
    PhoneAuthCredential credential,
  );

  Future<Result<User?>> getCurrentUser();

  PhoneAuthCredential createCredentials(String verificationId, String smsCode);

  Future<Result<void>> signOut();
}
