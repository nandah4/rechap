import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/di/contact_di.dart';
import 'package:rechap/features/chat-list/domain/entities/contact_entity.dart';

final contactViewModel =
    AsyncNotifierProvider<ContactViewModel, List<ContactEntity>>(
      ContactViewModel.new,
    );

class ContactViewModel extends AsyncNotifier<List<ContactEntity>> {
  @override
  Future<List<ContactEntity>> build() async {
    final contactUseCaseVM = ref.read(contactUsecase);

    final result = await contactUseCaseVM.fetchContacts();

    if (!result.success) throw Exception(result.message);

    return result.data ?? [];
  }

  Future<void> refresh() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(build);
  }
}
