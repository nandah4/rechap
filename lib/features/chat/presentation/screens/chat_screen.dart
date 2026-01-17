import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/core/themes/app_dimens.dart';
import 'package:rechap/core/themes/app_palette.dart';
import 'package:rechap/core/themes/app_typography.dart';
import 'package:rechap/core/ui/empty_widget.dart';
import 'package:rechap/core/ui/loading_shared.dart';
import 'package:rechap/di/auth_di.dart';
import 'package:rechap/features/chat-list/domain/entities/room_chat_entity.dart';
import 'package:rechap/features/chat/domain/entities/message_entity.dart';
import 'package:rechap/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:rechap/features/chat/presentation/view_model/chat_view_model.dart';
import 'package:rechap/features/chat/presentation/widgets/bubble_chat.dart';
import 'package:rechap/features/chat/presentation/widgets/chat_input.dart';

class ChatScreen extends ConsumerWidget {
  final String conversationId;

  const ChatScreen({super.key, required this.conversationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatsActionNotifier = ref.watch(chatsActionNotifierProvider.notifier);
    final messages = ref.watch(getMessagesProvider(conversationId));
    final currentUserId = ref.watch(currentUserIdProvider).value;
    final conversation = ref.watch(conversationProvider(conversationId));

    final receiverId = conversation.value?.participantsId?.firstWhere(
      (e) => e != currentUserId,
    );
    final receiverName = conversation.value?.participantNames?[receiverId];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          surfaceTintColor: Theme.of(context).colorScheme.onSecondaryFixed,
          title: Text(receiverName ?? "", style: kTitleEmpty(context)),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(height: 1, color: AppPallete.greyBorder),
          ),
        ),
      ),
      body: messages.when(
        data: (messages) =>
            _loadedList(messages, currentUserId, chatsActionNotifier),
        error: (error, stackTrace) => ErrorWidget(error),
        loading: () => LoadingShared(),
      ),
    );
  }

  Widget _loadedList(
    List<MessageEntity?> messages,
    String? currentUserId,
    ChatsActionNotifier chatsActionNotifier,
  ) {
    return Column(
      children: [
        Expanded(
          child: messages.isEmpty
              ? EmptyWidget(
                  title: 'No messages yet',
                  description: 'Start a conversation by sending a message.',
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: kSpacing10),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment:
                          messages[index]?.senderId == currentUserId
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        BubbleChat(
                          message: messages[index]?.text ?? '',
                          isSender: messages[index]?.senderId == currentUserId,
                          dateTime:
                              messages[index]?.createdAt ?? DateTime.now(),
                        ),
                        SizedBox(height: kSpacing16),
                      ],
                    );
                  },
                ),
        ),
        ChatInput(
          onTap: (message) {
            chatsActionNotifier.sendMessage(conversationId, message);
          },
        ),
      ],
    );
  }
}
