import 'package:rechap/features/chat-list/domain/repositories/contact_repository.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactRepositoryImpl implements ContactRepository {
  @override
  Future<List<Contact>> fetchContacts() async {
    try {
      List<Contact> contacts = await FlutterContacts.getContacts();

      return contacts;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> requestContactPermission() async {
    await FlutterContacts.requestPermission();
  }
}
