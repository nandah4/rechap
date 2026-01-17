import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/di/auth_di.dart';
import 'package:rechap/di/firebase_providers.dart';
import 'package:rechap/di/profile_di.dart';
import 'package:rechap/features/chat-list/data/repository_impl/chat_repository_impl.dart';
import 'package:rechap/features/chat-list/domain/usecases/get_chats_usecase.dart';
import 'package:rechap/features/chat-list/domain/usecases/create_room_chat_usecase.dart';
import 'package:rechap/features/chat-list/domain/usecases/delete_chat_usecase.dart';
import 'package:rechap/features/chat/data/repository_impl/message_repository_impl.dart';
import 'package:rechap/features/chat/domain/repositories/message_repository.dart';
import 'package:rechap/features/chat/domain/usecases/send_message_usecase.dart';

// Repository
final roomChatRepository = Provider<ChatRepositoryImpl>(
  (ref) => ChatRepositoryImpl(
    firebaseAuth: ref.read(firebaseAuthProvider),
    firebaseFirestore: ref.read(firestoreProvider),
  ),
);

// UseCases - Each follows Single Responsibility Principle
final getChatsUsecaseProvider = Provider<GetChatsUsecase>(
  (ref) => GetChatsUsecase(chatRepository: ref.read(roomChatRepository)),
);

final createRoomChatUsecaseProvider = Provider<CreateRoomChatUsecase>(
  (ref) => CreateRoomChatUsecase(
    chatRepository: ref.read(roomChatRepository),
    phoneIndexRepository: ref.read(phoneIdxRepositoryProvider),
    authRepository: ref.read(authRepositoryProvider),
  ),
);

final deleteChatUsecaseProvider = Provider<DeleteChatUsecase>(
  (ref) => DeleteChatUsecase(chatRepository: ref.read(roomChatRepository)),
);

final messageRepositoryProvider = Provider<MessageRepository>(
  (ref) =>
      MessageRepositoryImpl(firebaseFirestore: ref.read(firestoreProvider)),
);

final sendMessageUsecaseProvider = Provider<SendMessageUseCase>(
  (ref) => SendMessageUseCase(
    messageRepository: ref.read(messageRepositoryProvider),
    authRepository: ref.read(authRepositoryProvider),
    chatRepository: ref.read(roomChatRepository),
  ),
);
