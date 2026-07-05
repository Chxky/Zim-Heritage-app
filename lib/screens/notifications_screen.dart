import 'package:flutter/material.dart';

import '../models/user.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';

class NotificationItem {
  final String title;
  final String description;
  final String timestamp;
  final IconData icon;
  final Color color;

  const NotificationItem({
    required this.title,
    required this.description,
    required this.timestamp,
    required this.icon,
    required this.color,
  });
}

class NotificationsScreen extends StatelessWidget {
  final User user;

  const NotificationsScreen({super.key, required this.user});

  static const List<NotificationItem> _sampleNotifications = [
    NotificationItem(
      title: 'New homework assigned',
      description: 'Your teacher has posted a new homework assignment for Mathematics.',
      timestamp: '2 hours ago',
      icon: Icons.assignment,
      color: Colors.deepOrange,
    ),
    NotificationItem(
      title: 'Homework reviewed by teacher',
      description: 'Your Science homework has been reviewed. Check your feedback.',
      timestamp: '1 day ago',
      icon: Icons.rate_review,
      color: AppTheme.greenBright,
    ),
    NotificationItem(
      title: 'Upcoming parent-teacher meeting',
      description: 'Parent-teacher meeting scheduled for next Friday at 10:00 AM.',
      timestamp: '3 days ago',
      icon: Icons.event,
      color: Colors.blueAccent,
    ),
    NotificationItem(
      title: 'Progress report available',
      description: 'Your term progress report is now available for viewing.',
      timestamp: '5 days ago',
      icon: Icons.trending_up,
      color: AppTheme.gold,
    ),
    NotificationItem(
      title: 'New subject materials added',
      description: 'Additional reading materials have been added to History.',
      timestamp: '1 week ago',
      icon: Icons.library_books,
      color: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.surfaceDark, AppTheme.surfaceMid],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        actions: [
          if (_sampleNotifications.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              tooltip: 'Clear all',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All notifications cleared')),
                );
              },
            ),
        ],
      ),
      body: _sampleNotifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _sampleNotifications.length,
              itemBuilder: (context, index) {
                return _buildNotificationCard(context, _sampleNotifications[index]);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: AppTheme.white10,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.notifications_none, size: 64, color: AppTheme.white30),
          ),
          const SizedBox(height: 20),
          const Text(
            'No notifications',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.white),
          ),
          const SizedBox(height: 8),
          const Text(
            'You\'re all caught up!',
            style: TextStyle(color: AppTheme.white50),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, NotificationItem item) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: item.color.withValues(alpha: 0.2)),
            ),
            child: Icon(item.icon, color: item.color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.white),
                      ),
                    ),
                    Text(
                      item.timestamp,
                      style: const TextStyle(color: AppTheme.white50, fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  style: const TextStyle(color: AppTheme.white60, fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
