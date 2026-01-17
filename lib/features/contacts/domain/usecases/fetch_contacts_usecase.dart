import 'package:rechap/core/common/result.dart';
import 'package:rechap/features/contacts/domain/entities/contact_entity.dart';
import 'package:rechap/features/contacts/domain/repositories/contact_repository.dart';

/// Single Responsibility: Only fetch contacts
/// Handles permission internally before fetching
class FetchContactsUsecase {
  final ContactRepository _contactRepository;

  FetchContactsUsecase({required ContactRepository contactRepository})
    : _contactRepository = contactRepository;

  Future<Result<List<ContactEntity>>> call() async {
    try {
      // Check permission first
      final hasPermission = await _contactRepository.hasPermission();

      if (!hasPermission) {
        final permissionResult = await _contactRepository.requestPermission();
        if (!permissionResult.success || permissionResult.data != true) {
          return Result.error('Permission to access contacts denied');
        }
      }

      // Fetch contacts
      final result = await _contactRepository.fetchContacts();

      if (!result.success) {
        return Result.error(result.message ?? 'Failed to fetch contacts');
      }

      // Filter contacts with valid phone numbers
      final validContacts = result.data!
          .where((c) => c.hasValidPhoneNumber)
          .toList();

      return Result.success(validContacts);
    } catch (e) {
      return Result.error('Unexpected error: ${e.toString()}');
    }
  }
}
