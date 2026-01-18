import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String? id;
  final String senderId;
  final String text;
  final String type;
  final DateTime createdAt;

  const MessageModel({
    this.id,
    required this.senderId,
    required this.text,
    required this.type,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json, {String? docId}) {
    return MessageModel(
      id: docId ?? json['id'] as String?,
      senderId: json['sender_id'] as String,
      text: json['text'] as String,
      type: json['type'] as String,
      createdAt: (json['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'sender_id': senderId,
      'text': text,
      'type': type,
      'created_at': FieldValue.serverTimestamp(),
    };
  }
}
