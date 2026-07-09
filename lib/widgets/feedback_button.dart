import 'package:flutter/material.dart';

import '../services/feedback_service.dart';
import '../theme/app_theme.dart';

class FeedbackButton extends StatelessWidget {
  final String? screen;

  const FeedbackButton({super.key, this.screen});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      heroTag: 'feedback',
      backgroundColor: AppTheme.gold,
      onPressed: () => showFeedbackDialog(context, screen: screen),
      child: const Icon(Icons.feedback_outlined, color: AppTheme.black),
    );
  }

  static void showFeedbackDialog(BuildContext context, {String? screen}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return _FeedbackSheet(screen: screen);
      },
    );
  }
}

class _FeedbackSheet extends StatefulWidget {
  final String? screen;
  const _FeedbackSheet({this.screen});

  @override
  State<_FeedbackSheet> createState() => _FeedbackSheetState();
}

class _FeedbackSheetState extends State<_FeedbackSheet> {
  final _controller = TextEditingController();
  String _type = 'bug';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24, right: 24, top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.feedback, color: AppTheme.gold),
              const SizedBox(width: 12),
              const Text('Send Feedback',
                  style: TextStyle(color: AppTheme.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close, color: AppTheme.white70),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _typeChip('bug', 'Bug', Icons.bug_report),
              const SizedBox(width: 8),
              _typeChip('suggestion', 'Suggestion', Icons.lightbulb_outline),
              const SizedBox(width: 8),
              _typeChip('other', 'Other', Icons.more_horiz),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            maxLines: 4,
            maxLength: 1000,
            style: const TextStyle(color: AppTheme.white),
            decoration: InputDecoration(
              hintText: 'Describe what happened or what you\'d like improved...',
              hintStyle: const TextStyle(color: AppTheme.white50),
              filled: true,
              fillColor: AppTheme.black.withValues(alpha: 0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppTheme.white.withValues(alpha: 0.1)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.gold,
              foregroundColor: AppTheme.black,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              if (_controller.text.trim().isEmpty) return;
              FeedbackService.submit(
                type: _type,
                message: _controller.text.trim(),
                screen: widget.screen,
              );
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Thank you! Your feedback helps improve ZimHeritage.'),
                  backgroundColor: AppTheme.primaryGreen,
                ),
              );
            },
            child: const Text('Send Feedback', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _typeChip(String value, String label, IconData icon) {
    final selected = _type == value;
    return GestureDetector(
      onTap: () => setState(() => _type = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppTheme.gold : AppTheme.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppTheme.gold : AppTheme.white.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: selected ? AppTheme.black : AppTheme.white70),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: selected ? AppTheme.black : AppTheme.white70,
                fontSize: 13,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
