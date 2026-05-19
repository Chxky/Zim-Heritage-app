// screens/student/past_exams_screen.dart
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../theme/subject_themes.dart';
import '../../models/lesson.dart';
import '../../models/user.dart';
import '../../data/zimbabwe_curriculum.dart';
import '../../data/past_exam_questions.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/subject_scaffold.dart';

class PastExamsScreen extends StatefulWidget {
  final User user;
  final String? subjectId;

  const PastExamsScreen({super.key, required this.user, this.subjectId});

  @override
  State<PastExamsScreen> createState() => _PastExamsScreenState();
}

class _PastExamsScreenState extends State<PastExamsScreen> {
  String? _selectedSubject;
  String? _selectedYear;
  bool _showAnswers = false;
  List<PastExamQuestion> _filteredQuestions = [];

  @override
  void initState() {
    super.initState();
    _filteredQuestions = getPastQuestionsForGrade(widget.user.gradeLevel);
  }

  SubjectThemeData? get _subTheme => widget.subjectId != null
      ? SubjectThemes.forSubjectId(widget.subjectId!)
      : null;

  Color get _accent => _subTheme?.accentColor ?? AppTheme.gold;

  @override
  Widget build(BuildContext context) {
    final subjects = getSubjectsForGradeAndCurriculum(widget.user.gradeLevel, widget.user.curriculum);
    final years = getAvailableYears();
    final gradeBand = extractGradeBand(widget.user.gradeLevel);
    final accent = _accent;

    if (widget.user.gradeLevel.startsWith('ECD')) {
      return SubjectBackground(
        subjectId: widget.subjectId,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.auto_awesome, size: 64, color: AppTheme.white30),
              SizedBox(height: 16),
              Text('Past exam questions start from Grade 5',
                style: TextStyle(fontSize: 15, color: AppTheme.white60)),
              SizedBox(height: 8),
            ],
          ),
        ),
      );
    }

    if (_filteredQuestions.isEmpty) {
      return SubjectBackground(
        subjectId: widget.subjectId,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.history_edu, size: 64, color: AppTheme.white30),
              SizedBox(height: 16),
              Text('No past exam questions yet',
                style: TextStyle(fontSize: 15, color: AppTheme.white60)),
              SizedBox(height: 8),
            ],
          ),
        ),
      );
    }

    return SubjectBackground(
      subjectId: widget.subjectId,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlassCard(
              padding: const EdgeInsets.all(16),
              borderColor: accent.withValues(alpha: 0.15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _selectedSubject,
                          decoration: InputDecoration(
                            labelText: 'Subject',
                            filled: true,
                            fillColor: AppTheme.surfaceMid,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                          dropdownColor: AppTheme.surfaceDark,
                          items: [
                            const DropdownMenuItem(value: null, child: Text('All Subjects', style: TextStyle(color: AppTheme.white60))),
                            ...subjects.map((s) => DropdownMenuItem(value: s.id, child: Text(s.name, style: const TextStyle(color: AppTheme.white)))),
                          ],
                          onChanged: (v) => setState(() {
                            _selectedSubject = v;
                            _applyFilters();
                          }),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _selectedYear,
                          decoration: InputDecoration(
                            labelText: 'Year',
                          filled: true,
                          fillColor: AppTheme.surfaceMid,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        dropdownColor: AppTheme.surfaceDark,
                        items: [
                          const DropdownMenuItem(value: null, child: Text('All Years', style: TextStyle(color: AppTheme.white60))),
                          ...years.map((y) => DropdownMenuItem(value: y, child: Text(y, style: const TextStyle(color: AppTheme.white)))),
                        ],
                        onChanged: (v) => setState(() {
                          _selectedYear = v;
                          _applyFilters();
                        }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Icon(Icons.history_edu, color: AppTheme.gold, size: 20),
              const SizedBox(width: 8),
              Text('${_filteredQuestions.length} Questions Available',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.white)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.gold.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.school, size: 12, color: AppTheme.gold),
                    const SizedBox(width: 4),
                    Text(gradeBand, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.gold)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ..._filteredQuestions.map((q) => _buildExamCard(q)),
        ],
      ),
    ),
  );
  }

  void _applyFilters() {
    var questions = getPastQuestionsForGrade(widget.user.gradeLevel);
    if (_selectedSubject != null) {
      questions = questions.where((q) => q.subjectId == _selectedSubject).toList();
    }
    if (_selectedYear != null) {
      questions = questions.where((q) => q.year == _selectedYear).toList();
    }
    _filteredQuestions = questions;
  }

  Widget _buildExamCard(PastExamQuestion eq) {
    final subjects = getSubjectsForGradeAndCurriculum(widget.user.gradeLevel, widget.user.curriculum);
    final sub = subjects.where((s) => s.id == eq.subjectId).firstOrNull;
    final color = sub != null ? Color(int.parse(sub.color)) : AppTheme.greenBright;

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      borderColor: color.withValues(alpha: 0.12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.quiz, color: color, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(sub?.name ?? eq.subjectId,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppTheme.white)),
                    Text(eq.topic, style: const TextStyle(fontSize: 11, color: AppTheme.white50)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppTheme.gold.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('${eq.marks} marks',
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.gold)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.surfaceMid,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(eq.question,
              style: const TextStyle(fontSize: 13, color: AppTheme.white80, height: 1.5)),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('${eq.year} ${eq.term}',
                  style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('Paper ${eq.paper}',
                  style: const TextStyle(fontSize: 10, color: AppTheme.primaryGreen, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          if (eq.answer != null) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => setState(() => _showAnswers = !_showAnswers),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _showAnswers ? AppTheme.greenBright.withValues(alpha: 0.06) : AppTheme.white10,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      _showAnswers ? Icons.visibility_off : Icons.visibility,
                      size: 14, color: AppTheme.gold,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _showAnswers ? 'Hide Answer' : 'Show Answer',
                      style: const TextStyle(fontSize: 12, color: AppTheme.gold, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            if (_showAnswers) ...[
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.greenBright.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.greenBright.withValues(alpha: 0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, size: 14, color: AppTheme.greenBright),
                        const SizedBox(width: 6),
                        Text('Answer', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.greenBright, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(eq.answer!, style: const TextStyle(fontSize: 12, color: AppTheme.white80)),
                    if (eq.explanation != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.lightbulb, size: 14, color: AppTheme.gold),
                          const SizedBox(width: 6),
                          Text('Explanation', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.gold, fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(eq.explanation!, style: const TextStyle(fontSize: 12, color: AppTheme.white60, fontStyle: FontStyle.italic)),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
