class PhoneIndexModel {
  final String phoneNumber;
  final String uid;
  final bool exist;

  PhoneIndexModel({
    required this.phoneNumber,
    required this.uid,
    required this.exist,
  });

  factory PhoneIndexModel.fromJson(Map<String, dynamic> json) {
    return PhoneIndexModel(
      phoneNumber: json['phone_number'] as String,
      uid: json['uid'] as String,
      exist: json['exist'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {'phone_number': phoneNumber, 'uid': uid, 'exist': exist};
  }
}
