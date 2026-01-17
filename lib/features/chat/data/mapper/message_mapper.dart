import 'package:rechap/features/chat/data/model/message_model.dart';
import 'package:rechap/features/chat/domain/entities/message_entity.dart';

extension MessageModelToEntity on MessageModel {
  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      senderId: senderId,
      text: text,
      type: type,
      readBy: readBy,
      createdAt: createdAt,
    );
  }
}

extension MessageEntityToModel on MessageEntity {
  MessageModel toModel() {
    return MessageModel(
      senderId: senderId,
      text: text,
      type: type,
      readBy: readBy,
      createdAt: createdAt,
    );
  }
}
