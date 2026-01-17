import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/features/contacts/data/repositories_impl/contact_repository_impl.dart';
import 'package:rechap/features/contacts/data/repositories_impl/mock_contact_repository_impl.dart';
import 'package:rechap/features/contacts/domain/repositories/contact_repository.dart';
import 'package:rechap/features/contacts/domain/usecases/fetch_contacts_usecase.dart';

/// For testing on emulator without real contacts
const bool useMockContacts = true;

final contactRepositoryProvider = Provider<ContactRepository>(
  (ref) =>
      useMockContacts ? MockContactRepositoryImpl() : ContactRepositoryImpl(),
);

final fetchContactsUsecaseProvider = Provider<FetchContactsUsecase>(
  (ref) => FetchContactsUsecase(
    contactRepository: ref.read(contactRepositoryProvider),
  ),
);
