import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/features/chat-list/data/repository_impl/contact_repository_impl.dart';
import 'package:rechap/features/chat-list/data/repository_impl/mock_contact_repository_impl.dart';
import 'package:rechap/features/chat-list/domain/repositories/contact_repository.dart';
import 'package:rechap/features/chat-list/domain/usecases/contact_usecase.dart';

final contactRepository = Provider<ContactRepository>(
  (ref) => ContactRepositoryImpl(),
);

final mockContactRepository = Provider<ContactRepository>(
  (ref) => MockContactRepositoryImpl(),
);

final contactUsecase = Provider<ContactUsecase>(
  (ref) => ContactUsecase(contactRepository: ref.read(mockContactRepository)),
);
