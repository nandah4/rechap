import 'package:rechap/features/profile/data/models/phone_index_model.dart';
import 'package:rechap/features/profile/data/models/user_model.dart';
import 'package:rechap/features/profile/domain/entities/phone_index.dart';
import 'package:rechap/features/profile/domain/entities/user_entity.dart';

extension UserModelToEntity on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      phoneNumber: phoneNumber,
      bio: bio,
      username: username,
    );
  }
}

extension UserEntityToModel on UserEntity {
  UserModel toModel() {
    return UserModel(
      uid: uid,
      phoneNumber: phoneNumber,
      bio: bio,
      username: username,
    );
  }
}

extension PhoneIndexEntityToModel on PhoneIndexEntity {
  PhoneIndexModel toModel() {
    return PhoneIndexModel(phoneNumber: phoneNumber, exist: exist, uid: uid);
  }
}
