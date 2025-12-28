import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/routing/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rechap/ui/core/themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // Ideal time to initialize
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(ProviderScope(child: RechapApp()));
}

class RechapApp extends StatelessWidget {
  const RechapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
