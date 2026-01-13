import 'package:flutter_contacts/flutter_contacts.dart';

abstract class ContactRepository {
  Future<List<Contact>> fetchContacts();
  Future<void> requestContactPermission();
}
