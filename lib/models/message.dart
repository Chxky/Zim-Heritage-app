class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String receiverId;
  final String receiverName;
  final String text;
  final DateTime sentAt;
  final bool isRead;

  const Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.receiverName,
    required this.text,
    required this.sentAt,
    this.isRead = false,
  });

  factory Message.fromMap(Map<String, dynamic> map, String id) {
    return Message(
      id: id,
      senderId: map['senderId'] as String? ?? '',
      senderName: map['senderName'] as String? ?? '',
      receiverId: map['receiverId'] as String? ?? '',
      receiverName: map['receiverName'] as String? ?? '',
      text: map['text'] as String? ?? '',
      sentAt: map['sentAt'] is DateTime
          ? map['sentAt'] as DateTime
          : DateTime.tryParse(map['sentAt']?.toString() ?? '') ?? DateTime.now(),
      isRead: map['isRead'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'text': text,
      'sentAt': sentAt,
      'isRead': isRead,
    };
  }
}

class ConversationPreview {
  final String otherUserId;
  final String otherUserName;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;

  const ConversationPreview({
    required this.otherUserId,
    required this.otherUserName,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
  });
}
