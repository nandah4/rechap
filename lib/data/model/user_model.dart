import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rechap/domain/entities/user_entity.dart';

class UserModel {
  final String uid;
  final String phoneNumber;
  final String? username;
  final String? bio;

  UserModel({
    required this.uid,
    required this.phoneNumber,
    this.username,
    this.bio,
  });

  factory UserModel.fromJson(Map<String, dynamic> snapshot) {
    return UserModel(
      uid: snapshot['uid'] as String,
      phoneNumber: snapshot['phone_number'] as String,
      username: snapshot['username'] as String? ?? '',
      bio: snapshot['bio'] as String? ?? '',
    );
  }

  // ❌ Need Refactor
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      username: entity.username,
      phoneNumber: entity.phoneNumber,
      bio: entity.bio,
    );
  }

  // ❌ Need Refactor
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'username': username,
      'phone_number': phoneNumber,
      'bio': bio,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    };
  }
}

// RULES : Outer layer must not be referenced by inner layer
extension UserModelMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      phoneNumber: phoneNumber,
      bio: bio,
      username: username,
    );
  }
}
