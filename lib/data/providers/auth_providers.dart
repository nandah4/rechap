// Initialize provider for LoginStateData and LoginViewModel
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/data/providers/firebase_providers.dart';
import 'package:rechap/data/model/auth_state.dart';
import 'package:rechap/ui/auth/view_models/login_view_model.dart';

// Initialize provider for LoginStateData and LoginViewModel
final loginViewModelProvider = NotifierProvider<LoginViewModel, LoginStateData>(
  LoginViewModel.new,
);

// Derived state isLoading
final isLoadingProvider = Provider<bool>((ref) {
  final state = ref.watch(loginViewModelProvider);
  return state.status == LoginState.loading;
});

final authMetaDataState = Provider<String?>(
  (ref) => ref.watch(firebaseAuthProvider).currentUser?.phoneNumber ,
);
