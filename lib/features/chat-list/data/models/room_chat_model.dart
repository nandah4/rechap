import 'package:cloud_firestore/cloud_firestore.dart';

class RoomChatModel {
  final List<String> participantsId;
  final Map<String, bool> participantMap;
  final Map<String, int> unreadCount;
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
      participantsId: List<String>.from(json['participants_id']),
      participantMap: Map<String, bool>.from(json['participant_map']),
      unreadCount: Map<String, int>.from(json['unread_count']),
      lastMessage: json['last_message'],
      createdAt: (json['created_at'] as Timestamp?)?.toDate(),
      updatedAt: (json['updated_at'] as Timestamp?)?.toDate(),
      lastMessageAt: (json['last_message_at'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'participants': participantsId,
      'participant_map': participantMap,
      'unread_count': unreadCount,
      'last_message': lastMessage,
      'last_message_at': lastMessageAt,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    };
  }
}
