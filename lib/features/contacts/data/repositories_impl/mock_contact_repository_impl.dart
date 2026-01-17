import 'package:rechap/core/common/result.dart';
import 'package:rechap/features/contacts/domain/entities/contact_entity.dart';
import 'package:rechap/features/contacts/domain/repositories/contact_repository.dart';

/// Mock repository for testing on emulator without real contacts
class MockContactRepositoryImpl implements ContactRepository {
  /// Fake contacts for testing
  final List<ContactEntity> _mockContacts = [
    ContactEntity(
      id: '1',
      displayName: 'John Doe',
      phoneNumbers: ['+6282213531164'],
    ),
    ContactEntity(
      id: '2',
      displayName: 'Jane Smith',
      phoneNumbers: ['+6282213531163'],
    ),
    ContactEntity(
      id: '3',
      displayName: 'Bob Wilson',
      phoneNumbers: ['+6282213531162'],
    ),
    ContactEntity(
      id: '4',
      displayName: 'Alice Brown',
      phoneNumbers: ['+6282213531161'],
    ),
    ContactEntity(
      id: '5',
      displayName: 'Charlie Davis',
      phoneNumbers: ['+6282213531160'],
    ),
    ContactEntity(
      id: '6',
      displayName: 'Charlie Irma',
      phoneNumbers: ['+6282213531159'],
    ),
    ContactEntity(
      id: '7',
      displayName: 'Charlie Amelia',
      phoneNumbers: ['+6282213531158'],
    ),
    ContactEntity(
      id: '8',
      displayName: 'Andrea Irma',
      phoneNumbers: ['+6282213531157'],
    ),
  ];

  @override
  Future<Result<List<ContactEntity>>> fetchContacts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return Result.success(_mockContacts);
  }

  @override
  Future<Result<bool>> requestPermission() async {
    // Always granted in mock
    return Result.success(true);
  }

  @override
  Future<bool> hasPermission() async {
    // Always has permission in mock
    return true;
  }
}
