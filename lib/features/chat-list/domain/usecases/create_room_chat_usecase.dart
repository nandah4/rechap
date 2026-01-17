import 'package:rechap/features/chat-list/domain/entities/room_chat_entity.dart';
import 'package:rechap/features/chat-list/domain/repositories/chat_repository.dart';
import 'package:rechap/core/common/result.dart';
import 'package:rechap/features/login/domain/repositories/auth_repository.dart';
import 'package:rechap/features/profile/domain/repositories/phone_index_repository.dart';

/// UseCase: Create a new room chat or get existing one
class CreateRoomChatUsecase {
  final ChatRepository _chatRepository;
  final PhoneIndexRepository _phoneIndexRepository;
  final AuthRepository _authRepository;

  CreateRoomChatUsecase({
    required ChatRepository chatRepository,
    required PhoneIndexRepository phoneIndexRepository,
    required AuthRepository authRepository,
  }) : _chatRepository = chatRepository,
       _phoneIndexRepository = phoneIndexRepository,
       _authRepository = authRepository;

  /// Creates a new room chat with the given phone number's user
  /// or returns existing chat if one already exists
  Future<Result<RoomChatEntity>> call(String phoneNumber) async {
    try {
      if (phoneNumber.isEmpty) {
        return Result.error("Phone number cannot be empty");
      }

      // Check phone number is registered
      final phoneIsAvailable = await _phoneIndexRepository
          .checkPhoneNumberAvailable(phoneNumber);

      if (!phoneIsAvailable.success || phoneIsAvailable.data == null) {
        return Result.error("Phone number not registered");
      }

      final currentUser = await _authRepository.getCurrentUser();
      final currentUserId = currentUser.data?.uid;

      final otherUserId = phoneIsAvailable.data!.uid;

      if (currentUserId == null) {
        return Result.error("User not logged in");
      }

      // Check if room chat already exists
      final existingRoomChatResult = await _chatRepository
          .getRoomChatByParticipant(
            currentUserId: currentUserId,
            otherUserId: otherUserId,
          );

      // If exists, return it
      if (existingRoomChatResult.success &&
          existingRoomChatResult.data != null) {
        return Result.success(existingRoomChatResult.data);
      }

      // If not, create new room chat
      final createResult = await _chatRepository.createRoomChat(
        phoneIsAvailable.data!.uid,
      );

      if (!createResult.success) {
        return Result.error(
          createResult.message ?? "Failed to create chat room",
        );
      }

      return Result.success(createResult.data);
    } catch (e) {
      return Result.error("Unknown error creating room chat!");
    }
  }
}
