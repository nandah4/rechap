import 'package:rechap/core/common/result.dart';
import 'package:rechap/features/chat/domain/repositories/message_repository.dart';

class UpdateMessageUseCase {
  final MessageRepository _messageRepository;

  UpdateMessageUseCase({required MessageRepository messageRepository})
    : _messageRepository = messageRepository;

  Future<Result<void>> updateMessage(
    String conversationId,
    String readerId,
  ) async {
    return _messageRepository.markMessageAsRead(conversationId, readerId);
  }
}
