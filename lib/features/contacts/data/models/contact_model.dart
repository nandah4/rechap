import 'dart:typed_data';
import 'package:flutter_contacts/contact.dart' as fc;
import 'package:rechap/features/contacts/domain/entities/contact_entity.dart';

class ContactModel {
  final String id;
  final String displayName;
  final Uint8List? photo;
  final List<String> phoneNumbers;

  const ContactModel({
    required this.id,
    required this.displayName,
    required this.phoneNumbers,
    this.photo,
  });

  /// Factory to create from flutter_contacts package
  factory ContactModel.fromFlutterContact(fc.Contact contact) {
    return ContactModel(
      id: contact.id,
      displayName: contact.displayName,
      phoneNumbers: contact.phones
          .map((phone) => _normalizePhoneNumber(phone.number))
          .where((number) => number.isNotEmpty)
          .toList(),
      photo: contact.photo,
    );
  }

  /// Convert to domain entity
  ContactEntity toEntity() {
    return ContactEntity(
      id: id,
      displayName: displayName,
      phoneNumbers: phoneNumbers,
      photo: photo,
    );
  }

  /// Normalize phone number format
  static String _normalizePhoneNumber(String number) {
    // Remove spaces, dashes, parentheses
    return number.replaceAll(RegExp(r'[\s\-\(\)]'), '');
  }
}
