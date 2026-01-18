import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:rechap/core/themes/app_dimens.dart';
import 'package:rechap/core/themes/app_palette.dart';
import 'package:rechap/core/themes/app_typography.dart';
import 'package:rechap/di/chat_di.dart';
import 'package:rechap/features/contacts/domain/entities/contact_entity.dart';
import 'package:rechap/features/contacts/presentation/view_models/contact_view_model.dart';

/// Callback type for when a contact is selected
typedef OnContactSelected = Future<void> Function(ContactEntity contact);

class ContactListScreen extends ConsumerStatefulWidget {
  /// Callback when user taps on a contact
  final OnContactSelected? onContactSelected;

  const ContactListScreen({this.onContactSelected, super.key});

  @override
  ConsumerState<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends ConsumerState<ContactListScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(contactListProvider);
    final notifier = ref.read(contactListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text('Contact List'),
        actionsPadding: EdgeInsets.symmetric(horizontal: kSpacing16),
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
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.all(kSpacing16),
            child: TextField(
              style: kDescription(context),
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintStyle: kDescription(context),
                hintText: 'Search contacts...',
                prefixIcon: const Icon(Icons.search),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kRadius12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kRadius12),
                  borderSide: const BorderSide(
                    color: AppPallete.yellowSecondary,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: kSpacing16,
                  vertical: kSpacing4,
                ),
              ),
            ),
          ),
          // Contact list
          Expanded(
            child: state.when(
              data: (contacts) {
                final filtered = _filterContacts(contacts);
                return filtered.isEmpty
                    ? _contactEmpty(context)
                    : _contactList(context, filtered);
              },
              error: (e, _) => _contactError(context, notifier, e.toString()),
              loading: () => _chatsLoading(context),
            ),
          ),
        ],
      ),
    );
  }

  /// Filter contacts by search query
  List<ContactEntity> _filterContacts(List<ContactEntity> contacts) {
    if (_searchQuery.isEmpty) return contacts;

    final query = _searchQuery.toLowerCase();
    return contacts.where((c) {
      final nameMatch = c.displayName.toLowerCase().contains(query);
      final phoneMatch = c.phoneNumbers.any((p) => p.contains(query));
      return nameMatch || phoneMatch;
    }).toList();
  }

  /// Handle contact tap with loading state
  Future<void> _onContactTap(ContactEntity contact) async {
    if (widget.onContactSelected == null) return;

    await widget.onContactSelected!(contact);
  }

  Widget _contactList(BuildContext context, List<ContactEntity> contacts) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (ctx, index) {
        final contact = contacts[index];
        return InkWell(
          onTap: () => _onContactTap(contact),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: kSpacing4),
            child: ListTile(
              leading: SizedBox(
                height: kSpacing52,
                width: kSpacing52,
                child: _buildAvatar(contact.photo),
              ),
              title: Text(
                contact.displayName,
                style: kTitleChat(
                  context,
                ).copyWith(fontSize: kFontSize18, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                contact.primaryPhoneNumber ?? 'No phone number',
                style: kMessage(context),
              ),
            ),
          ),
        );
      },
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
          Text(
            _searchQuery.isEmpty
                ? "No contacts found"
                : "No results for '$_searchQuery'",
            style: kTitleEmpty(context),
          ),
          Text("Try adding a new contact", style: kSubtitleEmpty(context)),
        ],
      ),
    );
  }

  Widget _contactError(
    BuildContext context,
    ContactListViewModel notifier,
    String message,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: kSpacing16),
          ElevatedButton.icon(
            onPressed: () => notifier.refresh(),
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _chatsLoading(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: kSpacing52,
            width: kSpacing52,
            child: CircularProgressIndicator(
              color: AppPallete.yellowSecondary,
              strokeWidth: kSpacing4,
            ),
          ),

          SizedBox(height: kSpacing20),
          Text("Loading ...", style: kTitleEmpty(context)),
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
