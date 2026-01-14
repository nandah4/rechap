import 'package:rechap/features/chat-list/domain/entities/room_chat_entity.dart';
import 'package:rechap/features/chat-list/domain/repositories/chat_repository.dart';
import 'package:rechap/core/common/result.dart';
import 'package:rechap/features/profile/domain/repositories/phone_index_repository.dart';

class CreateGetRoomChatUsecase {
  final ChatRepository _chatRepository;
  final PhoneIndexRepository _phoneIndexRepository;

  CreateGetRoomChatUsecase({
    required ChatRepository chatRepository,
    required PhoneIndexRepository phoneIndexRepository,
  }) : _chatRepository = chatRepository,
       _phoneIndexRepository = phoneIndexRepository;

  Future<Result<RoomChatEntity>> createRoomChat(String phoneNumber) async {
    try {
      if (phoneNumber.isEmpty) {
        return Result.error("Phone number cannot be empty");
      }

      final phoneIsAvailable = await _phoneIndexRepository
          .checkPhoneNumberAvailable(phoneNumber);

      if (!phoneIsAvailable.success || phoneIsAvailable.data == null) {
        return Result.error("Phone number not registered");
      }

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
      return Result.error(null);
    }
  }
}
