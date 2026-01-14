import 'package:flutter/material.dart';
import 'package:rechap/core/themes/app_dimens.dart';
import 'package:rechap/core/themes/app_palette.dart';
import 'package:rechap/core/themes/app_typography.dart';
import 'package:rechap/features/chat/domain/entities/message_entitiy.dart';
import 'package:rechap/features/chat/presentation/widgets/bubble_chat.dart';
import 'package:rechap/features/chat/presentation/widgets/chat_input.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  List<MessageEntity> messages = [
    MessageEntity(
      id: '1',
      content: 'Hello Jokowi, Long time no see!, How are you?',
      senderId: '1',
      receiverId: '2',
      type: 'text',
      timestamp: '2024-01-01',
    ),
    MessageEntity(
      id: '2',
      content: 'Hello, I am fine!, How about you?',
      senderId: '2',
      receiverId: '1',
      type: 'text',
      timestamp: '2024-01-01',
    ),
    MessageEntity(
      id: '3',
      content: 'I am fine too!',
      senderId: '1',
      receiverId: '2',
      type: 'text',
      timestamp: '2024-01-01',
    ),
    MessageEntity(
      id: '3',
      content: 'I am fine too!',
      senderId: '1',
      receiverId: '2',
      type: 'text',
      timestamp: '2024-01-01',
    ),
    MessageEntity(
      id: '3',
      content: 'I am fine too!',
      senderId: '1',
      receiverId: '2',
      type: 'text',
      timestamp: '2024-01-01',
    ),
    MessageEntity(
      id: '3',
      content: 'I am fine too!',
      senderId: '1',
      receiverId: '2',
      type: 'text',
      timestamp: '2024-01-01',
    ),
    MessageEntity(
      id: '3',
      content: 'I am fine too!',
      senderId: '1',
      receiverId: '2',
      type: 'text',
      timestamp: '2024-01-01',
    ),
    MessageEntity(
      id: '3',
      content: 'I am fine too!',
      senderId: '1',
      receiverId: '2',
      type: 'text',
      timestamp: '2024-01-01',
    ),
    MessageEntity(
      id: '3',
      content: 'I am fine too!',
      senderId: '1',
      receiverId: '2',
      type: 'text',
      timestamp: '2024-01-01',
    ),
    MessageEntity(
      id: '3',
      content: 'I am fine too!',
      senderId: '1',
      receiverId: '2',
      type: 'text',
      timestamp: '2024-01-01',
    ),

    MessageEntity(
      id: '3',
      content: 'I am fine too!',
      senderId: '1',
      receiverId: '2',
      type: 'text',
      timestamp: '2024-01-01',
    ),
    MessageEntity(
      id: '3',
      content: 'I am fine too!',
      senderId: '1',
      receiverId: '2',
      type: 'text',
      timestamp: '2024-01-01',
    ),
    MessageEntity(
      id: '3',
      content: 'I am fine too!',
      senderId: '1',
      receiverId: '2',
      type: 'text',
      timestamp: '2024-01-01',
    ),
  ];

  String currentUser = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          surfaceTintColor: Theme.of(context).colorScheme.onSecondaryFixed,
          title: Text("Ananda Priya Yustira", style: kTitleEmpty(context)),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(height: 1, color: AppPallete.greyBorder),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: kSpacing10),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return Column(
                    crossAxisAlignment: message.senderId == currentUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      BubbleChat(
                        message: message.content,
                        isSender: message.senderId == currentUser,
                        dateTime: DateTime.parse(message.timestamp),
                      ),
                      SizedBox(height: kSpacing16),
                    ],
                  );
                },
              ),
            ),
            ChatInput(onTap: () {}),
          ],
        ),
      ),
    );
  }
}
