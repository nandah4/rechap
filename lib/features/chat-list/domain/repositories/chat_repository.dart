import 'package:rechap/core/common/result.dart';
import 'package:rechap/features/chat-list/domain/entities/room_chat_entity.dart';

abstract class ChatRepository {
  Future<Result<RoomChatEntity>> createRoomChat(String otherUserId);
}
