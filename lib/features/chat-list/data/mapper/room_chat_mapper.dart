import 'package:rechap/features/chat-list/data/models/room_chat_model.dart';
import 'package:rechap/features/chat-list/domain/entities/room_chat_entity.dart';

extension RoomChatModelToEntity on RoomChatModel {
  RoomChatEntity toEntity() {
    return RoomChatEntity(
      participantsId: participantsId,
      participantMap: participantMap,
      unreadCount: unreadCount,
      lastMessage: lastMessage,
      lastMessageAt: lastMessageAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension RoomChatEntityToModel on RoomChatEntity {
  RoomChatModel toModel() {
    return RoomChatModel(
      participantsId: participantsId!,
      participantMap: participantMap!,
      unreadCount: unreadCount!,
      lastMessage: lastMessage,
      lastMessageAt: lastMessageAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
