import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory UserModel.fromJson(Map<String, dynamic> snapshot) {
    return UserModel(
      uid: snapshot['uid'] as String,
      phoneNumber: snapshot['phone_number'] as String,
      username: snapshot['username'] as String?,
      bio: snapshot['bio'] as String?,
      createdAt: (snapshot['created_at'] as Timestamp).toDate(),
      updatedAt: (snapshot['updated_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'username': username,
      'phone_number': phoneNumber,
      'bio': bio,
    };
  }
}
