class MessageEntity {
  final String id;
  final String content;
  final String senderId;
  final String receiverId;
  final String type;
  final String timestamp;

  MessageEntity({
    required this.id,
    required this.content,
    required this.senderId,
    required this.receiverId,
    required this.type,
    required this.timestamp,
  });
}
