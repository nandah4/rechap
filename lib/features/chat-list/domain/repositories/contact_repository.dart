import 'package:rechap/features/chat-list/data/models/contact_model.dart';

abstract class ContactRepository {
  Future<List<Contact>> fetchContacts();
  Future<void> requestContactPermission();
}
