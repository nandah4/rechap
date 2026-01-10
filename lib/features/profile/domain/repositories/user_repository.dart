
import 'package:rechap/features/profile/domain/entities/user_entity.dart';
import 'package:rechap/core/common/result.dart';

abstract class UserRepository {
  Future<Result<void>> createUser(UserEntity data);

  Future<Result<UserEntity>> getCurrentUser();
  
  Future<Result<void>> updateUser(Map<String, dynamic> fields);
  Future<Result<void>> signOut();
}
