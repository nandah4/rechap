import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/di/chat_di.dart';
import 'package:rechap/features/chat-list/domain/entities/room_chat_entity.dart';
import 'package:rechap/features/chat-list/domain/usecases/create_room_chat_usecase.dart';
import 'package:rechap/features/chat-list/domain/usecases/delete_chat_usecase.dart';

/// States untuk chat actions (create/delete)
sealed class ChatActionState {}

class ChatActionInitial extends ChatActionState {}

class ChatActionLoading extends ChatActionState {}

class ChatActionCreated extends ChatActionState {
  final RoomChatEntity room;
  ChatActionCreated(this.room);
}

class ChatActionDeleted extends ChatActionState {}

class ChatActionError extends ChatActionState {
  final String message;
  ChatActionError(this.message);
}

/// Provider untuk chat actions (create/delete)
final chatActionsProvider =
    NotifierProvider<ChatActionsViewModel, ChatActionState>(
      ChatActionsViewModel.new,
    );

/// ViewModel untuk handle chat actions: create room, delete chat
class ChatActionsViewModel extends Notifier<ChatActionState> {
  late final CreateRoomChatUsecase _createRoomChatUsecase;
  late final DeleteChatUsecase _deleteChatUsecase;

  @override
  ChatActionState build() {
    _createRoomChatUsecase = ref.read(createRoomChatUsecaseProvider);
    _deleteChatUsecase = ref.read(deleteChatUsecaseProvider);
    return ChatActionInitial();
  }

  Future<void> createRoomChat(String phoneNumber) async {
    state = ChatActionLoading();

    final result = await _createRoomChatUsecase(phoneNumber);

    if (result.success && result.data != null) {
      state = ChatActionCreated(result.data!);
      return;
    }

    state = ChatActionError(result.message ?? 'Unknown error');
  }

  Future<void> deleteChat(String chatId) async {
    state = ChatActionLoading();

    final result = await _deleteChatUsecase(chatId);

    if (result.success) {
      state = ChatActionDeleted();
      return;
    }

    state = ChatActionError(result.message ?? 'Unknown error');
  }

  void reset() {
    state = ChatActionInitial();
  }
}
