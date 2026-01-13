import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/di/contact_di.dart';
import 'package:rechap/features/chat-list/domain/entities/contact_entity.dart';
import 'package:rechap/features/chat-list/domain/usecases/contact_usecase.dart';

sealed class ContactState {}

class ContactLoading extends ContactState {}

class ContactLoaded extends ContactState {
  final List<ContactEntity> contacs;

  ContactLoaded({required this.contacs});
}

class ContactError extends ContactState {
  final String message;
  ContactError({required this.message});
}

final contactViewModel = NotifierProvider<ContactViewModel, ContactState>(
  ContactViewModel.new,
);

class ContactViewModel extends Notifier<ContactState> {
  late final ContactUsecase _contactUsecase;
  @override
  ContactState build() {
    _contactUsecase = ref.read(contactUsecase);
    // fetch saat pertama kali dibuat
    _fetchContacts();
    return ContactLoading();
  }

  Future<void> _fetchContacts() async {
    try {
      final contacts = await _contactUsecase.fetchContacts();

      if (!contacts.success) {
        state = ContactError(message: contacts.message ?? 'Unknown Error');
      }

      state = ContactLoaded(contacs: contacts.data ?? []);
    } catch (e) {
      state = ContactError(message: e.toString());
    }
  }
}
