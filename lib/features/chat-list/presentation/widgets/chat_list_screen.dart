import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rechap/di/firebase_providers.dart';
import 'package:rechap/core/themes/app_palette.dart';

import 'package:rechap/core/themes/app_dimens.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                ref.read(firebaseAuthProvider).signOut();
              },
              child: Icon(
                Icons.logout,
                color: AppPallete.error,
                size: kFontSize24,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text("Chat List Screen"),
            ElevatedButton(
              onPressed: () {
                context.push('/auth/login');
              },
              child: Text("Going to Login"),
            ),
            ElevatedButton(
              onPressed: () {
                context.pushNamed('profile-screen');
              },
              child: Text("Going to Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
