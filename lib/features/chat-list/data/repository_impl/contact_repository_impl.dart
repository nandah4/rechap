import 'package:flutter_contacts/flutter_contacts.dart' as flutter_contacts;
import 'package:flutter_contacts/contact.dart' as contact;

import 'package:rechap/features/chat-list/domain/repositories/contact_repository.dart';
import 'package:rechap/features/chat-list/data/models/contact_model.dart';

class ContactRepositoryImpl implements ContactRepository {
  @override
  Future<List<Contact>> fetchContacts() async {
    try {
      List<contact.Contact> contacts =
          await flutter_contacts.FlutterContacts.getContacts();

      final List<Contact> contactsToModel = contacts
          .map((e) => Contact.fromPackage(e))
          .toList();
      return contactsToModel;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> requestContactPermission() async {
    await flutter_contacts.FlutterContacts.requestPermission();
  }
}
