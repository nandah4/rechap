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

  UserEntity copyWith({
    String? uid,
    String? phoneNumber,
    String? username,
    String? bio,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
