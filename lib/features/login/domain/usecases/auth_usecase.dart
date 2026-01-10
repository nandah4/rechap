import 'package:rechap/core/common/result.dart';
import 'package:rechap/features/login/domain/repositories/auth_repository.dart';
import 'package:rechap/features/profile/domain/entities/phone_index.dart';
import 'package:rechap/features/profile/domain/entities/user_entity.dart';
import 'package:rechap/features/profile/domain/repositories/phone_index_repository.dart';
import 'package:rechap/features/profile/domain/repositories/user_repository.dart';

// typedef VerificationCompleted = void Function();
// typedef VerificationFailed = void Function(String errorMesssage);
// typedef CodeSent = void Function(String verificationId, int? resendToken);
// typedef CodeAutoRetrievalTimeout = void Function(String verificationId);

class AuthUsecase {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final PhoneIndexRepository _phoneIndexRepository;

  AuthUsecase({
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required PhoneIndexRepository phoneIndexRepository,
  }) : _authRepository = authRepository,
       _userRepository = userRepository,
       _phoneIndexRepository = phoneIndexRepository;

  Future<Result<void>> createProfile(
    UserEntity user,
    PhoneIndexEntity phone,
  ) async {
    try {
      final userResult = await _userRepository.createUser(user);
      if (!userResult.success) {
        return Result.error(
          userResult.message ?? "Failed to create user profile.",
        );
      }

      final phoneResult = await _phoneIndexRepository.createPhoneIndex(phone);
      if (!phoneResult.success) {
        return Result.error(
          phoneResult.message ?? 'Failed to create user profile.',
        );
      }

      return Result.success(null);
    } catch (e) {
      return Result.error("Error Something Wrong: ${e.toString()}");
    }
  }

  Future<Result<void>> checkPhoneNumberAvailability(String numberPhone) async {
    try {
      final isAvailablePhone = await _phoneIndexRepository
          .checkPhoneNumberAvailable(numberPhone);
      if (isAvailablePhone.success) {
        return Result.success(null);
      }
      return Result.error("Number Phone Not Found");
    } catch (e) {
      return Result.error("Something Wrong ${e.toString()}");
    }
  }

  // Future<Result<void>> sendOTP({
  //   required String phoneNumber,
  //   required VerificationCompleted verificationCompleted,
  //   required VerificationFailed verificationFailed,
  //   required CodeSent codeSent,
  //   required CodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
  // }) async {
  //   await authRepository.sendOTP(phoneNumber: phoneNumber, verificationCompleted: verificationCompleted, verificationFailed: verificationFailed, codeSent: codeSent, codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
  // }
}
