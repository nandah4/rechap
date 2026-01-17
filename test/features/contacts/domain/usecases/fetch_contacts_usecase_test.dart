import 'package:flutter_test/flutter_test.dart';
import 'package:rechap/core/common/result.dart';
import 'package:rechap/features/contacts/domain/entities/contact_entity.dart';
import 'package:rechap/features/contacts/domain/repositories/contact_repository.dart';
import 'package:rechap/features/contacts/domain/usecases/fetch_contacts_usecase.dart';

/// Mock implementation for testing
class MockContactRepository implements ContactRepository {
  bool hasPermissionValue = true;
  bool requestPermissionValue = true;
  List<ContactEntity> contactsToReturn = [];
  String? errorMessage;

  @override
  Future<bool> hasPermission() async => hasPermissionValue;

  @override
  Future<Result<bool>> requestPermission() async {
    return Result.success(requestPermissionValue);
  }

  @override
  Future<Result<List<ContactEntity>>> fetchContacts() async {
    if (errorMessage != null) {
      return Result.error(errorMessage!);
    }
    return Result.success(contactsToReturn);
  }
}

void main() {
  late FetchContactsUsecase usecase;
  late MockContactRepository mockRepository;

  setUp(() {
    mockRepository = MockContactRepository();
    usecase = FetchContactsUsecase(contactRepository: mockRepository);
  });

  group('FetchContactsUsecase', () {
    test('should return empty list when no contacts', () async {
      // Arrange
      mockRepository.contactsToReturn = [];

      // Act
      final result = await usecase();

      // Assert
      expect(result.success, true);
      expect(result.data, isEmpty);
    });

    test('should return contacts when available', () async {
      // Arrange
      mockRepository.contactsToReturn = [
        ContactEntity(
          id: '1',
          displayName: 'John Doe',
          phoneNumbers: ['+6281234567890'],
        ),
        ContactEntity(
          id: '2',
          displayName: 'Jane Smith',
          phoneNumbers: ['+6289876543210'],
        ),
      ];

      // Act
      final result = await usecase();

      // Assert
      expect(result.success, true);
      expect(result.data?.length, 2);
      expect(result.data?.first.displayName, 'John Doe');
    });

    test('should filter out contacts without valid phone numbers', () async {
      // Arrange
      mockRepository.contactsToReturn = [
        ContactEntity(
          id: '1',
          displayName: 'John Doe',
          phoneNumbers: ['+6281234567890'], // Valid
        ),
        ContactEntity(
          id: '2',
          displayName: 'No Phone',
          phoneNumbers: [], // Invalid - empty
        ),
        ContactEntity(
          id: '3',
          displayName: 'Empty String',
          phoneNumbers: ['   '], // Invalid - whitespace only
        ),
      ];

      // Act
      final result = await usecase();

      // Assert
      expect(result.success, true);
      expect(result.data?.length, 1);
      expect(result.data?.first.displayName, 'John Doe');
    });

    test('should request permission when not granted', () async {
      // Arrange
      mockRepository.hasPermissionValue = false;
      mockRepository.requestPermissionValue = true;
      mockRepository.contactsToReturn = [
        ContactEntity(
          id: '1',
          displayName: 'John',
          phoneNumbers: ['+62812345'],
        ),
      ];

      // Act
      final result = await usecase();

      // Assert
      expect(result.success, true);
      expect(result.data?.length, 1);
    });

    test('should return error when permission denied', () async {
      // Arrange
      mockRepository.hasPermissionValue = false;
      mockRepository.requestPermissionValue = false;

      // Act
      final result = await usecase();

      // Assert
      expect(result.success, false);
      expect(result.message, 'Permission to access contacts denied');
    });

    test('should return error when fetch fails', () async {
      // Arrange
      mockRepository.errorMessage = 'Network error';

      // Act
      final result = await usecase();

      // Assert
      expect(result.success, false);
      expect(result.message, 'Network error');
    });
  });
}
