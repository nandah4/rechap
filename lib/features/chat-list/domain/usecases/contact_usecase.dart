import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:rechap/core/common/result.dart';
import 'package:rechap/features/chat-list/domain/entities/contact_entity.dart';
import 'package:rechap/features/chat-list/domain/repositories/contact_repository.dart';

class ContactUsecase {
  final ContactRepository _contactRepository;

  ContactUsecase({required ContactRepository contactRepository})
    : _contactRepository = contactRepository;

  Future<Result<void>> requestContactPermission() async {
    try {
      await _contactRepository.requestContactPermission();

      return Result.success(null);
    } catch (e) {
      return Result.error("Request Deniend");
    }
  }

  Future<Result<List<ContactEntity>>> fetchContacts() async {
    try {
      final granted = await FlutterContacts.requestPermission();
      if (!granted) return Result.error("Permission to access contact denied!");

      final contacts = await _contactRepository.fetchContacts();
      final List<ContactEntity> contactsEntity = contacts
          .map((e) => ContactEntity(id: e.id, displayName: e.displayName))
          .toList();

      return Result.success(contactsEntity);
    } catch (e) {
      return Result.error("Failed to Fetch Contact");
    }
  }
}
