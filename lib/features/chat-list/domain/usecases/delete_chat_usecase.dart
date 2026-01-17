import 'package:rechap/features/chat-list/domain/repositories/chat_repository.dart';
import 'package:rechap/core/common/result.dart';

/// UseCase: Delete a chat room
class DeleteChatUsecase {
  final ChatRepository _chatRepository;

  DeleteChatUsecase({required ChatRepository chatRepository})
    : _chatRepository = chatRepository;

  /// Deletes the chat room with the given ID
  Future<Result<void>> call(String chatId) {
    return _chatRepository.deleteChat(chatId);
  }
}
