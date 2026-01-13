import 'package:cloud_firestore/cloud_firestore.dart';

class RoomChatModel {
  final ParticipantUserId participantsId;
  final ParticipantMap participantMap;
  final UnreadCount unreadCount;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  const RoomChatModel({
    required this.participantsId,
    required this.participantMap,
    required this.unreadCount,
    this.lastMessage,
    this.lastMessageAt,
    this.updatedAt,
    this.createdAt,
  });

  factory RoomChatModel.fromJson(Map<String, dynamic> json) {
    return RoomChatModel(
      participantsId: json['participants_id'],
      participantMap: json['participant_map'],
      unreadCount: json['unread_count'],
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: (json['updated_at'] as Timestamp).toDate(),
      lastMessage: json['last_message'],
      lastMessageAt: (json['last_message_at'] as Timestamp).toDate(),
    );
  }
}

class ParticipantUserId {
  final String user1;
  final String user2;

  const ParticipantUserId({required this.user1, required this.user2});
}

class ParticipantMap {
  final bool user1;
  final bool user2;

  const ParticipantMap({required this.user1, required this.user2});
}

class UnreadCount {
  final int user1;
  final int user2;

  const UnreadCount({required this.user1, required this.user2});
}
