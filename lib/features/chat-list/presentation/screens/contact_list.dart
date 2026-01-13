import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rechap/core/themes/app_dimens.dart';
import 'package:rechap/core/themes/app_palette.dart';
import 'package:rechap/core/themes/app_typography.dart';
import 'package:rechap/features/chat-list/presentation/view_model/contact_view_model.dart';

class ContactList extends ConsumerWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(contactViewModel);

    return Scaffold(
      appBar: AppBar(title: Text('Contact List')),
      body: switch (state) {
        ContactLoading() => Center(child: CircularProgressIndicator()),
        ContactLoaded(contacs: final contacts) => ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (ctx, index) {
            final contact = contacts[index];
            return Column(
              children: [
                InkWell(
                  highlightColor: Theme.of(
                    context,
                  ).colorScheme.onSecondaryFixed,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return Container(
                          child: Column(children: [Text("NNN")]),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: .symmetric(vertical: kSpacing8),
                    child: ListTile(
                      leading: Container(
                        width: kSpacing52,
                        height: kSpacing52,
                        decoration: BoxDecoration(
                          color: AppPallete.yellowSecondary,
                          borderRadius: BorderRadius.circular(kRadius32),
                        ),
                      ),
                      title: Text(
                        contact.displayName ?? 'Name',
                        style: kDescription(context),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),

        ContactError(message: final message) => Center(
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
                message,
                style: kDescription(context).copyWith(fontSize: kFontSize20),
              ),
            ],
          ),
        ),
      },
    );
  }
}
