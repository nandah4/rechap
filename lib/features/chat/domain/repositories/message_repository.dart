import 'package:rechap/core/common/result.dart';
import 'package:rechap/features/chat/domain/entities/message_entity.dart';

/// Repository interface untuk message operations
abstract class MessageRepository {
  /// Send a message to conversation
  Future<Result<void>> sendMessage(
    MessageEntity message, {
    required String conversationId,
    required String receiverId,
  });

  /// Get messages stream for real-time updates
  Stream<List<MessageEntity?>> getMessages(String conversationId);
}
