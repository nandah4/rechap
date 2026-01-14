import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:rechap/core/themes/app_dimens.dart';
import 'package:rechap/core/themes/app_palette.dart';
import 'package:rechap/core/themes/app_typography.dart';
import 'package:rechap/features/chat-list/presentation/view_model/contact_view_model.dart';
import 'package:rechap/features/chat-list/presentation/view_model/room_chat_view_model.dart';

class ContactList extends ConsumerWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(contactViewModel);
    final notifier = ref.read(contactViewModel.notifier);

    ref.listen<RoomChatState>(roomChatProvider, (prev, next) {
      if (next is RoomChatLoaded) {
        context.push('/chat-list/chat');
      }

      if (next is RoomChatError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.message)));
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
        actionsPadding: .symmetric(horizontal: kSpacing16),
        actions: [
          IconButton(
            icon: Icon(
              FontAwesome.arrows_rotate_solid,
              size: kFontSize22,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () => notifier.refresh(),
          ),
        ],
      ),
      body: state.when(
        data: (contacts) => contacts.isEmpty
            ? _contactEmpty(context)
            : ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (ctx, index) {
                  final contact = contacts[index];
                  return InkWell(
                    onTap: () {
                      final phoneNumber = contact.phoneNumber?.first;
                      if (phoneNumber != null) {
                        ref
                            .read(roomChatProvider.notifier)
                            .createRoomChat(phoneNumber);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        vertical: kSpacing4,
                      ),
                      child: ListTile(
                        leading: SizedBox(
                          height: kSpacing52,
                          width: kSpacing52,
                          child: _buildAvatar(contact.photo),
                        ),
                        title: Text(
                          contact.displayName ?? 'Display Name',
                          style: kDescription(context).copyWith(
                            fontSize: kFontSize18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          contact.phoneNumber?.first ?? '+62',
                          style: kDescription(context),
                        ),
                      ),
                    ),
                  );
                },
              ),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Icon(
                FontAwesome.circle_exclamation_solid,
                size: kFontSize32,
                color: AppPallete.yellowSecondary,
              ),
              const SizedBox(height: kSpacing10),
              Text(
                e.toString(),
                style: kDescription(context).copyWith(fontSize: kFontSize20),
              ),
            ],
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _contactEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/images/empty-notif.json',
            width: kImageEmpty,
            height: kImageEmpty,
          ),
          SizedBox(height: kSpacing20),
          Text("No contacts found", style: kTitleEmpty(context)),
          Text("Try adding a new contact", style: kSubtitleEmpty(context)),
        ],
      ),
    );
  }

  Widget _buildAvatar(Uint8List? data) {
    if (data != null && data.isNotEmpty) {
      return CircleAvatar(backgroundImage: MemoryImage(data));
    }

    return const CircleAvatar(
      backgroundColor: AppPallete.yellowSecondary,
      child: Icon(Icons.person),
    );
  }
}
