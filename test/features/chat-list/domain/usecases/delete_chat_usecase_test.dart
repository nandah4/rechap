import 'package:flutter_test/flutter_test.dart';
import 'package:rechap/core/common/result.dart';
import 'package:rechap/features/chat-list/domain/entities/room_chat_entity.dart';
import 'package:rechap/features/chat-list/domain/repositories/chat_repository.dart';
import 'package:rechap/features/chat-list/domain/usecases/delete_chat_usecase.dart';

/// Mock ChatRepository for testing
class MockChatRepository implements ChatRepository {
  bool deleteSuccess = true;
  String? deleteError;
  String? deletedChatId;

  @override
  Future<Result<void>> deleteChat(String chatId) async {
    deletedChatId = chatId;
    if (deleteSuccess) {
      return Result.success(null);
    }
    return Result.error(deleteError ?? 'Failed to delete');
  }

  @override
  Stream<List<RoomChatEntity>> getChats() {
    throw UnimplementedError();
  }

  @override
  Future<Result<RoomChatEntity>> createRoomChat(String otherUserId) async {
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
  late DeleteChatUsecase usecase;
  late MockChatRepository mockRepository;

  setUp(() {
    mockRepository = MockChatRepository();
    usecase = DeleteChatUsecase(chatRepository: mockRepository);
  });

  group('DeleteChatUsecase', () {
    test('should delete chat successfully', () async {
      // Arrange
      mockRepository.deleteSuccess = true;

      // Act
      final result = await usecase('chat123');

      // Assert
      expect(result.success, true);
      expect(mockRepository.deletedChatId, 'chat123');
    });

    test('should return error when delete fails', () async {
      // Arrange
      mockRepository.deleteSuccess = false;
      mockRepository.deleteError = 'Chat not found';

      // Act
      final result = await usecase('invalid_chat');

      // Assert
      expect(result.success, false);
      expect(result.message, 'Chat not found');
    });

    test('should pass correct chatId to repository', () async {
      // Arrange
      const testChatId = 'test_chat_id_123';

      // Act
      await usecase(testChatId);

      // Assert
      expect(mockRepository.deletedChatId, testChatId);
    });
  });
}
