class MessageEntity {
  final String? id;
  final String senderId;
  final String text;
  final String type;
  final List<String> readBy;
  final DateTime createdAt;

  const MessageEntity({
    this.id,
    required this.senderId,
    required this.text,
    required this.type,
    required this.readBy,
    required this.createdAt,
  });
}
