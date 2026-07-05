import 'package:flutter/material.dart';

import '../../data/book_data.dart';
import '../../data/ecd_visual_aids.dart';
import '../../data/lesson_content.dart';
import '../../models/book.dart';
import '../../models/subject.dart';
import '../../models/user.dart';
import '../../theme/app_theme.dart';
import '../../theme/subject_themes.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/subject_scaffold.dart';
import 'lesson_viewer_screen.dart';

class TopicDetailScreen extends StatelessWidget {
  final Topic topic;
  final Subject subject;
  final User user;

  const TopicDetailScreen({
    super.key,
    required this.topic,
    required this.subject,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse(subject.color));
    final books = getBooksForTopic(subject.id, user.gradeLevel, topic.name);
    final subTheme = SubjectThemes.forSubjectId(subject.id);
    final accent = subTheme?.accentColor ?? color;

    return SubjectScaffold(
      subjectId: subject.id,
      title: topic.name,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    accent.withValues(alpha: 0.12),
                    accent.withValues(alpha: 0.04),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: accent.withValues(alpha: 0.2), width: 1.5),
                boxShadow: [
                  BoxShadow(color: accent.withValues(alpha: 0.1), blurRadius: 20, offset: const Offset(0, 8)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(Icons.menu_book, color: accent, size: 28),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(subject.name,
                              style: TextStyle(fontSize: 13, color: accent.withValues(alpha: 0.7))),
                            const SizedBox(height: 2),
                            Text(topic.name,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.white)),
                          ],
                        ),
                      ),
                      SubjectGlowBadge(label: topic.term, color: AppTheme.gold),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(topic.description,
                    style: const TextStyle(fontSize: 14, color: AppTheme.white80, height: 1.5)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Start Lesson Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  final lessons = getLessonsForTopic(topic.id);
                  if (lessons.isNotEmpty) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => LessonViewerScreen(
                        subjectId: subject.id,
                        topicId: topic.id,
                        topicName: topic.name,
                        subject: subject,
                        user: user,
                      ),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Lesson content coming soon for this topic!'),
                        backgroundColor: AppTheme.gold),
                    );
                  }
                },
                icon: const Icon(Icons.play_circle_fill),
                label: Text('Start Lesson - ${topic.name}'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: accent,
                  foregroundColor: AppTheme.white,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Icon(Icons.list_alt, color: accent, size: 20),
                const SizedBox(width: 8),
                const Text('Subtopics',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
              ],
            ),
            const SizedBox(height: 12),
            ...topic.subtopics.map((st) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GlassCard(
                padding: const EdgeInsets.all(14),
                borderColor: accent.withValues(alpha: 0.1),
                child: Row(
                  children: [
                    Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Icon(Icons.check, color: accent, size: 18)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(st,
                        style: const TextStyle(fontSize: 14, color: AppTheme.white80)),
                    ),
                  ],
                ),
              ),
            )),

            if (_shouldShowVisualAids(user.gradeLevel)) ...[
              const SizedBox(height: 24),
              Row(
                children: [
                  Icon(Icons.image, color: accent, size: 20),
                  const SizedBox(width: 8),
                  const Text('Learning Pictures',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
                ],
              ),
              const SizedBox(height: 12),
              ...getVisualAidsForGrade(user.gradeLevel).map((va) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _buildVisualAidCard(va, accent),
              )),
              if (getVisualAidsForGrade(user.gradeLevel).isEmpty)
                GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.image, size: 24, color: AppTheme.white30),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Visual aids coming soon',
                              style: TextStyle(color: AppTheme.white60, fontSize: 13)),
                            Text('Pictures for ${user.gradeLevel} will be added in the next update',
                              style: const TextStyle(color: AppTheme.white30, fontSize: 11)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],

            const SizedBox(height: 24),
            Row(
              children: [
                Icon(Icons.library_books, color: accent, size: 20),
                const SizedBox(width: 8),
                const Text('Recommended Books',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('${books.length}',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: accent)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (books.isEmpty)
              GlassCard(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    const Icon(Icons.menu_book, size: 40, color: AppTheme.white30),
                    const SizedBox(height: 12),
                    const Text('Books coming soon',
                      style: TextStyle(color: AppTheme.white60, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text('Check back for learning materials on ${topic.name}',
                      style: const TextStyle(color: AppTheme.white30, fontSize: 12)),
                  ],
                ),
              )
            else
              ...books.map((book) => _buildBookCard(book, accent)),
          ],
        ),
      ),
    );
  }

  Widget _buildBookCard(Book book, Color subjectColor) {
    IconData typeIcon;
    Color typeColor;
    switch (book.type) {
      case 'textbook':
        typeIcon = Icons.import_contacts;
        typeColor = AppTheme.primaryGreen;
        break;
      case 'set_book':
        typeIcon = Icons.auto_stories;
        typeColor = AppTheme.gold;
        break;
      case 'reference':
        typeIcon = Icons.find_in_page;
        typeColor = Colors.blue;
        break;
      case 'activity_book':
        typeIcon = Icons.handyman;
        typeColor = Colors.orange;
        break;
      case 'storybook':
        typeIcon = Icons.child_care;
        typeColor = Colors.pink;
        break;
      default:
        typeIcon = Icons.book;
        typeColor = AppTheme.white60;
    }

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      borderColor: subjectColor.withValues(alpha: 0.15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: typeColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(typeIcon, color: typeColor, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(book.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppTheme.white)),
                const SizedBox(height: 4),
                Text(book.author,
                  style: const TextStyle(fontSize: 12, color: AppTheme.gold)),
                const SizedBox(height: 6),
                Text(book.description,
                  style: const TextStyle(fontSize: 12, color: AppTheme.white60, height: 1.4)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: typeColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: typeColor.withValues(alpha: 0.2)),
                  ),
                  child: Text(_typeLabel(book.type),
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: typeColor)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _typeLabel(String type) {
    switch (type) {
      case 'textbook': return 'TEXTBOOK';
      case 'set_book': return 'SET BOOK';
      case 'reference': return 'REFERENCE';
      case 'activity_book': return 'ACTIVITY BOOK';
      case 'storybook': return 'STORYBOOK';
      default: return type.toUpperCase();
    }
  }

  bool _shouldShowVisualAids(String grade) {
    return grade == 'ECD A' || grade == 'ECD B' || grade == 'Grade 1' || grade == 'Grade 2';
  }

  Widget _buildVisualAidCard(VisualAid va, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      borderColor: color.withValues(alpha: 0.12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withValues(alpha: 0.15)),
            ),
            child: Icon(Icons.image_search, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(va.title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.white)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.gold.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(va.category,
                        style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppTheme.gold)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(va.description, style: const TextStyle(fontSize: 11, color: AppTheme.white60)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 4, runSpacing: 4,
                  children: va.labels.map((l) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(l, style: TextStyle(fontSize: 10, color: color)),
                  )).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
