import 'package:rechap/features/chat-list/domain/repositories/contact_repository.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class MockContactRepositoryImpl implements ContactRepository {
  @override
  Future<List<Contact>> fetchContacts() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      List<Contact> contacts = [
        Contact(id: "1234567", displayName: "Ananda Priya Yustira 1"),
        Contact(id: "1234567", displayName: "Ananda Priya Yustira 2"),
        Contact(id: "1234567", displayName: "Ananda Priya Yustira 3"),
        Contact(id: "1234567", displayName: "Ananda Priya Yustira 4"),
      ];

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
