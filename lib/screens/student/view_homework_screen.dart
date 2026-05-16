// screens/student/view_homework_screen.dart
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/user.dart';
import '../../services/homework_repository.dart';
import '../../services/submission_repository.dart';
import '../../models/homework.dart';
import '../../models/submission.dart';
import '../../widgets/glass_card.dart';
import 'submit_homework_screen.dart';

class ViewHomeworkScreen extends StatefulWidget {
  final User user;

  const ViewHomeworkScreen({super.key, required this.user});

  @override
  State<ViewHomeworkScreen> createState() => _ViewHomeworkScreenState();
}

class _ViewHomeworkScreenState extends State<ViewHomeworkScreen> {
  List<Homework> _homeworks = [];
  List<HomeworkSubmission> _submissions = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final homeworks = await HomeworkRepository.getHomeworksByGrade(widget.user.gradeLevel);
    final submissions = await SubmissionRepository.getSubmissionsByStudent(widget.user.id);
    if (mounted) {
      setState(() {
        _homeworks = homeworks;
        _submissions = submissions;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final submittedIds = _submissions.map((s) => s.homeworkId).toSet();

    if (_homeworks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.greenBright.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.greenBright.withValues(alpha: 0.2)),
              ),
              child: const Icon(Icons.assignment, size: 48, color: AppTheme.greenBright),
            ),
            const SizedBox(height: 16),
            Text('No homework assigned yet',
              style: TextStyle(fontSize: 18, color: AppTheme.white60)),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _homeworks.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('My Homework',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.white)),
                    Text('${_homeworks.length} assignments',
                      style: const TextStyle(color: AppTheme.white50)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.greenBright.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.greenBright.withValues(alpha: 0.2)),
                  ),
                  child: Text('${submittedIds.length} submitted',
                    style: const TextStyle(fontSize: 12, color: AppTheme.greenBright, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          );
        }
        final hw = _homeworks[index - 1];
        final isSubmitted = submittedIds.contains(hw.id);
        final sub = _submissions.where((s) => s.homeworkId == hw.id).firstOrNull;

        return GlassCard(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          borderColor: isSubmitted
              ? AppTheme.greenBright.withValues(alpha: 0.2)
              : AppTheme.gold.withValues(alpha: 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isSubmitted
                          ? AppTheme.greenBright.withValues(alpha: 0.15)
                          : AppTheme.gold.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      isSubmitted ? Icons.check_circle : Icons.pending,
                      color: isSubmitted ? AppTheme.greenBright : AppTheme.gold,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(hw.title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.white)),
                        Row(
                          children: [
                            const Icon(Icons.quiz, size: 12, color: AppTheme.white50),
                            const SizedBox(width: 4),
                            Text('${hw.questions.length} questions',
                              style: const TextStyle(color: AppTheme.white50, fontSize: 12)),
                            const SizedBox(width: 12),
                            const Icon(Icons.score, size: 12, color: AppTheme.white50),
                            const SizedBox(width: 4),
                            Text('${hw.questions.fold(0, (sum, q) => sum + q.marks)} marks',
                              style: const TextStyle(color: AppTheme.white50, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isSubmitted
                          ? AppTheme.greenBright.withValues(alpha: 0.15)
                          : AppTheme.gold.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSubmitted
                            ? AppTheme.greenBright.withValues(alpha: 0.2)
                            : AppTheme.gold.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Text(
                      isSubmitted ? 'Done' : 'Pending',
                      style: TextStyle(
                        fontSize: 11, fontWeight: FontWeight.bold,
                        color: isSubmitted ? AppTheme.greenBright : AppTheme.gold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(hw.description,
                style: const TextStyle(color: AppTheme.white60, fontSize: 13),
                maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 14, color: AppTheme.white50),
                  const SizedBox(width: 4),
                  Text('Due: ${hw.dueDate.day}/${hw.dueDate.month}/${hw.dueDate.year}',
                    style: const TextStyle(color: AppTheme.white50, fontSize: 12)),
                  const Spacer(),
                ],
              ),
              if (sub != null && sub.status == 'reviewed') ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity, padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.greenBright.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.greenBright.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.feedback, color: AppTheme.greenBright, size: 18),
                      const SizedBox(width: 8),
                      Text('Score: ${sub.marksObtained ?? 0}/${hw.questions.fold(0, (sum, q) => sum + q.marks)}',
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.greenBright)),
                      const Spacer(),
                      const Text('Feedback available',
                        style: TextStyle(color: AppTheme.greenBright, fontSize: 12)),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: isSubmitted ? null : () async {
                    await Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SubmitHomeworkScreen(
                        homework: hw,
                        user: widget.user,
                      ),
                    ));
                    // Reload after returning (student may have submitted)
                    _loadData();
                  },
                  icon: isSubmitted
                      ? const Icon(Icons.check_circle_outline, size: 18)
                      : const Icon(Icons.edit_note, size: 18),
                  label: Text(isSubmitted ? 'Already Submitted ✓' : 'Start Homework'),
                  style: isSubmitted
                      ? ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.white10,
                          foregroundColor: AppTheme.white30,
                          side: BorderSide.none,
                        )
                      : ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryGreen,
                          foregroundColor: AppTheme.white,
                        ),
                ),
              ),
            ],
          ),
        );
      },
    ),
    );
  }
}
