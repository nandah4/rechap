class UserEntity {
  final String uid;
  final String phoneNumber;
  final String? username;
  final String? bio;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserEntity({
    required this.uid,
    required this.phoneNumber,
    this.username,
    this.bio,
    this.createdAt,
    this.updatedAt,
  });
}
