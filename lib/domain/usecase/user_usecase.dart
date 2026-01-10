import 'package:rechap/domain/repositories/user_repository.dart';
import 'package:rechap/domain/common/result.dart';
import 'package:rechap/domain/entities/user_entity.dart';
import 'package:rechap/ui/profile/models/edit_field_config.dart';

class UserUsecase {
  final UserRepository repositoryImpl;

  UserUsecase({required this.repositoryImpl});

  Future<Result<void>> saveUser(UserEntity entity) {
    return repositoryImpl.createUser(entity);
  }

  Future<void> updateField(EditFieldType type, String value) async {
    final mapperField = switch (type) {
      EditFieldType.bio => {'bio': value},
      EditFieldType.name => {'username': value},
    };

    await repositoryImpl.updateUser(mapperField);
  }

  Future<Result<UserEntity>> checkPhoneNumberAvailability(String phoneNumber) {
    return repositoryImpl.getPhoneNumberAvailable(phoneNumber);
  }

  Future<UserEntity> getCurrentUser() async {
    final result = await repositoryImpl.getCurrentUser();

    if (result.data == null) throw Exception(result.message);

    return result.data!;
  }
}
