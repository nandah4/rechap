import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/di/chat_di.dart';
import 'package:rechap/features/chat-list/domain/entities/room_chat_entity.dart';
import 'package:rechap/features/chat-list/domain/usecases/create_get_room_chat_usecase.dart';

sealed class RoomChatState {}

class RoomChatInitial extends RoomChatState {}

class RoomChatLoading extends RoomChatState {}

class RoomChatLoaded extends RoomChatState {
  final RoomChatEntity roomChat;
  RoomChatLoaded(this.roomChat);
}

class RoomChatError extends RoomChatState {
  final String message;
  RoomChatError(this.message);
}

final roomChatProvider = NotifierProvider<RoomChatViewModel, RoomChatState>(
  RoomChatViewModel.new,
);

class RoomChatViewModel extends Notifier<RoomChatState> {
  late final CreateGetRoomChatUsecase _createGetRoomChatUsecase;
  @override
  RoomChatState build() {
    _createGetRoomChatUsecase = ref.read(createOrGetRoomChatUseCase);
    return RoomChatInitial();
  }

  Future<void> createRoomChat(String phoneNumber) async {
    state = RoomChatLoading();

    final result = await _createGetRoomChatUsecase.createRoomChat(phoneNumber);

    if (result.success && result.data != null) {
      state = RoomChatLoaded(result.data!);
      return;
    }

    state = RoomChatError(result.message ?? 'Unknown error');
  }
}
