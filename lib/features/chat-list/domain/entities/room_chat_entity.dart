

class RoomChatEntity {
  final List<String>? participantsId;
  final Map<String, bool>? participantMap;
  final Map<String, int>? unreadCount;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  const RoomChatEntity({
    this.participantsId,
    this.participantMap,
    this.unreadCount,
    this.lastMessage,
    this.lastMessageAt,
    this.updatedAt,
    this.createdAt,
  });
}
