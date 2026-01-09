import 'package:rechap/data/model/user_model.dart';
import 'package:rechap/domain/entities/user_entity.dart';
import 'package:rechap/domain/common/result.dart';

abstract class UserRepository {
  Future<Result<void>> createUser(UserEntity data);
  Future<Result<UserEntity>> getPhoneNumberAvailable(String data);
  Future<Result<UserEntity>> getCurrentUser();
}
