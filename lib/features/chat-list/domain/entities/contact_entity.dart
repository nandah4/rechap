import 'dart:typed_data';

class ContactEntity {
  String? id;
  String? displayName;
  Uint8List? photo;
  List<String>? phoneNumber;

  ContactEntity({this.id, this.displayName, this.phoneNumber, this.photo});
}
