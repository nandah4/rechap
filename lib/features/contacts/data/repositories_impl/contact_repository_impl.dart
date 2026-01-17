import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:rechap/core/common/result.dart';
import 'package:rechap/features/contacts/data/models/contact_model.dart';
import 'package:rechap/features/contacts/domain/entities/contact_entity.dart';
import 'package:rechap/features/contacts/domain/repositories/contact_repository.dart';

class ContactRepositoryImpl implements ContactRepository {
  @override
  Future<Result<List<ContactEntity>>> fetchContacts() async {
    try {
      final contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );

      final entities = contacts
          .map((c) => ContactModel.fromFlutterContact(c).toEntity())
          .toList();

      return Result.success(entities);
    } catch (e) {
      return Result.error('Failed to fetch contacts: ${e.toString()}');
    }
  }

  @override
  Future<Result<bool>> requestPermission() async {
    try {
      final granted = await FlutterContacts.requestPermission();
      return Result.success(granted);
    } catch (e) {
      return Result.error('Failed to request permission: ${e.toString()}');
    }
  }

  @override
  Future<bool> hasPermission() async {
    // FlutterContacts doesn't have a direct check,
    // we rely on requestPermission behavior
    return FlutterContacts.requestPermission(readonly: true);
  }
}
