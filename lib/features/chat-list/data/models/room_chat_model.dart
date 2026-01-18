import 'package:cloud_firestore/cloud_firestore.dart';

class RoomChatModel {
  final String id;
  final List<String> participantsId;
  final Map<String, bool> participantMap;
  final Map<String, String> participantNames;

  final Map<String, int> unreadCount;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  const RoomChatModel({
    required this.id,
    required this.participantsId,
    required this.participantMap,
    required this.participantNames,
    required this.unreadCount,
    this.lastMessage,
    this.lastMessageAt,
    this.updatedAt,
    this.createdAt,
  });

  factory RoomChatModel.fromJson(Map<String, dynamic> json, {String? docId}) {
    return RoomChatModel(
      id: docId ?? json['id'] as String,
      participantsId: List<String>.from(json['participants_id']),
      participantMap: Map<String, bool>.from(json['participant_map']),
      participantNames: Map<String, String>.from(
        json['participant_names'] ?? {},
      ),
      unreadCount: Map<String, int>.from(json['unread_count'] ?? {}),
      lastMessage: json['last_message'],
      createdAt: (json['created_at'] as Timestamp?)?.toDate(),
      updatedAt: (json['updated_at'] as Timestamp?)?.toDate(),
      lastMessageAt: (json['last_message_at'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'participants_id': participantsId,
      'participant_map': participantMap,
      'participant_names': participantNames,
      'unread_count': unreadCount,
      'last_message': lastMessage,
      'last_message_at': lastMessageAt,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    };
  }
}
