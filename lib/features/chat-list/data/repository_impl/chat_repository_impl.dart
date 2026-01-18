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

      // Fetch participant names from users collection
      final currentUserDoc = await _firebaseFirestore
          .collection('users')
          .doc(currentActiveUser)
          .get();
      final otherUserDoc = await _firebaseFirestore
          .collection('users')
          .doc(otherUserId)
          .get();

      final participantNames = {
        currentActiveUser:
            currentUserDoc.data()?['username'] as String? ?? 'Unknown',
        otherUserId: otherUserDoc.data()?['username'] as String? ?? 'Unknown',
      };

      final docRef = _firebaseFirestore.collection('conversations').doc();

      final RoomChatModel roomChatModel = RoomChatModel(
        id: docRef.id,
        participantsId: [currentActiveUser, otherUserId],
        participantMap: {currentActiveUser: true, otherUserId: true},
        participantNames: participantNames,
        unreadCount: {currentActiveUser: 0, otherUserId: 0},
        lastMessage: null,
        lastMessageAt: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await docRef.set(roomChatModel.toFirestore());

      return Result.success(roomChatModel.toEntity());
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<RoomChatEntity>> getRoomChatByParticipant({
    required String currentUserId,
    required String otherUserId,
  }) async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection('conversations')
          .where('participant_map.$currentUserId', isEqualTo: true)
          .where('participant_map.$otherUserId', isEqualTo: true)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final getData = querySnapshot.docs.first;
        final roomChatModel = RoomChatModel.fromJson(
          getData.data(),
          docId: getData.id,
        );
        return Result.success(roomChatModel.toEntity());
      }

      return Result.error("No chat room found between the specified users");
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Stream<List<RoomChatEntity>> getChats() {
    final currentActiveUser = _firebaseAuth.currentUser?.uid;

    if (currentActiveUser == null) {
      return Stream.error("User not logged in");
    }
    final docRef = _firebaseFirestore
        .collection('conversations')
        .where('participant_map.$currentActiveUser', isEqualTo: true);

    final snapshot = docRef.snapshots();

    final rooms = snapshot.map(
      (snapshot) => snapshot.docs
          .map((e) => RoomChatModel.fromJson(e.data(), docId: e.id).toEntity())
          .toList(),
    );

    return rooms;
  }

  @override
  Future<Result<void>> deleteChat(String chatId) async {
    try {
      await _firebaseFirestore.collection('conversations').doc(chatId).delete();
      return Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<RoomChatEntity>> getRoomChatById(String chatId) async {
    try {
      final docSnapshot = await _firebaseFirestore
          .collection('conversations')
          .doc(chatId)
          .get();

      if (!docSnapshot.exists) {
        return Result.error("Chat room not found");
      }

      final roomChatModel = RoomChatModel.fromJson(
        docSnapshot.data()!,
        docId: docSnapshot.id,
      );

      return Result.success(roomChatModel.toEntity());
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
