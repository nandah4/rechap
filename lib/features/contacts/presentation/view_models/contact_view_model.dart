import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/di/contact_di.dart';
import 'package:rechap/features/contacts/domain/entities/contact_entity.dart';

final contactListProvider =
    AsyncNotifierProvider<ContactListViewModel, List<ContactEntity>>(
      ContactListViewModel.new,
    );

class ContactListViewModel extends AsyncNotifier<List<ContactEntity>> {
  @override
  Future<List<ContactEntity>> build() async {
    return _fetchContacts();
  }

  Future<List<ContactEntity>> _fetchContacts() async {
    final usecase = ref.read(fetchContactsUsecaseProvider);
    final result = await usecase();

    if (!result.success) {
      throw Exception(result.message);
    }

    return result.data ?? [];
  }


  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchContacts);
  }
}
