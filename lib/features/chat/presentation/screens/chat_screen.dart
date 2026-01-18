import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/core/themes/app_dimens.dart';
import 'package:rechap/core/themes/app_palette.dart';
import 'package:rechap/core/themes/app_typography.dart';
import 'package:rechap/core/ui/empty_widget.dart';
import 'package:rechap/core/ui/loading_shared.dart';
import 'package:rechap/di/auth_di.dart';
import 'package:rechap/di/chat_di.dart';
import 'package:rechap/features/chat/domain/entities/message_entity.dart';
import 'package:rechap/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:rechap/features/chat/presentation/view_model/chat_view_model.dart';
import 'package:rechap/features/chat/presentation/widgets/bubble_chat.dart';
import 'package:rechap/features/chat/presentation/widgets/chat_input.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String conversationId;

  const ChatScreen({super.key, required this.conversationId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ChatScreen();
  }
}

class _ChatScreen extends ConsumerState<ChatScreen> {
  late final ScrollController _initScroll;
  bool _hasMarkedAsRead = false;

  @override
  void initState() {
    super.initState();
    _initScroll = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _markAsRead();
    });
  }

  void _markAsRead() {
    if (_hasMarkedAsRead) return;

    final currentUserId = ref.read(currentUserIdProvider).value;
    final conversationId = widget.conversationId;
    if (currentUserId!.isEmpty || conversationId.isEmpty) return;

    ref
        .read(updateMessageUsecaseProvider)
        .updateMessage(conversationId, currentUserId);
    print("MARK AS READ DIEKSEKUSI!");

    _hasMarkedAsRead = true;
  }

  void _scrollToBottom() {
    if (!_initScroll.hasClients) return;

    _initScroll.jumpTo(_initScroll.position.maxScrollExtent);
  }

  @override
  void dispose() {
    _initScroll.dispose();
    _hasMarkedAsRead = false;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatsActionNotifier = ref.watch(chatsActionNotifierProvider.notifier);
    final messages = ref.watch(getMessagesProvider(widget.conversationId));
    final currentUserId = ref.watch(currentUserIdProvider).value;
    final conversation = ref.watch(conversationProvider(widget.conversationId));

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
        data: (messages) => _loadedList(
          messages,
          currentUserId,
          chatsActionNotifier,
          _initScroll,
        ),
        error: (error, stackTrace) => ErrorWidget(error),
        loading: () => LoadingShared(),
      ),
    );
  }

  Widget _loadedList(
    List<MessageEntity?> messages,
    String? currentUserId,
    ChatsActionNotifier chatsActionNotifier,
    ScrollController scrollController,
  ) {
    if (currentUserId == messages.last?.senderId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? EmptyWidget(
                    title: 'No messages yet',
                    description: 'Start a conversation by sending a message.',
                  )
                : ListView.builder(
                    controller: scrollController,
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
                            isSender:
                                messages[index]?.senderId == currentUserId,
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
              chatsActionNotifier.sendMessage(widget.conversationId, message);
            },
          ),
        ],
      ),
    );
  }
}
