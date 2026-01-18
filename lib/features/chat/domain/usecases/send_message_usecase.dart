import 'package:rechap/core/common/result.dart';
import 'package:rechap/features/chat-list/domain/repositories/chat_repository.dart';
import 'package:rechap/features/chat/domain/entities/message_entity.dart';
import 'package:rechap/features/chat/domain/repositories/message_repository.dart';
import 'package:rechap/features/login/domain/repositories/auth_repository.dart';

class SendMessageUseCase {
  final ChatRepository _chatRepository;
  final MessageRepository _messageRepository;
  final AuthRepository _authRepository;

  SendMessageUseCase({
    required MessageRepository messageRepository,
    required AuthRepository authRepository,
    required ChatRepository chatRepository,
  }) : _messageRepository = messageRepository,
       _authRepository = authRepository,
       _chatRepository = chatRepository;

  Future<Result<void>> sendMessage(
    String conversationId,
    String message,
  ) async {
    if (conversationId.isEmpty || message.isEmpty) {
      return Result.error('Message is empty');
    }

    final currentUser = await _authRepository.getCurrentUser();

    if (currentUser.data == null) {
      return Result.error('User not found');
    }

    // get user id based on current user
    final userId = currentUser.data!.uid;
    final roomChat = await _chatRepository.getRoomChatById(conversationId);

    if (!roomChat.success) return Result.error(roomChat.message);

    // get receiver id from room chat
    final receiverId = roomChat.data!.participantsId!.firstWhere(
      (participant) => participant != userId,
    );

    // create message entity
    final messageEntity = MessageEntity(
      senderId: userId,
      text: message,
      createdAt: DateTime.now(),
      type: 'text',
    );

    // send message
    final result = await _messageRepository.sendMessage(
      messageEntity,
      conversationId: conversationId,
      receiverId: receiverId,
    );

    if (!result.success) return Result.error(result.message);

    return Result.success(null);
  }
}
