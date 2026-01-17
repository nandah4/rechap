import 'package:rechap/core/common/result.dart';
import 'package:rechap/features/chat-list/domain/entities/room_chat_entity.dart';

abstract class ChatRepository {
  Future<Result<RoomChatEntity>> createRoomChat(String otherUserId);

  Stream<List<RoomChatEntity>> getChats();

  Future<Result<RoomChatEntity>> getRoomChatByParticipant({
    required String currentUserId,
    required String otherUserId,
  });

  Future<Result<RoomChatEntity>> getRoomChatById(String chatId);

  Future<Result<void>> deleteChat(String chatId);
}
