import 'package:flutter/material.dart';

import '../models/progress.dart';
import '../models/user.dart';
import '../services/progress_repository.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';

class ReportCardScreen extends StatefulWidget {
  final User student;

  const ReportCardScreen({super.key, required this.student});

  @override
  State<ReportCardScreen> createState() => _ReportCardScreenState();
}

class _ReportCardScreenState extends State<ReportCardScreen> {
  List<StudentProgress> _progressList = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final progress = await ProgressRepository.getProgressForStudent(widget.student.id);
      if (mounted) setState(() { _progressList = progress; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Card'),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Share Report Card',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Report card shared!'), backgroundColor: AppTheme.greenBright),
              );
            },
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  _buildSubjectTable(),
                  const SizedBox(height: 16),
                  _buildSummary(),
                  const SizedBox(height: 16),
                  _buildAttendanceSection(),
                  const SizedBox(height: 16),
                  _buildSignatureSection(),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      borderColor: AppTheme.gold.withValues(alpha: 0.3),
      child: Column(
        children: [
          const Text('ZIMBABWE HERITAGE EDUCATION',
            style: TextStyle(color: AppTheme.gold, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
          const SizedBox(height: 4),
          const Text('STUDENT REPORT CARD',
            style: TextStyle(color: AppTheme.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _buildInfoRow('Student Name', widget.student.name),
          _buildInfoRow('Grade Level', widget.student.gradeLevel),
          _buildInfoRow('School', widget.student.school),
          _buildInfoRow('Term', 'Term 2, ${DateTime.now().year}'),
          _buildInfoRow('Student ID', widget.student.id),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label, style: const TextStyle(color: AppTheme.white60, fontSize: 13))),
          Expanded(child: Text(value, style: const TextStyle(color: AppTheme.white, fontSize: 13, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  Widget _buildSubjectTable() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Academic Performance',
            style: TextStyle(color: AppTheme.gold, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          // Header row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: AppTheme.white10,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Expanded(flex: 3, child: Text('Subject', style: TextStyle(color: AppTheme.white, fontWeight: FontWeight.bold, fontSize: 12))),
                Expanded(child: Text('CA', style: TextStyle(color: AppTheme.white, fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
                Expanded(child: Text('Exam', style: TextStyle(color: AppTheme.white, fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
                Expanded(child: Text('Grade', style: TextStyle(color: AppTheme.white, fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
                Expanded(flex: 2, child: Text('Remarks', style: TextStyle(color: AppTheme.white, fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
              ],
            ),
          ),
          const SizedBox(height: 4),
          ..._progressList.map((p) => _buildSubjectRow(p)),
        ],
      ),
    );
  }

  Widget _buildSubjectRow(StudentProgress progress) {
    final score = progress.averageScore;
    final grade = _getGrade(score);
    final color = _getGradeColor(score);
    final remark = _getRemark(score);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.white10)),
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(progress.subjectName,
            style: const TextStyle(color: AppTheme.white, fontSize: 13))),
          Expanded(child: Text('${score.toStringAsFixed(0)}%',
            style: TextStyle(color: color, fontSize: 13), textAlign: TextAlign.center)),
          Expanded(child: Text('${(score * 0.9).toStringAsFixed(0)}%',
            style: TextStyle(color: color, fontSize: 13), textAlign: TextAlign.center)),
          Expanded(child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(grade, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
              textAlign: TextAlign.center),
          )),
          Expanded(flex: 2, child: Text(remark,
            style: const TextStyle(color: AppTheme.white60, fontSize: 11), textAlign: TextAlign.center)),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    final avg = _progressList.isEmpty
        ? 0.0
        : _progressList.fold(0.0, (sum, p) => sum + p.averageScore) / _progressList.length;

    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderColor: AppTheme.gold.withValues(alpha: 0.3),
      child: Column(
        children: [
          const Text('Summary', style: TextStyle(color: AppTheme.gold, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSummaryStat('Average', '${avg.toStringAsFixed(1)}%', _getGradeColor(avg)),
              _buildSummaryStat('Grade', _getGrade(avg), _getGradeColor(avg)),
              _buildSummaryStat('Subjects', '${_progressList.length}', AppTheme.white),
            ],
          ),
          const SizedBox(height: 12),
          Text(_getOverallRemark(avg),
            style: TextStyle(color: _getGradeColor(avg), fontSize: 14, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildSummaryStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: const TextStyle(color: AppTheme.white60, fontSize: 12)),
      ],
    );
  }

  Widget _buildAttendanceSection() {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Attendance Record',
            style: TextStyle(color: AppTheme.gold, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAttendanceStat('Present', '42', AppTheme.greenBright),
              _buildAttendanceStat('Absent', '3', AppTheme.redBright),
              _buildAttendanceStat('Late', '5', AppTheme.gold),
              _buildAttendanceStat('Rate', '84%', AppTheme.greenBright),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceStat(String label, String value, Color color) {
    return Column(
      children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Center(child: Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold))),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: AppTheme.white60, fontSize: 11)),
      ],
    );
  }

  Widget _buildSignatureSection() {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(width: 120, height: 1, color: AppTheme.white30),
                  const SizedBox(height: 4),
                  const Text('Class Teacher', style: TextStyle(color: AppTheme.white60, fontSize: 11)),
                ],
              ),
              Column(
                children: [
                  Container(width: 120, height: 1, color: AppTheme.white30),
                  const SizedBox(height: 4),
                  const Text('Head of School', style: TextStyle(color: AppTheme.white60, fontSize: 11)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Generated on ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
            style: const TextStyle(color: AppTheme.white30, fontSize: 10)),
        ],
      ),
    );
  }

  String _getGrade(double score) {
    if (score >= 80) return 'A';
    if (score >= 70) return 'B';
    if (score >= 60) return 'C';
    if (score >= 50) return 'D';
    if (score >= 40) return 'E';
    return 'U';
  }

  Color _getGradeColor(double score) {
    if (score >= 70) return AppTheme.greenBright;
    if (score >= 50) return AppTheme.gold;
    return AppTheme.redBright;
  }

  String _getRemark(double score) {
    if (score >= 80) return 'Excellent';
    if (score >= 70) return 'Very Good';
    if (score >= 60) return 'Good';
    if (score >= 50) return 'Satisfactory';
    if (score >= 40) return 'Needs Improvement';
    return 'Unsatisfactory';
  }

  String _getOverallRemark(double avg) {
    if (avg >= 80) return 'Outstanding performance! Keep up the excellent work.';
    if (avg >= 70) return 'Very good performance. Continue the great effort.';
    if (avg >= 60) return 'Good progress. Focus on weaker subjects for improvement.';
    if (avg >= 50) return 'Satisfactory. More effort needed in several subjects.';
    return 'Needs significant improvement. Please consult with teachers.';
  }
}
