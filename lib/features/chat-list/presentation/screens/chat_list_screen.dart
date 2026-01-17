import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:rechap/core/themes/app_dimens.dart';
import 'package:rechap/core/themes/app_palette.dart';
import 'package:rechap/core/themes/app_typography.dart';
import 'package:rechap/core/ui/button_primary_shared.dart';
import 'package:rechap/core/ui/empty_widget.dart';
import 'package:rechap/core/ui/loading_shared.dart';
import 'package:rechap/di/auth_di.dart';
import 'package:rechap/features/chat-list/domain/entities/room_chat_entity.dart';
import 'package:rechap/features/chat-list/presentation/view_model/chat_list_providers.dart';
import 'package:rechap/features/chat-list/presentation/view_model/chat_actions_view_model.dart';
import 'package:rechap/features/profile/presentation/view_models/profile_view_model.dart';
import 'package:rechap/core/ui/error_shared.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatListProvider);
    final currentUserId = ref.watch(currentUserIdProvider).value;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                ref.read(profileViewModelProvider.notifier).signOut();
              },
            ),
          ],
          title: Text(
            "Chats",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          centerTitle: false,
        ),
      ),
      body: state.when(
        data: (rooms) => _chatsLoaded(context, rooms, ref, currentUserId),
        error: (e, _) => ErrorShared(
          title: 'Failed to load chats',
          description: 'Refresh to load chats again',
          onPressed: () => ref.invalidate(chatListProvider),
        ),
        loading: () => LoadingShared(),
      ),
    );
  }

  Widget _chatsLoaded(
    BuildContext context,
    List<RoomChatEntity> chats,
    WidgetRef ref,
    String? currentUserId,
  ) {
    if (chats.isEmpty) {
      return EmptyWidget(
        description: "Trying to contact ur friend, now!",
        title: "No chats found",
      );
    }

    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];

        // Get other participant's name
        final otherUserId = chat.participantsId?.firstWhere(
          (id) => id != currentUserId,
          orElse: () => '',
        );
        final displayName = chat.participantNames?[otherUserId] ?? 'Unknown';

        // Get unread count
        final unreadCount = chat.unreadCount?[currentUserId] ?? 0;

        return Dismissible(
          key: Key(chat.id ?? index.toString()),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) => _confirmDelete(context),
          onDismissed: (direction) {
            if (chat.id != null) {
              ref.read(chatActionsProvider.notifier).deleteChat(chat.id!);
            }
          },
          background: Container(
            padding: EdgeInsets.symmetric(horizontal: kSpacing16),
            color: AppPallete.error,
            alignment: Alignment.centerRight,
            child: const Icon(Icons.delete, color: AppPallete.white),
          ),
          child: ListTile(
            minVerticalPadding: kSpacing16,
            onTap: () {
              if (chat.id != null) {
                context.push('/chat-list/chat/${chat.id}');
              }
            },
            leading: Container(
              height: kSpacing48,
              width: kSpacing48,
              decoration: BoxDecoration(
                color: AppPallete.yellowSecondary,
                borderRadius: BorderRadius.circular(kRadius32),
              ),
              child: Center(
                child: Text(
                  displayName.isNotEmpty ? displayName[0].toUpperCase() : '?',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppPallete.blackPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            shape: Border(
              bottom: BorderSide(
                width: kSpacing1,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
            title: Text(displayName, style: kTitleChat(context)),
            subtitle: Text(
              chat.lastMessage ?? "No messages yet...",
              style: kMessage(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatTime(chat.lastMessageAt),
                  style: kTimestamp(context),
                ),
                const Spacer(),
                if (unreadCount > 0) _buildUnreadBadge(context, unreadCount),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Format time to HH:MM
  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  /// Build unread badge only when count > 0
  Widget _buildUnreadBadge(BuildContext context, int count) {
    return Container(
      height: kSpacing28,
      width: kSpacing28,
      decoration: BoxDecoration(
        color: AppPallete.yellowSecondary,
        borderRadius: BorderRadius.circular(kRadius16),
      ),
      child: Center(
        child: Text(
          count > 99 ? '99+' : count.toString(),
          style: kDescription(context).copyWith(fontSize: kFontSize12),
        ),
      ),
    );
  }

  /// Show confirmation dialog before delete
  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Chat'),
            content: const Text('Are you sure you want to delete this chat?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(foregroundColor: AppPallete.error),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
