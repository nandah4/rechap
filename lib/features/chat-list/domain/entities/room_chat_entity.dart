class RoomChatEntity {
  final String? id;
  final List<String>? participantsId;
  final Map<String, bool>? participantMap;
  final Map<String, String>? participantNames;
  final Map<String, int>? unreadCount;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  const RoomChatEntity({
    this.id,
    this.participantsId,
    this.participantMap,
    this.participantNames,
    this.unreadCount,
    this.lastMessage,
    this.lastMessageAt,
    this.updatedAt,
    this.createdAt,
  });
}
