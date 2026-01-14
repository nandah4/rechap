import 'dart:typed_data';
import 'package:flutter_contacts/contact.dart' as flutter_contact;

class Contact {
  String id;
  String displayName;
  Uint8List? photo;
  List<String> phoneNumber;

  Contact({
    required this.id,
    required this.displayName,
    required this.phoneNumber,
    this.photo,
  });

  factory Contact.fromPackage(flutter_contact.Contact contact) {
    return Contact(
      id: contact.id,
      displayName: contact.displayName,
      phoneNumber: contact.phones.map((e) => e.number).toList(),
    );
  }
}
