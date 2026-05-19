// screens/student/submit_homework_screen.dart
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/user.dart';
import '../../models/homework.dart';
import '../../models/submission.dart';
import '../../services/submission_repository.dart';
import '../../services/gamification_service.dart';
import '../../services/gemini_service.dart';
import '../../widgets/glass_card.dart';

class SubmitHomeworkScreen extends StatefulWidget {
  final Homework homework;
  final User user;

  const SubmitHomeworkScreen({
    super.key,
    required this.homework,
    required this.user,
  });

  @override
  State<SubmitHomeworkScreen> createState() => _SubmitHomeworkScreenState();
}

class _SubmitHomeworkScreenState extends State<SubmitHomeworkScreen>
    with SingleTickerProviderStateMixin {
  int _currentQuestion = 0;
  final Map<String, String> _answers = {};
  final Map<String, TextEditingController> _controllers = {};
  bool _isSubmitting = false;
  bool _isAutoGrading = false;
  bool _submitted = false;
  int _totalScore = 0;
  int _maxScore = 0;
  final Map<String, ({int score, int maxScore, String feedback})> _gradeResults = {};

  late AnimationController _celebrationController;
  late Animation<double> _celebrationScale;

  @override
  void initState() {
    super.initState();
    for (final q in widget.homework.questions) {
      _controllers[q.id] = TextEditingController();
    }
    _maxScore = widget.homework.questions.fold(0, (sum, q) => sum + q.marks);

    _celebrationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _celebrationScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _celebrationController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    _celebrationController.dispose();
    super.dispose();
  }

  bool get _allAnswered {
    return widget.homework.questions.every((q) {
      final answer = _controllers[q.id]?.text.trim() ?? '';
      return answer.isNotEmpty;
    });
  }

  Future<void> _submitHomework() async {
    if (!_allAnswered) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.warning, color: Colors.white),
              SizedBox(width: 8),
              Text('Please answer all questions before submitting.'),
            ],
          ),
          backgroundColor: AppTheme.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    setState(() { _isSubmitting = true; _isAutoGrading = true; });

    // Collect answers
    for (final q in widget.homework.questions) {
      _answers[q.id] = _controllers[q.id]?.text.trim() ?? '';
    }

    // Auto-grade with Gemini
    int totalScore = 0;
    for (final q in widget.homework.questions) {
      final studentAnswer = _answers[q.id] ?? '';
      final result = await GeminiService.gradeAnswer(
        question: q.question,
        studentAnswer: studentAnswer,
        correctAnswer: q.correctAnswer ?? 'Any reasonable answer showing understanding.',
        maxMarks: q.marks,
        gradeLevel: widget.user.gradeLevel,
      );
      _gradeResults[q.id] = result;
      totalScore += result.score;
    }

    // Build submission object
    final answersList = <Answer>[];
    for (final q in widget.homework.questions) {
      answersList.add(Answer(
        questionId: q.id,
        answerText: _answers[q.id] ?? '',
        marksAwarded: _gradeResults[q.id]?.score ?? 0,
      ));
    }

    final submission = HomeworkSubmission(
      id: '${widget.user.id}_${widget.homework.id}_${DateTime.now().millisecondsSinceEpoch}',
      homeworkId: widget.homework.id,
      studentId: widget.user.id,
      studentName: widget.user.name,
      answers: answersList,
      submittedAt: DateTime.now(),
      status: 'submitted',
      marksObtained: totalScore,
      totalMarks: _maxScore,
    );

    try {
      await SubmissionRepository.submitHomework(submission);
    } catch (_) {
      // Save locally if offline
    }

    // Record in gamification
    await GamificationService.recordHomeworkSubmitted(
      correctAnswers: totalScore,
      totalAnswers: _maxScore,
    );

    if (!mounted) return;
    setState(() {
      _totalScore = totalScore;
      _isSubmitting = false;
      _isAutoGrading = false;
      _submitted = true;
    });

    _celebrationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.homework.questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.homework.title, overflow: TextOverflow.ellipsis),
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.quiz_outlined, size: 64, color: AppTheme.white30),
              const SizedBox(height: 16),
              const Text('No questions available', style: TextStyle(color: AppTheme.white60, fontSize: 18)),
              const SizedBox(height: 8),
              const Text('This homework has no questions yet.', style: TextStyle(color: AppTheme.white30)),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.homework.title, overflow: TextOverflow.ellipsis),
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
      body: _submitted ? _buildResultScreen() : _buildQuizScreen(),
    );
  }

  // ─── Quiz Screen ───────────────────────────────────────────────────────────

  Widget _buildQuizScreen() {
    final questions = widget.homework.questions;
    final total = questions.length;

    return Column(
      children: [
        // Progress bar
        Container(
          color: AppTheme.surfaceDark,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Question ${_currentQuestion + 1} of $total',
                    style: const TextStyle(color: AppTheme.white, fontWeight: FontWeight.w600)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.gold.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.gold.withValues(alpha: 0.3)),
                    ),
                    child: Text('$_maxScore total marks',
                      style: const TextStyle(color: AppTheme.gold, fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: (_currentQuestion + 1) / total,
                  backgroundColor: AppTheme.white20,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.gold),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: questions.asMap().entries.map((e) {
                  final answered = (_controllers[e.value.id]?.text.trim().isNotEmpty) ?? false;
                  return Container(
                    width: 8, height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: e.key == _currentQuestion
                          ? AppTheme.gold
                          : answered
                              ? AppTheme.greenBright
                              : AppTheme.white30,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        // Question content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: _buildQuestionCard(questions[_currentQuestion]),
          ),
        ),

        // Navigation
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, -2))],
          ),
          child: Row(
            children: [
              if (_currentQuestion > 0)
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => setState(() => _currentQuestion--),
                    icon: const Icon(Icons.arrow_back_ios, size: 14),
                    label: const Text('Previous'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.white60,
                      side: const BorderSide(color: AppTheme.white30),
                    ),
                  ),
                ),
              if (_currentQuestion > 0) const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: _currentQuestion < questions.length - 1
                    ? ElevatedButton.icon(
                        onPressed: () => setState(() => _currentQuestion++),
                        icon: const Icon(Icons.arrow_forward_ios, size: 14),
                        label: const Text('Next Question'),
                      )
                    : ElevatedButton.icon(
                        onPressed: _isSubmitting ? null : _submitHomework,
                        icon: _isSubmitting
                            ? const SizedBox(width: 16, height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Icon(Icons.send_rounded),
                        label: Text(_isAutoGrading ? 'Grading with AI...' : 'Submit Homework',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.gold,
                          foregroundColor: AppTheme.black,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionCard(HomeworkQuestion q) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Marks badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.gold.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.gold.withValues(alpha: 0.3)),
          ),
          child: Text('${q.marks} mark${q.marks == 1 ? '' : 's'}',
            style: const TextStyle(color: AppTheme.gold, fontSize: 11, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(height: 16),

        // Question text
        GlassCard(
          padding: const EdgeInsets.all(20),
          borderColor: AppTheme.greenBright.withValues(alpha: 0.2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.greenBright.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.help_outline, color: AppTheme.greenBright, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(q.question,
                  style: const TextStyle(
                    color: AppTheme.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  )),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Answer input
        if (q.type == 'multiple_choice' && q.options != null && q.options!.isNotEmpty)
          _buildMultipleChoice(q)
        else
          _buildShortAnswer(q),

        const SizedBox(height: 20),

        // AI hint button
        GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          borderColor: AppTheme.gold.withValues(alpha: 0.15),
          child: Row(
            children: [
              const Icon(Icons.lightbulb_outline, color: AppTheme.gold, size: 18),
              const SizedBox(width: 10),
              const Expanded(
                child: Text('Stuck? Use the AI Tutor tab for hints — '
                    'but try your best first!',
                  style: TextStyle(color: AppTheme.white60, fontSize: 12)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMultipleChoice(HomeworkQuestion q) {
    return Column(
      children: q.options!.asMap().entries.map((e) {
        final option = e.value;
        final isSelected = _controllers[q.id]?.text == option;
        return GestureDetector(
          onTap: () => setState(() => _controllers[q.id]!.text = option),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppTheme.primaryGreen.withValues(alpha: 0.2)
                  : AppTheme.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected
                    ? AppTheme.greenBright
                    : AppTheme.white20,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 22, height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppTheme.primaryGreen : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? AppTheme.primaryGreen : AppTheme.white30,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, color: AppTheme.white, size: 14)
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(option,
                    style: TextStyle(
                      color: isSelected ? AppTheme.white : AppTheme.white80,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      fontSize: 15,
                    )),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildShortAnswer(HomeworkQuestion q) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Your Answer:',
          style: TextStyle(color: AppTheme.white70, fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: _controllers[q.id],
          maxLines: q.marks >= 4 ? 6 : 3,
          style: const TextStyle(color: AppTheme.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: q.marks == 1
                ? 'Type a short answer...'
                : 'Type your full answer here. Show your reasoning...',
            hintStyle: const TextStyle(color: AppTheme.white30, fontSize: 13),
            filled: true,
            fillColor: AppTheme.white.withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppTheme.white20),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppTheme.white20),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppTheme.greenBright, width: 2),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
          onChanged: (_) => setState(() {}),
        ),
      ],
    );
  }

  // ─── Results Screen ────────────────────────────────────────────────────────

  Widget _buildResultScreen() {
    final percentage = _maxScore > 0 ? (_totalScore / _maxScore * 100).round() : 0;
    final isPassing = percentage >= 50;
    final isExcellent = percentage >= 80;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 16),

          // Score celebration card
          ScaleTransition(
            scale: _celebrationScale,
            child: GlassCard(
              padding: const EdgeInsets.all(28),
              borderColor: isExcellent
                  ? AppTheme.gold.withValues(alpha: 0.4)
                  : isPassing
                      ? AppTheme.greenBright.withValues(alpha: 0.3)
                      : AppTheme.red.withValues(alpha: 0.3),
              boxShadow: isExcellent ? AppTheme.goldGlow : AppTheme.cardGlow,
              child: Column(
                children: [
                  Text(
                    isExcellent ? '🏆' : isPassing ? '✅' : '📖',
                    style: const TextStyle(fontSize: 56),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isExcellent ? 'Outstanding!' : isPassing ? 'Well Done!' : 'Keep Trying!',
                    style: TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold,
                      color: isExcellent ? AppTheme.gold : isPassing ? AppTheme.greenBright : AppTheme.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('$_totalScore / $_maxScore marks',
                    style: const TextStyle(color: AppTheme.white60, fontSize: 16)),
                  const SizedBox(height: 16),
                  // Score ring
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100, height: 100,
                        child: CircularProgressIndicator(
                          value: _maxScore > 0 ? _totalScore / _maxScore : 0,
                          strokeWidth: 10,
                          backgroundColor: AppTheme.white20,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isExcellent ? AppTheme.gold : isPassing ? AppTheme.greenBright : AppTheme.red,
                          ),
                        ),
                      ),
                      Text('$percentage%',
                        style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold,
                          color: isExcellent ? AppTheme.gold : isPassing ? AppTheme.greenBright : AppTheme.white,
                        )),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // XP earned
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.gold.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.gold.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('⚡', style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 6),
                        Text(
                          '+${isExcellent ? 80 : isPassing ? 50 : 20} XP earned!',
                          style: const TextStyle(color: AppTheme.gold, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
          const Row(
            children: [
              Icon(Icons.feedback, color: AppTheme.gold, size: 20),
              SizedBox(width: 8),
              Text('AI Feedback Per Question',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
            ],
          ),
          const SizedBox(height: 12),

          // Per-question feedback
          ...widget.homework.questions.asMap().entries.map((e) {
            final idx = e.key;
            final q = e.value;
            final result = _gradeResults[q.id];
            final score = result?.score ?? 0;
            final feedback = result?.feedback ?? '';
            final studentAnswer = _answers[q.id] ?? '';
            final isCorrect = score == q.marks;

            return GlassCard(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              borderColor: isCorrect
                  ? AppTheme.greenBright.withValues(alpha: 0.2)
                  : score > 0
                      ? AppTheme.gold.withValues(alpha: 0.2)
                      : AppTheme.red.withValues(alpha: 0.15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: isCorrect
                              ? AppTheme.greenBright.withValues(alpha: 0.15)
                              : score > 0
                                  ? AppTheme.gold.withValues(alpha: 0.15)
                                  : AppTheme.red.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          isCorrect ? Icons.check_circle : score > 0 ? Icons.star_half : Icons.cancel,
                          color: isCorrect ? AppTheme.greenBright : score > 0 ? AppTheme.gold : AppTheme.redBright,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text('Q${idx + 1}: ${q.question}',
                          style: const TextStyle(color: AppTheme.white, fontWeight: FontWeight.w600, fontSize: 13),
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isCorrect ? AppTheme.greenBright.withValues(alpha: 0.15) : AppTheme.gold.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('$score/${q.marks}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isCorrect ? AppTheme.greenBright : AppTheme.gold,
                            fontSize: 12,
                          )),
                      ),
                    ],
                  ),
                  if (studentAnswer.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.white.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('Your answer: $studentAnswer',
                        style: const TextStyle(color: AppTheme.white70, fontSize: 12)),
                    ),
                  ],
                  if (feedback.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.auto_awesome, size: 14, color: AppTheme.gold),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(feedback,
                            style: const TextStyle(color: AppTheme.white60, fontSize: 12, fontStyle: FontStyle.italic)),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          }),

          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Homework'),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
