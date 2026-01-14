import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechap/di/firebase_providers.dart';
import 'package:rechap/di/profile_di.dart';
import 'package:rechap/features/chat-list/data/repository_impl/chat_repository_impl.dart';
import 'package:rechap/features/chat-list/domain/usecases/create_get_room_chat_usecase.dart';

final roomChatRepository = Provider<ChatRepositoryImpl>(
  (ref) => ChatRepositoryImpl(
    firebaseAuth: ref.read(firebaseAuthProvider),
    firebaseFirestore: ref.read(firestoreProvider),
  ),
);

final createOrGetRoomChatUseCase = Provider<CreateGetRoomChatUsecase>(
  (ref) => CreateGetRoomChatUsecase(
    chatRepository: ref.read(roomChatRepository),
    phoneIndexRepository: ref.read(phoneIdxRepositoryProvider),
  ),
);
