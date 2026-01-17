import 'package:rechap/di/firebase_providers.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/di/profile_di.dart';
import 'package:rechap/features/login/data/repositories_impl/auth_repository_impl.dart';
import 'package:rechap/features/login/domain/repositories/auth_repository.dart';
import 'package:rechap/features/login/domain/usecases/auth_usecase.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(firebaseAuth: ref.read(firebaseAuthProvider)),
);

final authUseCaseProvider = Provider<AuthUsecase>(
  (ref) => AuthUsecase(
    authRepository: ref.read(authRepositoryProvider),
    userRepository: ref.read(userRepositoryProvider),
    phoneIndexRepository: ref.read(phoneIdxRepositoryProvider),
  ),
);

/// Reactive provider that updates when auth state changes (login/logout)
final currentUserIdProvider = StreamProvider.autoDispose<String?>((ref) {
  return ref
      .watch(firebaseAuthProvider)
      .authStateChanges()
      .map((user) => user?.uid);
});
