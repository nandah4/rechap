import 'package:rechap/features/profile/domain/repositories/user_repository.dart';
import 'package:rechap/core/common/result.dart';
import 'package:rechap/features/profile/domain/entities/user_entity.dart';
import 'package:rechap/features/profile/presentation/widgets/field_bottom_sheet_widget/edit_field_config.dart';

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

  Future<UserEntity> getCurrentUser() async {
    final result = await repositoryImpl.getCurrentUser();

    if (result.data == null) throw Exception(result.message);

    return result.data!;
  }

  Future<void> signOut() async {
    await repositoryImpl.signOut();
  }
}
