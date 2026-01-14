import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rechap/core/common/result.dart';
import 'package:rechap/features/chat-list/data/mapper/room_chat_mapper.dart';
import 'package:rechap/features/chat-list/data/models/room_chat_model.dart';
import 'package:rechap/features/chat-list/domain/entities/room_chat_entity.dart';
import 'package:rechap/features/chat-list/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  ChatRepositoryImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseAuth = firebaseAuth,
       _firebaseFirestore = firebaseFirestore;

  @override
  Future<Result<RoomChatEntity>> createRoomChat(String otherUserId) async {
    try {
      final currentActiveUser = _firebaseAuth.currentUser?.uid;

      if (currentActiveUser == null) return Result.error("User not logged in");

      final RoomChatModel roomChatModel = RoomChatModel(
        participantsId: [currentActiveUser, otherUserId],
        participantMap: {currentActiveUser: true, otherUserId: true},
        unreadCount: {currentActiveUser: 0, otherUserId: 0},
        lastMessage: null,
        lastMessageAt: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // final roomChatToFirestore = roomChat.toFirestore();
      await _firebaseFirestore
          .collection('conversations')
          .add(roomChatModel.toFirestore());

      return Result.success(roomChatModel.toEntity());
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
