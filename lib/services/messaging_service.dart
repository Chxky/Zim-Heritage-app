import '../models/message.dart';

class MessagingService {
  static final List<Message> _messages = [];

  static Future<void> sendMessage(Message message) async {
    _messages.add(message);
  }

  static Future<List<Message>> getConversation(String userId1, String userId2) async {
    final convo = _messages.where((m) =>
      (m.senderId == userId1 && m.receiverId == userId2) ||
      (m.senderId == userId2 && m.receiverId == userId1)
    ).toList();
    convo.sort((a, b) => a.sentAt.compareTo(b.sentAt));
    return convo;
  }

  static Future<List<ConversationPreview>> getConversations(String userId) async {
    final userMessages = _messages.where((m) => m.senderId == userId || m.receiverId == userId).toList();
    final Map<String, List<Message>> grouped = {};
    for (final msg in userMessages) {
      final otherId = msg.senderId == userId ? msg.receiverId : msg.senderId;
      grouped.putIfAbsent(otherId, () => []).add(msg);
    }

    return grouped.entries.map((entry) {
      final msgs = entry.value;
      msgs.sort((a, b) => b.sentAt.compareTo(a.sentAt));
      final last = msgs.first;
      final otherName = last.senderId == userId ? last.receiverName : last.senderName;
      final unread = msgs.where((m) => m.receiverId == userId && !m.isRead).length;
      return ConversationPreview(
        otherUserId: entry.key,
        otherUserName: otherName,
        lastMessage: last.text,
        lastMessageTime: last.sentAt,
        unreadCount: unread,
      );
    }).toList()
      ..sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
  }

  static Future<int> getUnreadCount(String userId) async {
    return _messages.where((m) => m.receiverId == userId && !m.isRead).length;
  }

  static Future<void> markAsRead(String userId, String otherUserId) async {
    for (int i = 0; i < _messages.length; i++) {
      final m = _messages[i];
      if (m.senderId == otherUserId && m.receiverId == userId && !m.isRead) {
        _messages[i] = Message(
          id: m.id,
          senderId: m.senderId,
          senderName: m.senderName,
          receiverId: m.receiverId,
          receiverName: m.receiverName,
          text: m.text,
          sentAt: m.sentAt,
          isRead: true,
        );
      }
    }
  }

  static void seedDemoData() {
    if (_messages.isNotEmpty) return;
    final now = DateTime.now();
    final demoMessages = [
      Message(
        id: 'msg_1', senderId: 'parent_1', senderName: 'Amai Moyo',
        receiverId: 'teacher_1', receiverName: 'Teacher Chigumira',
        text: 'Good morning, how is Tendai performing in Mathematics?',
        sentAt: now.subtract(const Duration(hours: 2)),
      ),
      Message(
        id: 'msg_2', senderId: 'teacher_1', senderName: 'Teacher Chigumira',
        receiverId: 'parent_1', receiverName: 'Amai Moyo',
        text: 'Tendai is doing well! He scored 78% on the last test. Keep encouraging him.',
        sentAt: now.subtract(const Duration(hours: 1)),
      ),
      Message(
        id: 'msg_3', senderId: 'parent_1', senderName: 'Amai Moyo',
        receiverId: 'teacher_1', receiverName: 'Teacher Chigumira',
        text: 'Thank you! Will there be extra classes before the exam?',
        sentAt: now.subtract(const Duration(minutes: 30)),
        isRead: false,
      ),
    ];
    _messages.addAll(demoMessages);
  }
}
