class UserEntity {
  final String uid;
  final String phoneNumber;
  final String? username;
  final String? bio;

  UserEntity({
    required this.uid,
    required this.phoneNumber,
    this.username,
    this.bio,
  });

  /// Creates a copy of this entity with the given fields replaced
  UserEntity copyWith({
    String? uid,
    String? phoneNumber,
    String? username,
    String? bio,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      username: username ?? this.username,
      bio: bio ?? this.bio,
    );
  }
}
