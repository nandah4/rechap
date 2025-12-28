import 'package:flutter_riverpod/legacy.dart';
import 'package:rechap/ui/auth/view_models/login_view_model.dart';
import 'package:rechap/data/services/firebase_services.dart';

final loginViewModelProvider = ChangeNotifierProvider<LoginViewModel>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return LoginViewModel(firebaseAuth: auth);
});
