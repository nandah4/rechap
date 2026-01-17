import 'package:rechap/features/chat-list/domain/entities/room_chat_entity.dart';
import 'package:rechap/features/chat-list/domain/repositories/chat_repository.dart';

/// UseCase: Get all chats for current user (Stream)
class GetChatsUsecase {
  final ChatRepository _chatRepository;

  GetChatsUsecase({required ChatRepository chatRepository})
    : _chatRepository = chatRepository;

  /// Returns a stream of chat rooms for the current user
  Stream<List<RoomChatEntity>> call() {
    return _chatRepository.getChats();
  }
}
