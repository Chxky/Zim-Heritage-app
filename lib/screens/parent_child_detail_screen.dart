import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/user.dart';
import '../../models/progress.dart';
import '../../models/submission.dart';
import '../../services/progress_repository.dart';
import '../../services/submission_repository.dart';
import '../../widgets/glass_card.dart';

class ParentChildDetailScreen extends StatefulWidget {
  final User child;

  const ParentChildDetailScreen({super.key, required this.child});

  @override
  State<ParentChildDetailScreen> createState() => _ParentChildDetailScreenState();
}

class _ParentChildDetailScreenState extends State<ParentChildDetailScreen> {
  List<StudentProgress> _progressList = [];
  List<HomeworkSubmission> _submissions = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final results = await Future.wait([
      ProgressRepository.getProgressForStudent(widget.child.id),
      SubmissionRepository.getSubmissionsByStudent(widget.child.id),
    ]);
    if (mounted) {
      setState(() {
        _progressList = results[0] as List<StudentProgress>;
        _submissions = results[1] as List<HomeworkSubmission>;
        _submissions.sort((a, b) => b.submittedAt.compareTo(a.submittedAt));
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.child.name),
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
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileHeader(),
                    const SizedBox(height: 20),
                    if (_progressList.isEmpty && _submissions.isEmpty)
                      _buildEmptyState()
                    else ...[
                      if (_progressList.isNotEmpty) ...[
                        const Row(
                          children: [
                            Icon(Icons.bar_chart, color: AppTheme.gold, size: 20),
                            SizedBox(width: 8),
                            Text('Subject Performance',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ..._progressList.map((p) => _buildSubjectCard(p)),
                        const SizedBox(height: 24),
                      ],
                      if (_submissions.isNotEmpty) ...[
                        const Row(
                          children: [
                            Icon(Icons.assignment, color: AppTheme.gold, size: 20),
                            SizedBox(width: 8),
                            Text('Recent Submissions',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ..._submissions.take(5).map((s) => _buildSubmissionCard(s)),
                      ],
                    ],
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildProfileHeader() {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      borderColor: AppTheme.gold.withValues(alpha: 0.2),
      boxShadow: AppTheme.goldGlow,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.gold.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.person, color: AppTheme.gold, size: 40),
          ),
          const SizedBox(height: 16),
          Text(widget.child.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.white)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInfoChip(Icons.school, widget.child.gradeLevel),
              const SizedBox(width: 12),
              _buildInfoChip(Icons.badge, widget.child.id.length > 8
                  ? 'ID: ${widget.child.id.substring(0, 8)}...'
                  : 'ID: ${widget.child.id}'),
            ],
          ),
          if (widget.child.school.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(widget.child.school,
              style: const TextStyle(color: AppTheme.white60, fontSize: 13)),
          ],
          const SizedBox(height: 16),
          Divider(color: AppTheme.white10),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem(
                '${_progressList.fold<int>(0, (sum, p) => sum + p.homeworksSubmitted)}',
                'Assignments',
                AppTheme.greenBright,
              ),
              _buildStatItem(
                '${_progressList.length}',
                'Subjects',
                AppTheme.gold,
              ),
              _buildStatItem(
                '${_submissions.length}',
                'Submissions',
                Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.white10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppTheme.white60),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: AppTheme.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 2),
        Text(label,
          style: const TextStyle(color: AppTheme.white60, fontSize: 11)),
      ],
    );
  }

  Widget _buildSubjectCard(StudentProgress data) {
    Color subjectColor;
    switch (data.subjectName) {
      case 'Mathematics': subjectColor = Colors.blue; break;
      case 'English': subjectColor = Colors.indigo; break;
      case 'General Science': subjectColor = Colors.teal; break;
      default: subjectColor = AppTheme.primaryGreen;
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
                    Text('${data.quizzesTaken} quizzes taken',
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
          Row(
            children: [
              _buildSubjectStat(
                Icons.quiz,
                '${data.quizzesTaken}',
                'Quizzes',
              ),
              const SizedBox(width: 16),
              _buildSubjectStat(
                Icons.assignment,
                '${data.homeworksSubmitted}',
                'Submitted',
              ),
              const SizedBox(width: 16),
              _buildSubjectStat(
                Icons.check_circle,
                '${data.homeworksReviewed}',
                'Reviewed',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectStat(IconData icon, String value, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppTheme.white50),
        const SizedBox(width: 4),
        Text(value,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.white)),
        const SizedBox(width: 2),
        Text(label,
          style: const TextStyle(color: AppTheme.white50, fontSize: 11)),
      ],
    );
  }

  Widget _buildSubmissionCard(HomeworkSubmission submission) {
    Color statusColor;
    String statusText;
    switch (submission.status) {
      case 'graded':
      case 'marked':
        statusColor = AppTheme.greenBright;
        statusText = 'Graded';
        break;
      case 'submitted':
        statusColor = AppTheme.gold;
        statusText = 'Pending';
        break;
      default:
        statusColor = AppTheme.white50;
        statusText = submission.status;
    }

    final hasScore = submission.marksObtained != null && submission.totalMarks != null;

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      borderColor: statusColor.withValues(alpha: 0.2),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.description, color: statusColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(submission.studentName,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppTheme.white)),
                const SizedBox(height: 2),
                Text(
                  _formatDate(submission.submittedAt),
                  style: const TextStyle(color: AppTheme.white50, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: statusColor.withValues(alpha: 0.3)),
            ),
            child: Text(
              hasScore ? '${submission.marksObtained}/${submission.totalMarks}' : statusText,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: statusColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return GlassCard(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(Icons.inbox, size: 48, color: AppTheme.white30),
          const SizedBox(height: 12),
          const Text('No data available yet',
            style: TextStyle(color: AppTheme.white60, fontSize: 16)),
          const SizedBox(height: 4),
          Text('Progress and submissions will appear here once available.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.white30, fontSize: 13)),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
  }
}
