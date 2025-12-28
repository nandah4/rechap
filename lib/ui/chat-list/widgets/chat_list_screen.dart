import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ],
        ),
      ),
    );
  }
}
