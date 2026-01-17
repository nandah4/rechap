import 'dart:typed_data';

class ContactEntity {
  final String id;
  final String displayName;
  final Uint8List? photo;
  final List<String> phoneNumbers;

  const ContactEntity({
    required this.id,
    required this.displayName,
    required this.phoneNumbers,
    this.photo,
  });

  /// Get the primary phone number (first in list)
  String? get primaryPhoneNumber =>
      phoneNumbers.isNotEmpty ? phoneNumbers.first : null;

  /// Check if contact has valid phone number
  bool get hasValidPhoneNumber =>
      phoneNumbers.isNotEmpty && phoneNumbers.first.trim().isNotEmpty;
}
