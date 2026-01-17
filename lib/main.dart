import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/core/routing/router.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:rechap/core/themes/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // Ideal time to initialize for testing with Firebase Emulator240259
  // await FirebaseAuth.instance.useAuthEmulator('10.0.2.2', 9099);
  // FirebaseFirestore.instance.useFirestoreEmulator('10.0.2.2', 8080);

  // FirebaseFirestore.instance.settings = const Settings(
  //   persistenceEnabled: true,
  //   sslEnabled: false,
  // );

  runApp(ProviderScope(child: RechapApp()));
}

class RechapApp extends ConsumerWidget {
  const RechapApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routers = ref.read(router);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routers,
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
