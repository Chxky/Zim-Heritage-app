import 'package:flutter/material.dart';

import '../../data/lesson_content.dart';
import '../../data/past_exam_questions.dart';
import '../../models/lesson.dart';
import '../../models/subject.dart';
import '../../models/user.dart';
import '../../theme/app_theme.dart';
import '../../theme/subject_themes.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/subject_scaffold.dart';

class LessonViewerScreen extends StatefulWidget {
  final String subjectId;
  final String topicId;
  final String topicName;
  final Subject subject;
  final User user;

  const LessonViewerScreen({
    super.key,
    required this.subjectId,
    required this.topicId,
    required this.topicName,
    required this.subject,
    required this.user,
  });

  @override
  State<LessonViewerScreen> createState() => _LessonViewerScreenState();
}

class _LessonViewerScreenState extends State<LessonViewerScreen> {
  late List<Lesson> _lessons;
  int _currentLessonIndex = 0;
  bool _showAnswers = false;

  @override
  void initState() {
    super.initState();
    _lessons = getLessonsForTopic(widget.topicId);
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse(widget.subject.color));

    return SubjectScaffold(
      subjectId: widget.subject.id,
      title: widget.topicName,
      body: _lessons.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.menu_book, size: 64),
                  const SizedBox(height: 16),
                  Text('Lesson content coming soon',
                    style: TextStyle(fontSize: 18, color: _accent)),
                  const SizedBox(height: 24),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildLessonContent(color),
            ),
    );
  }

  SubjectThemeData? get _subTheme => SubjectThemes.forSubjectId(widget.subject.id);

  Color get _accent => _subTheme?.accentColor ?? color;

  Color get color => Color(int.parse(widget.subject.color));

  Widget _buildLessonContent(Color color) {
    final lesson = _lessons[_currentLessonIndex];
    final accent = _accent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_lessons.length > 1)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.menu_book, size: 14, color: accent),
                const SizedBox(width: 6),
                Text('Lesson ${_currentLessonIndex + 1} of ${_lessons.length}',
                  style: TextStyle(color: accent, fontSize: 13, fontWeight: FontWeight.w500)),
              ],
            ),
          ),

        GlassCard(
          padding: const EdgeInsets.all(20),
          borderColor: accent.withValues(alpha: 0.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.auto_stories, color: accent, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(lesson.title,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: accent)),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        Row(
          children: [
            Icon(Icons.flag, color: accent, size: 18),
            const SizedBox(width: 8),
            const Text('What You Will Learn',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.white)),
          ],
        ),
        const SizedBox(height: 8),
        ...lesson.objectives.map((obj) => Padding(
          padding: const EdgeInsets.only(bottom: 4, left: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 8, height: 8,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(obj, style: const TextStyle(fontSize: 14, color: AppTheme.white80))),
            ],
          ),
        )),
        const SizedBox(height: 20),
        const Divider(height: 1),

        ...lesson.sections.map((section) => Padding(
          padding: const EdgeInsets.only(top: 20),
          child: _buildSection(section, accent),
        )),
        const SizedBox(height: 24),
        const Divider(height: 1),
        const SizedBox(height: 20),

        Row(
          children: [
            Icon(Icons.lightbulb, color: accent, size: 18),
            const SizedBox(width: 8),
            const Text('Key Points to Remember',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.white)),
          ],
        ),
        const SizedBox(height: 8),
        ...lesson.keyPoints.map((kp) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: GlassCard(
            padding: const EdgeInsets.all(10),
            borderColor: accent.withValues(alpha: 0.1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, size: 16, color: accent),
                const SizedBox(width: 8),
                Expanded(child: Text(kp, style: const TextStyle(fontSize: 13, color: AppTheme.white80))),
              ],
            ),
          ),
        )),
        const SizedBox(height: 24),

        if (lesson.practiceQuestions.isNotEmpty) ...[
          Row(
            children: [
              Icon(Icons.quiz, color: accent, size: 18),
              const SizedBox(width: 8),
              const Text('Practice Questions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.white)),
            ],
          ),
          const SizedBox(height: 8),
          ...lesson.practiceQuestions.asMap().entries.map((entry) {
            final i = entry.key;
            final q = entry.value;
            return GlassCard(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              borderColor: accent.withValues(alpha: 0.12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Question ${i + 1}: ${q.question}',
                    style: const TextStyle(fontSize: 14, color: AppTheme.white, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  if (_showAnswers) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.check_circle, size: 14, color: accent),
                              const SizedBox(width: 6),
                              Text('Answer:', style: TextStyle(fontWeight: FontWeight.bold, color: accent, fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(q.answer, style: const TextStyle(fontSize: 13, color: AppTheme.white80)),
                          const SizedBox(height: 8),
                          const Row(
                            children: [
                              Icon(Icons.lightbulb, size: 14, color: AppTheme.gold),
                              SizedBox(width: 6),
                              Text('Explanation:', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.gold, fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(q.explanation, style: const TextStyle(fontSize: 12, color: AppTheme.white60)),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            );
          }),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => setState(() => _showAnswers = !_showAnswers),
              icon: Icon(_showAnswers ? Icons.visibility_off : Icons.visibility),
              label: Text(_showAnswers ? 'Hide Answers' : 'Show Answers'),
            ),
          ),
        ],
        const SizedBox(height: 24),

        if (_lessons.length > 1) ...[
          Row(
            children: [
              if (_currentLessonIndex > 0)
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => setState(() { _currentLessonIndex--; _showAnswers = false; }),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Previous'),
                  ),
                ),
              if (_currentLessonIndex > 0 && _currentLessonIndex < _lessons.length - 1)
                const SizedBox(width: 12),
              if (_currentLessonIndex < _lessons.length - 1)
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => setState(() { _currentLessonIndex++; _showAnswers = false; }),
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Next Lesson'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      foregroundColor: AppTheme.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
        ],

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withValues(alpha: 0.15)),
          ),
          child: Row(
            children: [
              Icon(Icons.library_books, size: 16, color: accent),
              const SizedBox(width: 8),
              Text('References: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: accent)),
              Expanded(
                child: Text(lesson.references.join(', '),
                  style: const TextStyle(fontSize: 12, color: AppTheme.white60)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _showPastExams(context, accent),
                icon: const Icon(Icons.history_edu),
                label: const Text('View Past Exam Questions'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: accent,
                  side: BorderSide(color: accent),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildSection(LessonSection section, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.article, color: color, size: 18),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(section.heading,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.white)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(section.content,
          style: const TextStyle(fontSize: 14, color: AppTheme.white80, height: 1.6)),
        if (section.bulletPoints.isNotEmpty) ...[
          const SizedBox(height: 8),
          ...section.bulletPoints.map((bp) => Padding(
            padding: const EdgeInsets.only(bottom: 2, left: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('  •  ', style: TextStyle(color: AppTheme.gold, fontSize: 14)),
                Expanded(child: Text(bp, style: const TextStyle(fontSize: 13, color: AppTheme.white70, height: 1.4))),
              ],
            ),
          )),
        ],
        if (section.example != null) ...[
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.gold.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.gold.withValues(alpha: 0.15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.auto_awesome, size: 14, color: AppTheme.gold),
                    SizedBox(width: 6),
                    Text('Example:', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.gold, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(section.example!, style: const TextStyle(fontSize: 13, color: AppTheme.white80, fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ],
    );
  }

  void _showPastExams(BuildContext context, Color accent) {
    final exams = getPastQuestionsForSubjectAndGrade(widget.subjectId, widget.user.gradeLevel);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              accent.withValues(alpha: 0.15),
              AppTheme.surfaceDark,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: AppTheme.white30,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.history_edu, color: accent, size: 22),
                  const SizedBox(width: 8),
                  const Text('Past Exam Questions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: exams.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 48, color: AppTheme.white30),
                          SizedBox(height: 12),
                          Text('No past exam questions yet',
                            style: TextStyle(fontSize: 15, color: AppTheme.white60)),
                          Text('Check back soon for added content',
                            style: TextStyle(fontSize: 12, color: AppTheme.white30)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: exams.length,
                      itemBuilder: (context, index) {
                        final eq = exams[index];
                        return GlassCard(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          borderColor: accent.withValues(alpha: 0.12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: accent.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text('${eq.year} ${eq.term}',
                                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: accent)),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: AppTheme.gold.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text('Paper ${eq.paper}',
                                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.gold)),
                                  ),
                                  const Spacer(),
                                  Text('${eq.marks} marks',
                                    style: const TextStyle(fontSize: 12, color: AppTheme.white50, fontWeight: FontWeight.w500)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(eq.question,
                                style: const TextStyle(fontSize: 13, color: AppTheme.white, height: 1.5)),
                              if (eq.answer != null) ...[
                                const SizedBox(height: 8),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: accent.withValues(alpha: 0.06),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.check_circle, size: 14, color: accent),
                                          const SizedBox(width: 6),
                                          Text('Suggested Answer',
                                            style: TextStyle(fontWeight: FontWeight.bold, color: accent, fontSize: 11)),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(eq.answer!, style: const TextStyle(fontSize: 12, color: AppTheme.white70)),
                                      if (eq.explanation != null) ...[
                                        const SizedBox(height: 6),
                                        const Row(
                                          children: [
                                            Icon(Icons.lightbulb, size: 14, color: AppTheme.gold),
                                            SizedBox(width: 6),
                                            Text('Tip',
                                              style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.gold, fontSize: 11)),
                                          ],
                                        ),
                                        const SizedBox(height: 2),
                                        Text(eq.explanation!, style: const TextStyle(fontSize: 12, color: AppTheme.white50, fontStyle: FontStyle.italic)),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
