// screens/teacher/teacher_dashboard.dart
import 'package:flutter/material.dart';

import '../../data/answer_keys.dart';
import '../../data/zimbabwe_curriculum.dart';
import '../../models/progress.dart';
import '../../models/submission.dart';
import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../../services/progress_repository.dart';
import '../../services/submission_repository.dart';
import '../../services/user_repository.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/nav_bar.dart';
import 'ai_assistant_screen.dart';

class TeacherDashboard extends StatefulWidget {
  final User user;

  const TeacherDashboard({super.key, required this.user});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  int _currentIndex = 0;
  List<User> _allStudents = [];
  int _pendingCount = 0;
  int _reviewedCount = 0;


  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final students = await UserRepository.getUsersByRole('student');
      final submissions = await SubmissionRepository.getAllSubmissions();
      if (mounted) {
        setState(() {
          _allStudents = students;
          _pendingCount = submissions.where((s) => s.status == 'submitted').length;
          _reviewedCount = submissions.where((s) => s.status == 'reviewed').length;
        });
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      _buildOverview(),
      ClassOverviewScreen(students: _allStudents),
      const AnswerKeysScreen(),
      AIAssistantScreen(user: widget.user),
      ReviewHomeworkScreen(teacherId: widget.user.id),
    ];

    final titles = ['Dashboard', 'Students', 'Answer Keys', 'AI Assistant', 'Review'];

    return PopScope(
      canPop: _currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _currentIndex > 0) {
          setState(() => _currentIndex = 0);
        }
      },
      child: Scaffold(
      appBar: AppBar(
        title: Text(titles[_currentIndex]),
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
          Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.white20,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(widget.user.school, style: const TextStyle(fontSize: 11, color: AppTheme.white70)),
          ),
          IconButton(
            icon: const Icon(Icons.logout, size: 20),
            tooltip: 'Logout',
            onPressed: () async {
              await AuthService.logout();
              if (!context.mounted) return;
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: screens[_currentIndex],
      ),
      bottomNavigationBar: TeacherNavBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
      ),
    );
  }

  Widget _buildOverview() {
    final totalStudents = _allStudents.length;
    final avgCompletion = totalStudents > 0 ? (_reviewedCount * 100 ~/ (_pendingCount + _reviewedCount).clamp(1, 999)) : 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlassCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.gold.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.auto_awesome, color: AppTheme.gold, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome, ${widget.user.name.split(' ').first}!',
                          style: const TextStyle(color: AppTheme.white, fontSize: 22, fontWeight: FontWeight.bold)),
                        Text(widget.user.school,
                          style: const TextStyle(color: AppTheme.white60, fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const FlagBar(height: 3),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildMetricCard('Students', '$totalStudents', Icons.people_rounded, Colors.blue, 'enrolled')),
              const SizedBox(width: 12),
              Expanded(child: _buildMetricCard('To Review', '$_pendingCount', Icons.pending, Colors.orange, 'pending')),
              const SizedBox(width: 12),
              Expanded(child: _buildMetricCard('Done', '$_reviewedCount', Icons.check_circle, AppTheme.greenBright, '$avgCompletion%')),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
              TextButton.icon(
                onPressed: () => setState(() => _currentIndex = 3),
                icon: const Icon(Icons.auto_awesome, size: 16),
                label: const Text('AI Assistant'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildActionCard('Answer Keys', Icons.vpn_key, Colors.blue, () => setState(() => _currentIndex = 2))),
              const SizedBox(width: 12),
              Expanded(child: _buildActionCard('AI Assistant', Icons.auto_awesome, AppTheme.primaryGreen, () => setState(() => _currentIndex = 3))),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildActionCard('Review', Icons.rate_review, Colors.orange, () => setState(() => _currentIndex = 4))),
              const SizedBox(width: 12),
              Expanded(child: _buildActionCard('Students', Icons.people, Colors.purple, () => setState(() => _currentIndex = 1))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, IconData icon, Color color, String sub) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: const TextStyle(color: AppTheme.white60, fontSize: 11)),
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(sub, style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String label, IconData icon, Color color, VoidCallback onTap) {
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.gold.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.gold, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.white)),
        ],
      ),
    );
  }
}

class ClassOverviewScreen extends StatelessWidget {
  final List<User> students;

  const ClassOverviewScreen({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    final grades = getGradeLevels();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: grades.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('All Classes', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.white)),
                const SizedBox(height: 4),
                Text('${grades.length} grade levels',
                  style: const TextStyle(color: AppTheme.white60, fontSize: 13)),
              ],
            ),
          );
        }
        final grade = grades[index - 1];
        final gradeStudents = students.where((s) => s.gradeLevel == grade).toList();

        String levelLabel;
        Color levelColor;
        if (grade.startsWith('ECD')) { levelLabel = 'ECD'; levelColor = Colors.orange; }
        else if (grade.startsWith('Grade')) { levelLabel = 'Primary'; levelColor = Colors.blue; }
        else if (['Form 1', 'Form 2', 'Form 3', 'Form 4'].contains(grade)) { levelLabel = 'O-Level'; levelColor = Colors.purple; }
        else { levelLabel = 'A-Level'; levelColor = Colors.teal; }

        return GlassCard(
          margin: const EdgeInsets.only(bottom: 10),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => GradeStudentsScreen(grade: grade, students: gradeStudents),
            ));
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    color: levelColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(grade.length <= 6 ? grade.replaceAll(' ', '') : (grade.startsWith('ECD') ? grade.replaceAll(' ', '') : grade.split(' ').last),
                      style: TextStyle(color: levelColor, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(grade, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppTheme.white)),
                      Row(
                        children: [
                          Text('${gradeStudents.length} students', style: const TextStyle(color: AppTheme.white60, fontSize: 12)),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(
                              color: levelColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(levelLabel, style: TextStyle(fontSize: 9, color: levelColor, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppTheme.greyMedium),
              ],
            ),
          ),
        );
      },
    );
  }
}

class GradeStudentsScreen extends StatelessWidget {
  final String grade;
  final List<User> students;

  const GradeStudentsScreen({super.key, required this.grade, required this.students});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$grade Students'),
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
      body: students.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 64, color: AppTheme.white50),
                  SizedBox(height: 16),
                  Text('No students in this grade', style: TextStyle(color: AppTheme.white60)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return GlassCard(
                  margin: const EdgeInsets.only(bottom: 8),
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => StudentDetailScreen(student: student),
                  )),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.3),
                          child: Text(student.name[0], style: const TextStyle(color: AppTheme.white, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(student.name, style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.white)),
                              Text('ID: ${student.id}', style: const TextStyle(color: AppTheme.white50, fontSize: 12)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppTheme.gold.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.visibility, color: AppTheme.gold, size: 18),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class StudentDetailScreen extends StatefulWidget {
  final User student;

  const StudentDetailScreen({super.key, required this.student});

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  List<StudentProgress> _progress = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    try {
      final progress = await ProgressRepository.getProgressForStudent(widget.student.id);
      if (mounted) {
        setState(() {
          _progress = progress;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student.name),
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
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlassCard(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.3),
                          child: Text(widget.student.name[0], style: const TextStyle(color: AppTheme.white, fontSize: 24, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.student.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
                              const SizedBox(height: 2),
                              Text(widget.student.gradeLevel, style: const TextStyle(color: AppTheme.white60, fontSize: 13)),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.greenBright.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text('ID: ${widget.student.id}', style: const TextStyle(color: AppTheme.greenBright, fontSize: 11)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Subject Performance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
                  const SizedBox(height: 12),
                  if (_progress.isEmpty)
                    const GlassCard(
                      padding: EdgeInsets.all(20),
                      child: Text('No progress data available yet.', style: TextStyle(color: AppTheme.white60)),
                    )
                  else
                    ..._progress.map((p) => _buildSubjectProgress(p)),
                ],
              ),
            ),
    );
  }

  Widget _buildSubjectProgress(StudentProgress data) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data.subjectName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.white)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: data.averageScore >= 70
                      ? AppTheme.greenBright.withValues(alpha: 0.2)
                      : AppTheme.gold.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('${data.averageScore.toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14,
                    color: data.averageScore >= 70 ? AppTheme.greenBright : AppTheme.gold,
                  )),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildMiniStat('Quizzes', '${data.quizzesTaken}'),
              const SizedBox(width: 24),
              _buildMiniStat('Submitted', '${data.homeworksSubmitted}'),
              const SizedBox(width: 24),
              _buildMiniStat('Reviewed', '${data.homeworksReviewed}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.white)),
        Text(label, style: const TextStyle(color: AppTheme.white60, fontSize: 11)),
      ],
    );
  }
}

class AnswerKeysScreen extends StatelessWidget {
  const AnswerKeysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final grades = getGradeLevels();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: grades.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Answer Keys', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.white)),
                SizedBox(height: 4),
                Text('Model answers and marking guides for all levels',
                  style: TextStyle(color: AppTheme.white60, fontSize: 13)),
              ],
            ),
          );
        }
        final grade = grades[index - 1];
        return GlassCard(
          margin: const EdgeInsets.only(bottom: 8),
          onTap: () => Navigator.push(context, MaterialPageRoute(
            builder: (context) => GradeAnswerKeysScreen(grade: grade),
          )),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.gold.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.vpn_key, color: AppTheme.gold, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(grade, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppTheme.white)),
                      const Text('View answer keys', style: TextStyle(color: AppTheme.white60, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppTheme.greyMedium),
              ],
            ),
          ),
        );
      },
    );
  }
}

class GradeAnswerKeysScreen extends StatelessWidget {
  final String grade;

  const GradeAnswerKeysScreen({super.key, required this.grade});

  @override
  Widget build(BuildContext context) {
    final answerKeys = getAllAnswerKeysForGrade(grade);

    return Scaffold(
      appBar: AppBar(
        title: Text('$grade Answer Keys'),
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
      body: answerKeys.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.vpn_key_off, size: 64, color: AppTheme.white50),
                  SizedBox(height: 16),
                  Text('No answer keys available for this grade', style: TextStyle(color: AppTheme.white60)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: answerKeys.length,
              itemBuilder: (context, index) {
                final ak = answerKeys[index];
                return GlassCard(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ExpansionTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.gold.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.vpn_key, color: AppTheme.gold, size: 20),
                    ),
                    title: Text(ak.title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.white)),
                    subtitle: Text('${ak.entries.length} questions', style: const TextStyle(color: AppTheme.white60)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: ak.entries.map((e) => Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: AppTheme.white10,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppTheme.white20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.help_outline, size: 16, color: AppTheme.gold),
                                    const SizedBox(width: 8),
                                    Expanded(child: Text(e.question, style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.white))),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.check_circle, size: 16, color: AppTheme.greenBright),
                                    const SizedBox(width: 8),
                                    Expanded(child: Text(e.answer, style: const TextStyle(color: AppTheme.greenBright))),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.lightbulb, size: 16, color: AppTheme.gold),
                                    const SizedBox(width: 8),
                                    Expanded(child: Text(e.explanation,
                                      style: const TextStyle(color: AppTheme.white60, fontSize: 12))),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: AppTheme.greenBright.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text('${e.marks} marks',
                                      style: const TextStyle(color: AppTheme.greenBright, fontSize: 11, fontWeight: FontWeight.w600)),
                                  ),
                                ),
                              ],
                            ),
                          )).toList(),
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

class ReviewHomeworkScreen extends StatefulWidget {
  final String teacherId;

  const ReviewHomeworkScreen({super.key, required this.teacherId});

  @override
  State<ReviewHomeworkScreen> createState() => _ReviewHomeworkScreenState();
}

class _ReviewHomeworkScreenState extends State<ReviewHomeworkScreen> {
  List<HomeworkSubmission> _submissions = [];

  @override
  void initState() {
    super.initState();
    _loadSubmissions();
  }

  Future<void> _loadSubmissions() async {
    final subs = await SubmissionRepository.getAllSubmissions();
    if (mounted) {
      setState(() => _submissions = subs);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pendingSubmissions = _submissions
        .where((s) => s.status == 'submitted').toList();
    final reviewedSubmissions = _submissions
        .where((s) => s.status == 'reviewed').toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 2 + (pendingSubmissions.isNotEmpty ? pendingSubmissions.length : 0) +
          (reviewedSubmissions.isNotEmpty ? reviewedSubmissions.length : 0),
      itemBuilder: (context, index) {
        int i = 0;
        if (index == i++) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Pending Review', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.white)),
                const SizedBox(height: 4),
                Text('${pendingSubmissions.length} submissions to review',
                  style: const TextStyle(color: AppTheme.white60, fontSize: 13)),
              ],
            ),
          );
        }
        for (final sub in pendingSubmissions) {
          if (index == i++) {
            return _buildSubmissionCard(context, sub, false);
          }
        }
        if (index == i++) {
          return Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Reviewed', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.white)),
                Text('${reviewedSubmissions.length} submissions reviewed',
                  style: const TextStyle(color: AppTheme.white60, fontSize: 13)),
              ],
            ),
          );
        }
        for (final sub in reviewedSubmissions) {
          if (index == i++) {
            return _buildSubmissionCard(context, sub, true);
          }
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSubmissionCard(BuildContext context, HomeworkSubmission data, bool isReviewed) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.3),
                child: Text(data.studentName[0]),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.studentName, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.white)),
                    Text('Submitted ${_timeAgo(data.submittedAt)}',
                      style: const TextStyle(color: AppTheme.white60, fontSize: 12)),
                  ],
                ),
              ),
              if (data.marksObtained != null)
                Builder(builder: (context) {
                  final marks = data.marksObtained!;
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: marks >= 70 ? AppTheme.greenBright.withValues(alpha: 0.2) : AppTheme.gold.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('$marks', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: marks >= 70 ? AppTheme.greenBright : AppTheme.gold,
                    )),
                  );
                }),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.white10,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('${data.answers.length} answers', style: const TextStyle(fontSize: 11, color: AppTheme.white60)),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isReviewed ? AppTheme.greenBright.withValues(alpha: 0.2) : AppTheme.gold.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(data.status.toUpperCase(),
                  style: TextStyle(fontSize: 11, color: isReviewed ? AppTheme.greenBright : AppTheme.gold)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              if (!isReviewed)
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MarkHomeworkScreen(submission: data),
                    )),
                    icon: const Icon(Icons.rate_review, size: 18),
                    label: const Text('Review & Mark'),
                  ),
                )
              else
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MarkHomeworkScreen(submission: data),
                    )),
                    icon: const Icon(Icons.visibility, size: 18),
                    label: const Text('View Details'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.greenBright),
                      foregroundColor: AppTheme.greenBright,
                    ),
                  ),
                ),
            ],
          ),
          if (isReviewed && data.feedback != null) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity, padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.gold.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.gold.withValues(alpha: 0.2)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.feedback, size: 16, color: AppTheme.gold),
                  const SizedBox(width: 8),
                  Expanded(child: Text(data.feedback ?? '',
                    style: const TextStyle(color: AppTheme.white70, fontSize: 13))),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    return '${diff.inMinutes}m ago';
  }
}

class MarkHomeworkScreen extends StatefulWidget {
  final HomeworkSubmission submission;

  const MarkHomeworkScreen({super.key, required this.submission});

  @override
  State<MarkHomeworkScreen> createState() => _MarkHomeworkScreenState();
}

class _MarkHomeworkScreenState extends State<MarkHomeworkScreen> {
  final _feedbackController = TextEditingController();
  late Map<String, TextEditingController> _scoreControllers;
  int? _totalScore;

  @override
  void initState() {
    super.initState();
    _feedbackController.text = widget.submission.feedback ?? '';
    _scoreControllers = {};
    final answers = widget.submission.answers;
    for (int i = 0; i < answers.length; i++) {
      _scoreControllers['${answers[i].questionId}_score'] = TextEditingController();
    }
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    for (final c in _scoreControllers.values) { c.dispose(); }
    super.dispose();
  }

  void _submitReview() {
    setState(() {
      _totalScore = _scoreControllers.entries
          .map((e) => int.tryParse(e.value.text) ?? 0)
          .fold<int>(0, (a, b) => a + b);
    });
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Submit Review'),
        content: Text('Score: ${_totalScore ?? 0} marks\nFeedback: ${_feedbackController.text}\n\nSubmit this review?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                final uid = AuthService.currentUser?.id ?? '';
                await SubmissionRepository.markSubmission(
                  widget.submission.id,
                  {
                    'status': 'reviewed',
                    'marksObtained': _totalScore ?? 0,
                    'feedback': _feedbackController.text.trim(),
                    'markedAt': DateTime.now(),
                    'reviewedBy': uid,
                  },
                );
                if (!mounted) return;
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Review submitted successfully!'),
                    backgroundColor: AppTheme.greenBright,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                );
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to save review: $e'),
                    backgroundColor: AppTheme.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final answers = widget.submission.answers;
    return Scaffold(
      appBar: AppBar(
        title: Text('Review: ${widget.submission.studentName}'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlassCard(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.3),
                    child: Text(widget.submission.studentName[0], style: const TextStyle(color: AppTheme.white)),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.submission.studentName, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.white)),
                      Text('Submitted ${widget.submission.submittedAt.day}/${widget.submission.submittedAt.month}/${widget.submission.submittedAt.year}',
                        style: const TextStyle(color: AppTheme.white60, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Student Answers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
            const SizedBox(height: 12),
            ...answers.asMap().entries.map((entry) {
              final index = entry.key;
              final ans = entry.value;
              return GlassCard(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 14, backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.3),
                          child: Text('${index + 1}',
                            style: const TextStyle(color: AppTheme.white, fontSize: 12)),
                        ),
                        const SizedBox(width: 8),
                        const Text('Answer:', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.white)),
                        const Spacer(),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            controller: _scoreControllers['${ans.questionId}_score'],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Marks',
                              hintStyle: const TextStyle(color: AppTheme.white50),
                              filled: true,
                              fillColor: AppTheme.white10,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity, padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.white10,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(ans.answerText, style: const TextStyle(fontSize: 14, color: AppTheme.white70)),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 16),
            const Text('Feedback & Guidance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity, padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.greenBright.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.greenBright.withValues(alpha: 0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lightbulb, color: AppTheme.greenBright, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text('Provide constructive guidance rather than just correct/incorrect. Suggest how they can improve.',
                      style: TextStyle(color: AppTheme.white60, fontSize: 12)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _feedbackController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Write constructive feedback for the student...',
                hintStyle: TextStyle(color: AppTheme.white50),
                filled: true,
                fillColor: AppTheme.white10,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton.icon(
                onPressed: _submitReview,
                icon: const Icon(Icons.check),
                label: const Text('Submit Review', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
