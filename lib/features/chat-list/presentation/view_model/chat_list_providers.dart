import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/di/chat_di.dart';
import 'package:rechap/di/firebase_providers.dart';
import 'package:rechap/features/chat-list/domain/entities/room_chat_entity.dart';

final chatListProvider = StreamProvider<List<RoomChatEntity>>((ref) {
  // Watch auth state
  final currentUser = ref.watch(firebaseAuthProvider).currentUser;

  print("provider $currentUser");
  if (currentUser == null) {
    return Stream.value([]);
  }

  final getChatsUsecase = ref.read(getChatsUsecaseProvider);

  return getChatsUsecase();
});
