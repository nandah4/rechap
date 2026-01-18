import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rechap/core/common/result.dart';
import 'package:rechap/features/chat/data/mapper/message_mapper.dart';
import 'package:rechap/features/chat/data/model/message_model.dart';
import 'package:rechap/features/chat/domain/entities/message_entity.dart';
import 'package:rechap/features/chat/domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final FirebaseFirestore _firebaseFirestore;

  MessageRepositoryImpl({required FirebaseFirestore firebaseFirestore})
    : _firebaseFirestore = firebaseFirestore;

  @override
  Future<Result<void>> sendMessage(
    MessageEntity message, {
    required String conversationId,
    required String receiverId,
  }) async {
    try {
      final conversationRef = _firebaseFirestore
          .collection('conversations')
          .doc(conversationId);

      // Use transaction for atomicity
      await _firebaseFirestore.runTransaction((trx) async {
        // Create message document
        final messageRef = conversationRef.collection('messages').doc();
        trx.set(messageRef, message.toModel().toFirestore());

        // Update conversation's last_message and unread_count
        trx.update(conversationRef, {
          'last_message': message.text,
          'last_message_at': message.createdAt,
          'updated_at': message.createdAt,
          'unread_count.$receiverId': FieldValue.increment(1),
        });

      });

      return Result.success(null);
    } catch (e) {
      return Result.error("Failed to send message: ${e.toString()}");
    }
  }

  @override
  Stream<List<MessageEntity>> getMessages(String conversationId) {
    try {
      final snapshot = _firebaseFirestore
          .collection('conversations')
          .doc(conversationId)
          .collection('messages')
          .orderBy('created_at', descending: false)
          .snapshots();
      return snapshot.map(
        (snaphot) => snaphot.docs
            .map((doc) => MessageModel.fromJson(doc.data()).toEntity())
            .toList(),
      );
    } catch (e) {
      return Stream.error(e);
    }
  }

  @override
  Future<Result<void>> markMessageAsRead(
    String conversationId,
    String readerId,
  ) async {
    try {
      final roomRef = _firebaseFirestore
          .collection('conversations')
          .doc(conversationId);

      await _firebaseFirestore.runTransaction((trx) async {
        trx.update(roomRef, {
          'unread_count.$readerId': 0,
        });
      });

      return Result.success(null);
    } catch (e) {
      return Result.error("Failed to mark message as read: ${e.toString()}");
    }
  }
}
