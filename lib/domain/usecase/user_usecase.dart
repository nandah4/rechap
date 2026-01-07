import 'package:rechap/domain/repositories/user_repository.dart';
import 'package:rechap/domain/common/result.dart';
import 'package:rechap/domain/entities/user_entity.dart';

class UserUsecase {
  final UserRepository repositoryImpl;

  UserUsecase({required this.repositoryImpl});

  Future<Result<void>> saveUser(UserEntity entity) {
    return repositoryImpl.createUser(entity);
  }

  Future<Result<UserEntity>> checkPhoneNumberAvailability(String phoneNumber) {
    return repositoryImpl.getPhoneNumberAvailable(phoneNumber);
  }
}
