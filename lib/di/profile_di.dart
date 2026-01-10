import 'package:rechap/di/firebase_providers.dart';
import 'package:rechap/features/profile/data/repositories_impl/phone_index_repository_impl.dart';
import 'package:rechap/features/profile/domain/repositories/phone_index_repository.dart';
import 'package:rechap/features/profile/domain/repositories/user_repository.dart';
import 'package:rechap/features/profile/data/repositories_impl/user_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/features/profile/domain/usecases/user_usecase.dart';

// Dependecy Injection for User Flows

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepositoryImpl(
    firebaseFirestore: ref.read(firestoreProvider),
    firebaseAuth: ref.read(firebaseAuthProvider),
  ),
);

final phoneIdxRepositoryProvider = Provider<PhoneIndexRepository>(
  (ref) =>
      PhoneIndexRepositoryImpl(firebaseFirestore: ref.read(firestoreProvider)),
);

final userUseCaseProvider = Provider<UserUsecase>(
  (ref) => UserUsecase(repositoryImpl: ref.read(userRepositoryProvider)),
);
