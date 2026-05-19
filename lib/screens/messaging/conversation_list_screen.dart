import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/message.dart';
import '../../services/messaging_service.dart';
import '../../widgets/glass_card.dart';
import 'chat_screen.dart';

class ConversationListScreen extends StatefulWidget {
  final String currentUserId;
  final String currentUserName;

  const ConversationListScreen({
    super.key,
    required this.currentUserId,
    required this.currentUserName,
  });

  @override
  State<ConversationListScreen> createState() => _ConversationListScreenState();
}

class _ConversationListScreenState extends State<ConversationListScreen> {
  List<ConversationPreview> _conversations = [];

  @override
  void initState() {
    super.initState();
    MessagingService.seedDemoData();
    _loadConversations();
  }

  Future<void> _loadConversations() async {
    final convos = await MessagingService.getConversations(widget.currentUserId);
    if (mounted) setState(() => _conversations = convos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.surfaceDark, AppTheme.surfaceMid],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: _conversations.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.chat_bubble_outline, size: 64, color: AppTheme.white30),
                  const SizedBox(height: 16),
                  const Text('No conversations yet',
                    style: TextStyle(color: AppTheme.white60, fontSize: 18)),
                  const SizedBox(height: 8),
                  const Text('Start a conversation with a teacher or parent',
                    style: TextStyle(color: AppTheme.white30)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _conversations.length,
              itemBuilder: (ctx, i) {
                final convo = _conversations[i];
                return GlassCard(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(16),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        currentUserId: widget.currentUserId,
                        currentUserName: widget.currentUserName,
                        otherUserId: convo.otherUserId,
                        otherUserName: convo.otherUserName,
                      ),
                    )).then((_) => _loadConversations());
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppTheme.greenBright.withValues(alpha: 0.2),
                        child: Text(
                          convo.otherUserName.isNotEmpty ? convo.otherUserName[0].toUpperCase() : '?',
                          style: const TextStyle(color: AppTheme.greenBright, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(convo.otherUserName,
                              style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.white, fontSize: 15)),
                            const SizedBox(height: 2),
                            Text(convo.lastMessage,
                              style: const TextStyle(color: AppTheme.white60, fontSize: 13),
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${convo.lastMessageTime.hour.toString().padLeft(2, '0')}:${convo.lastMessageTime.minute.toString().padLeft(2, '0')}',
                            style: const TextStyle(color: AppTheme.white30, fontSize: 11)),
                          if (convo.unreadCount > 0)
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.greenBright,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text('${convo.unreadCount}',
                                style: const TextStyle(color: AppTheme.white, fontSize: 11, fontWeight: FontWeight.bold)),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
