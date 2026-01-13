import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rechap/core/themes/app_dimens.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: AppBar(
          title: Text(
            "Chats",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          centerTitle: false,
        ),
      ),
      body: SingleChildScrollView(
        padding: .symmetric(horizontal: kSpacing16),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            ListTile(
              title: Text("Go to Chat Screen"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                context.push('/chat-list/chat');
              },
            ),
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
            ElevatedButton(
              onPressed: () {
                context.push('/contact-list');
              },
              child: Text("Going to Contact List"),
            ),
          ],
        ),
      ),
    );
  }
}
