import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/di/chat_di.dart';
import 'package:rechap/features/chat-list/domain/entities/room_chat_entity.dart';
import 'package:rechap/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:rechap/features/chat/domain/usecases/send_message_usecase.dart';

final chatsActionNotifierProvider = NotifierProvider<ChatsActionNotifier, void>(
  ChatsActionNotifier.new,
);

class ChatsActionNotifier extends Notifier<void> {
  late final SendMessageUseCase _sendMessageUseCase;

  @override
  void build() {
    _sendMessageUseCase = ref.read(sendMessageUsecaseProvider);
  }

  Future<void> sendMessage(String conversationId, String message) async {
    await _sendMessageUseCase.sendMessage(conversationId, message);
  }
}

final conversationProvider = FutureProvider.family<RoomChatEntity?, String>((
  ref,
  
  conversationId,
) async {
  final roomChats = await ref
      .watch(roomChatRepository)
      .getRoomChatById(conversationId);
  final roomChat = roomChats.data;

  return roomChat;
});
