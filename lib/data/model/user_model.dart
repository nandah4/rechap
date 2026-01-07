import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rechap/domain/entities/user_entity.dart';

class UserModel {
  final String uid;
  final String phoneNumber;
  final String? username;
  final String? bio;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.uid,
    required this.phoneNumber,
    this.username,
    this.bio,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();

    if (data == null) {
      throw StateError('Document data is null for ${snapshot.id}');
    }
    return UserModel(
      uid: data['uid'] as String,
      phoneNumber: data['phone_number'] as String,
      username: data['username'] as String? ?? '',
      bio: data['bio'] as String? ?? '',
      createdAt: (data['created_at'] as Timestamp?)?.toDate(),
      updatedAt: (data['updated_at'] as Timestamp?)?.toDate(),
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      username: entity.username,
      phoneNumber: entity.phoneNumber,
      bio: entity.bio,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

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
