import 'package:flutter_test/flutter_test.dart';
import 'package:rechap/core/common/result.dart';
import 'package:rechap/features/chat-list/domain/entities/room_chat_entity.dart';
import 'package:rechap/features/chat-list/domain/repositories/chat_repository.dart';
import 'package:rechap/features/chat-list/domain/usecases/get_chats_usecase.dart';

/// Mock ChatRepository for testing
class MockChatRepository implements ChatRepository {
  List<RoomChatEntity> chatsToReturn = [];
  String? streamError;

  @override
  Stream<List<RoomChatEntity>> getChats() {
    if (streamError != null) {
      return Stream.error(streamError!);
    }
    return Stream.value(chatsToReturn);
  }

  @override
  Future<Result<RoomChatEntity>> createRoomChat(String otherUserId) async {
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> deleteChat(String chatId) async {
    throw UnimplementedError();
  }

  @override
  Future<Result<RoomChatEntity>> getRoomChatByParticipant({
    required String currentUserId,
    required String otherUserId,
  }) async {
    throw UnimplementedError();
  }
}

void main() {
  late GetChatsUsecase usecase;
  late MockChatRepository mockRepository;

  setUp(() {
    mockRepository = MockChatRepository();
    usecase = GetChatsUsecase(chatRepository: mockRepository);
  });

  group('GetChatsUsecase', () {
    test('should return empty list when no chats', () async {
      // Arrange
      mockRepository.chatsToReturn = [];

      // Act
      final stream = usecase();
      final result = await stream.first;

      // Assert
      expect(result, isEmpty);
    });

    test('should return list of chats when available', () async {
      // Arrange
      mockRepository.chatsToReturn = [
        RoomChatEntity(
          id: '1',
          participantsId: ['user1', 'user2'],
          lastMessage: 'Hello',
        ),
        RoomChatEntity(
          id: '2',
          participantsId: ['user1', 'user3'],
          lastMessage: 'Hi there',
        ),
      ];

      // Act
      final stream = usecase();
      final result = await stream.first;

      // Assert
      expect(result.length, 2);
      expect(result.first.id, '1');
      expect(result.first.lastMessage, 'Hello');
    });

    test('should emit error when stream fails', () async {
      // Arrange
      mockRepository.streamError = 'User not logged in';

      // Act & Assert
      final stream = usecase();
      expect(stream, emitsError('User not logged in'));
    });
  });
}
