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
}
