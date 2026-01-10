import 'package:rechap/domain/entities/user_entity.dart';
import 'package:rechap/domain/common/result.dart';

abstract class UserRepository {
  Future<Result<void>> createUser(UserEntity data);
  Future<Result<void>> updateUser(Map<String, dynamic> fields);
  Future<Result<UserEntity>> getPhoneNumberAvailable(String data);
  Future<Result<UserEntity>> getCurrentUser();
}
