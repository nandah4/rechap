import 'package:rechap/data/providers/firebase_providers.dart';
import 'package:rechap/data/repositories/user_repository_impl.dart';
import 'package:rechap/domain/repositories/user_repository.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/domain/usecase/user_usecase.dart';

// Dependecy Injection for User Flows

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepositoryImpl(
    firebaseFirestore: ref.read(firestoreProvider),
    firebaseAuth: ref.read(firebaseAuthProvider),
  ),
);

final userUseCaseProvider = Provider<UserUsecase>(
  (ref) => UserUsecase(repositoryImpl: ref.read(userRepositoryProvider)),
);

