// screens/student/progress_screen.dart
import 'package:flutter/material.dart';

import '../../models/progress.dart';
import '../../models/user.dart';
import '../../services/progress_repository.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

class StudentProgressScreen extends StatefulWidget {
  final User user;

  const StudentProgressScreen({super.key, required this.user});

  @override
  State<StudentProgressScreen> createState() => _StudentProgressScreenState();
}

class _StudentProgressScreenState extends State<StudentProgressScreen> {
  List<StudentProgress> _progressList = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    try {
      final progress = await ProgressRepository.getProgressForStudent(widget.user.id);
      if (mounted) {
        setState(() {
          _progressList = progress;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _loadProgress,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          GlassCard(
            padding: const EdgeInsets.all(24),
            borderColor: AppTheme.gold.withValues(alpha: 0.2),
            boxShadow: AppTheme.goldGlow,
            child: Column(
              children: [
                const Text('Overall Performance',
                  style: TextStyle(color: AppTheme.white60, fontSize: 14)),
                const SizedBox(height: 8),
                Text(
                  _progressList.isEmpty
                      ? '--'
                      : '${(_progressList.fold(0.0, (sum, p) => sum + p.averageScore) / _progressList.length).toStringAsFixed(0)}%',
                  style: const TextStyle(color: AppTheme.gold, fontSize: 48, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  _progressList.isEmpty
                      ? 'No data yet'
                      : '${_progressList.fold(0, (sum, p) => sum + p.homeworksSubmitted)} assignments completed',
                  style: const TextStyle(color: AppTheme.white60, fontSize: 13),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: _progressList.isEmpty ? 0 : (_progressList.fold(0.0, (s, p) => s + p.averageScore) / (_progressList.length * 100)),
                    backgroundColor: AppTheme.white20,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.gold),
                    minHeight: 8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Row(
            children: [
              Icon(Icons.bar_chart, color: AppTheme.gold, size: 20),
              SizedBox(width: 8),
              Text('Subject Breakdown',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
            ],
          ),
          const SizedBox(height: 12),
          if (_progressList.isEmpty)
            const GlassCard(
              padding: EdgeInsets.all(40),
              child: Column(
                children: [
                  Icon(Icons.bar_chart, size: 48, color: AppTheme.white30),
                  SizedBox(height: 12),
                  Text('No progress data yet', style: TextStyle(color: AppTheme.white60, fontSize: 16)),
                ],
              ),
            )
          else
            ..._progressList.map((p) => _buildSubjectProgress(p)),
        ],
      ),
    ),
    );
  }

  Widget _buildSubjectProgress(StudentProgress data) {
    Color subjectColor;
    switch (data.subjectName) {
      case 'Mathematics': subjectColor = Colors.blue; break;
      case 'English': subjectColor = Colors.indigo; break;
      case 'General Science': subjectColor = Colors.teal; break;
      default: subjectColor = const Color.fromARGB(255, 41, 0, 107);
    }

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      borderColor: subjectColor.withValues(alpha: 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: subjectColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.book, color: subjectColor, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.subjectName,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.white)),
                    Text('${data.quizzesTaken} quizzes • ${data.homeworksSubmitted} assignments',
                      style: const TextStyle(color: AppTheme.white50, fontSize: 12)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: data.averageScore >= 70
                      ? AppTheme.greenBright.withValues(alpha: 0.15)
                      : AppTheme.gold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: data.averageScore >= 70
                        ? AppTheme.greenBright.withValues(alpha: 0.3)
                        : AppTheme.gold.withValues(alpha: 0.3),
                  ),
                ),
                child: Text('${data.averageScore.toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14,
                    color: data.averageScore >= 70 ? AppTheme.greenBright : AppTheme.gold,
                  )),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text('Topics:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.white)),
          const SizedBox(height: 8),
          ...data.topics.map((t) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Icon(
                  t.status == 'completed'
                      ? Icons.check_circle
                      : t.status == 'in_progress'
                          ? Icons.play_circle
                          : Icons.radio_button_unchecked,
                  size: 18,
                  color: t.status == 'completed'
                      ? AppTheme.greenBright
                      : t.status == 'in_progress'
                          ? Colors.orange
                          : AppTheme.white30,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(t.topicName,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.white70,
                      fontWeight: t.status == 'completed' ? FontWeight.w500 : FontWeight.normal,
                    )),
                ),
                if (t.score > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: t.score >= 70
                          ? AppTheme.greenBright.withValues(alpha: 0.15)
                          : AppTheme.gold.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('${t.score.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 11, fontWeight: FontWeight.bold,
                        color: t.score >= 70 ? AppTheme.greenBright : AppTheme.gold,
                      )),
                  ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
