import 'package:rechap/core/common/result.dart';
import 'package:rechap/features/contacts/domain/entities/contact_entity.dart';

abstract class ContactRepository {
  /// Fetch all contacts from device
  Future<Result<List<ContactEntity>>> fetchContacts();

  /// Request permission to access contacts
  Future<Result<bool>> requestPermission();

  /// Check if permission is already granted
  Future<bool> hasPermission();
}
