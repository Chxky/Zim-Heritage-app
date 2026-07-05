import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/user.dart';
import '../../models/subject.dart';
import '../../data/zimbabwe_curriculum.dart';
import '../../services/homework_repository.dart';
import '../../services/progress_repository.dart';
import '../../services/auth_service.dart';
import '../../widgets/nav_bar.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/ai_reading_assistant.dart';
import '../../widgets/ai_tutor.dart';
import 'subjects_screen.dart';
import 'view_homework_screen.dart';
import 'progress_screen.dart';
import 'past_exams_screen.dart';
import 'ecd_play_screen.dart';
import 'ecd_coloring_screen.dart';
import 'ecd_word_games_screen.dart';
import 'ecd_story_screen.dart';
import '../national/exam_predictor_screen.dart';
import '../national/learner_passport_screen.dart';

class StudentDashboard extends StatefulWidget {
  final User user;

  const StudentDashboard({super.key, required this.user});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _currentIndex = 0;
  int _pendingCount = 0;
  String _averageScore = '--';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final homeworks = await HomeworkRepository.getHomeworksByGrade(widget.user.gradeLevel);
      final progress = await ProgressRepository.getProgressForStudent(widget.user.id);
      if (mounted) {
        String avg = '--';
        if (progress.isNotEmpty) {
          final total = progress.fold<double>(0, (sum, p) => sum + p.averageScore);
          avg = (total / progress.length).toStringAsFixed(0);
        }
        setState(() {
          _pendingCount = homeworks.length;
          _averageScore = avg;
        });
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final isECD = widget.user.gradeLevel.startsWith('ECD');

    final screens = [
      _buildOverview(),
      SubjectsScreen(user: widget.user),
      ViewHomeworkScreen(user: widget.user),
      StudentProgressScreen(user: widget.user),
      isECD
          ? const AIReadingAssistant()
          : AITutor(gradeLevel: widget.user.gradeLevel),
    ];

    final titles = ['Dashboard', 'Subjects', 'Homework', 'Progress', isECD ? 'AI Reading' : 'AI Tutor'];

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
              color: AppTheme.gold.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.gold.withValues(alpha: 0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.school, size: 14, color: AppTheme.gold),
                const SizedBox(width: 4),
                Text(
                  widget.user.gradeLevel,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.gold),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.local_library, color: AppTheme.gold),
            tooltip: 'Digital Library',
            onPressed: () => Navigator.pushNamed(context, '/digital-library'),
          ),
          IconButton(
            icon: const Icon(Icons.security, color: AppTheme.primaryGreen),
            tooltip: 'Cyber Security',
            onPressed: () => Navigator.pushNamed(context, '/security'),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => Navigator.pushNamed(context, '/notifications', arguments: widget.user),
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
      bottomNavigationBar: AppNavBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/ai-assistant'),
        backgroundColor: AppTheme.gold,
        tooltip: 'ZimHeritage AI Assistant',
        child: const Icon(Icons.auto_awesome, color: AppTheme.black),
      ),
      ),
    );
  }

  Widget _buildOverview() {
    final subjects = getSubjectsForGradeAndCurriculum(widget.user.gradeLevel, widget.user.curriculum);
    final isECD = widget.user.gradeLevel.startsWith('ECD');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeCard(),
          const SizedBox(height: 20),
          GlassCard(
            padding: const EdgeInsets.all(16),
            borderColor: Colors.red.withValues(alpha: 0.3),
            boxShadow: [
              BoxShadow(color: Colors.red.withValues(alpha: 0.15), blurRadius: 12, offset: const Offset(0, 4)),
            ],
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.campaign, color: Colors.redAccent, size: 24),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ministry Circular', style: TextStyle(color: Colors.redAccent, fontSize: 14, fontWeight: FontWeight.bold)),
                          Text('Today', style: TextStyle(color: AppTheme.white60, fontSize: 10)),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text('Term 2 Curriculum Updates', style: TextStyle(color: AppTheme.white, fontSize: 15, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('Please review the updated term dates and new Heritage-Based continuous assessment requirements.',
                        style: TextStyle(color: AppTheme.white70, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (!isECD) ...[
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/heritage-learning'),
              child: GlassCard(
                padding: const EdgeInsets.all(16),
                borderColor: AppTheme.gold.withValues(alpha: 0.4),
                boxShadow: AppTheme.goldGlow,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.gold.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.school, color: AppTheme.gold, size: 32),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Heritage Learning Hub', 
                            style: TextStyle(color: AppTheme.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text('Interactive curriculum & VR History', 
                            style: TextStyle(color: AppTheme.gold, fontSize: 13)),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: AppTheme.gold),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
          if (isECD) ...[
            _buildECDPlayArea(),
            const SizedBox(height: 20),
          ],
          if (!isECD) ...[
            Row(
              children: [
                Expanded(child: _buildStatCard(Icons.book, 'Subjects', '${subjects.length}', Colors.blue, Icons.school)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard(Icons.assignment, 'Homework', '$_pendingCount', Colors.orange, Icons.pending)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard(Icons.trending_up, 'Average', _averageScore, AppTheme.greenBright, Icons.analytics)),
              ],
            ),
            const SizedBox(height: 24),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('My Subjects', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
              TextButton(
                onPressed: () => setState(() => _currentIndex = 1),
                child: const Text('View All', style: TextStyle(color: AppTheme.gold, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...subjects.take(4).map((s) => _buildSubjectCard(s)),
          if (subjects.length > 4)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Center(
                child: TextButton(
                  onPressed: () => setState(() => _currentIndex = 1),
                  child: Text('+ ${subjects.length - 4} more subjects',
                    style: const TextStyle(color: AppTheme.white50)),
                ),
              ),
            ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: const Text('Past Exam Questions'),
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
                  body: PastExamsScreen(user: widget.user),
                ),
              ));
            },
            child: _buildPastExamsCard(),
          ),
          const SizedBox(height: 16),
          // AI Assistant CTA
          GlassCard(
            padding: const EdgeInsets.all(16),
            borderColor: AppTheme.gold.withValues(alpha: 0.2),
            boxShadow: AppTheme.goldGlow,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('AI Learning Assistant',
                        style: TextStyle(color: AppTheme.gold, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text('Get help with any subject',
                        style: TextStyle(color: AppTheme.white60, fontSize: 13)),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => setState(() => _currentIndex = 4),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.gold,
                          foregroundColor: AppTheme.black,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          minimumSize: Size.zero,
                          side: BorderSide.none,
                        ),
                        child: const Text('Try Now', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.gold.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.gold.withValues(alpha: 0.2)),
                  ),
                  child: const Icon(Icons.auto_awesome, color: AppTheme.gold, size: 40),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Offline Sync Manager
          GlassCard(
            padding: const EdgeInsets.all(16),
            borderColor: AppTheme.primaryGreen.withValues(alpha: 0.2),
            boxShadow: [
              BoxShadow(color: AppTheme.primaryGreen.withValues(alpha: 0.12), blurRadius: 16, offset: const Offset(0, 4)),
            ],
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Offline Learning Resources',
                        style: TextStyle(color: AppTheme.greenBright, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text('Download VR & Audio for rural access',
                        style: TextStyle(color: AppTheme.white60, fontSize: 13)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: const LinearProgressIndicator(
                                value: 0.7,
                                backgroundColor: AppTheme.surfaceDark,
                                color: AppTheme.greenBright,
                                minHeight: 6,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text('70%', style: TextStyle(color: AppTheme.greenBright, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.primaryGreen.withValues(alpha: 0.2)),
                  ),
                  child: const Icon(Icons.cloud_download, color: AppTheme.greenBright, size: 32),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // National Command Centre
          GlassCard(
            padding: const EdgeInsets.all(16),
            borderColor: Colors.amber.withValues(alpha: 0.3),
            boxShadow: AppTheme.goldGlow,
            onTap: () {
              Navigator.pushNamed(context, '/national-dashboard');
            },
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('National Command Centre',
                        style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text('Real-time education intelligence dashboard',
                        style: TextStyle(color: AppTheme.white60, fontSize: 13)),
                      const SizedBox(height: 6),
                      Text('NDS1 KPIs • Vision 2030 • Province Analytics',
                        style: TextStyle(color: Colors.amber.withValues(alpha: 0.7), fontSize: 11)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
                  ),
                  child: const Icon(Icons.account_balance, color: Colors.amber, size: 40),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Leaderboard & Challenges
          Row(
            children: [
              Expanded(
                child: GlassCard(
                  padding: const EdgeInsets.all(16),
                  borderColor: AppTheme.gold.withValues(alpha: 0.2),
                  onTap: () => Navigator.pushNamed(context, '/leaderboard'),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.gold.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.leaderboard, color: AppTheme.gold, size: 28),
                      ),
                      const SizedBox(height: 8),
                      const Text('Leaderboard', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.white)),
                      const Text('See rankings', style: TextStyle(color: AppTheme.white60, fontSize: 11)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GlassCard(
                  padding: const EdgeInsets.all(16),
                  borderColor: Colors.orange.withValues(alpha: 0.2),
                  onTap: () => Navigator.pushNamed(context, '/challenges'),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.flag, color: Colors.orange, size: 28),
                      ),
                      const SizedBox(height: 8),
                      const Text('Challenges', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.white)),
                      const Text('Earn XP', style: TextStyle(color: AppTheme.white60, fontSize: 11)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GlassCard(
                  padding: const EdgeInsets.all(16),
                  borderColor: Colors.purple.withValues(alpha: 0.2),
                  onTap: () => Navigator.pushNamed(context, '/zimbabwe-map'),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.purple.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.map, color: Colors.purple, size: 28),
                      ),
                      const SizedBox(height: 8),
                      const Text('Map', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.white)),
                      const Text('Explore', style: TextStyle(color: AppTheme.white60, fontSize: 11)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // ZIMSEC Exam Predictor
          GlassCard(
            padding: const EdgeInsets.all(16),
            borderColor: const Color(0xFF5C6BC0).withValues(alpha: 0.2),
            boxShadow: [
              BoxShadow(color: const Color(0xFF5C6BC0).withValues(alpha: 0.12), blurRadius: 16, offset: const Offset(0, 4)),
            ],
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => ExamPredictorScreen(gradeLevel: widget.user.gradeLevel),
              ));
            },
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('ZIMSEC Exam Predictor',
                        style: TextStyle(color: Color(0xFF5C6BC0), fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text('AI predicts your grade & weak areas',
                        style: TextStyle(color: AppTheme.white60, fontSize: 13)),
                      const SizedBox(height: 6),
                      Text('Personalised study plan included',
                        style: TextStyle(color: const Color(0xFF5C6BC0).withValues(alpha: 0.7), fontSize: 11)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5C6BC0).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF5C6BC0).withValues(alpha: 0.2)),
                  ),
                  child: const Icon(Icons.psychology, color: Color(0xFF5C6BC0), size: 40),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Digital Learner Passport
          GlassCard(
            padding: const EdgeInsets.all(16),
            borderColor: const Color(0xFF2E7D32).withValues(alpha: 0.2),
            boxShadow: [
              BoxShadow(color: const Color(0xFF2E7D32).withValues(alpha: 0.12), blurRadius: 16, offset: const Offset(0, 4)),
            ],
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => LearnerPassportScreen(
                  studentName: widget.user.name,
                  gradeLevel: widget.user.gradeLevel,
                  school: widget.user.school,
                  studentId: widget.user.id,
                ),
              ));
            },
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Digital Learner Passport',
                        style: TextStyle(color: Color(0xFF2E7D32), fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text('Blockchain-verified academic records',
                        style: TextStyle(color: AppTheme.white60, fontSize: 13)),
                      const SizedBox(height: 6),
                      Text('Share credentials with employers & colleges',
                        style: TextStyle(color: const Color(0xFF2E7D32).withValues(alpha: 0.7), fontSize: 11)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D32).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF2E7D32).withValues(alpha: 0.2)),
                  ),
                  child: const Icon(Icons.verified_user, color: Color(0xFF2E7D32), size: 40),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    final now = DateTime.now();
    final hour = now.hour;
    String greeting;
    IconData icon;
    if (hour < 12) { greeting = 'Good morning'; icon = Icons.wb_sunny; }
    else if (hour < 17) { greeting = 'Good afternoon'; icon = Icons.wb_cloudy; }
    else { greeting = 'Good evening'; icon = Icons.nightlight_round; }

    return GlassCard(
      padding: const EdgeInsets.all(24),
      borderColor: AppTheme.greenBright.withValues(alpha: 0.2),
      boxShadow: AppTheme.cardGlow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.gold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppTheme.gold, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$greeting, ${widget.user.name.split(' ').first}!',
                      style: const TextStyle(color: AppTheme.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text(widget.user.school,
                      style: const TextStyle(color: AppTheme.white60, fontSize: 13)),
                    if (widget.user.schoolMotto != null && widget.user.schoolMotto!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text('"${widget.user.schoolMotto!}"',
                        style: const TextStyle(color: AppTheme.gold, fontSize: 11, fontStyle: FontStyle.italic)),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.greenBright.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.greenBright.withValues(alpha: 0.2)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_awesome, size: 14, color: AppTheme.greenBright),
                SizedBox(width: 6),
                Text('Ready to explore Zimbabwean heritage?',
                  style: TextStyle(color: AppTheme.greenBright, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String label, String value, Color color, IconData bgIcon) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderColor: color.withValues(alpha: 0.2),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: AppTheme.white60, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildPastExamsCard() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderColor: Colors.deepPurple.withValues(alpha: 0.2),
      boxShadow: [
        BoxShadow(color: Colors.deepPurple.withValues(alpha: 0.12), blurRadius: 16, offset: const Offset(0, 4)),
      ],
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Past Exam Questions',
                  style: TextStyle(color: Colors.deepPurple, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('Practice with real past papers',
                  style: TextStyle(color: AppTheme.white60, fontSize: 13)),
                const SizedBox(height: 8),
                Text('Available for Grade 5 to Form 6',
                  style: TextStyle(color: Colors.deepPurple.withValues(alpha: 0.7), fontSize: 11)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.2)),
            ),
            child: const Icon(Icons.history_edu, color: Colors.deepPurple, size: 40),
          ),
        ],
      ),
    );
  }

Widget _buildSubjectCard(Subject data) {
    final color = Color(int.parse(data.color));
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      borderColor: color.withValues(alpha: 0.2),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubjectDetailScreen(subject: data, user: widget.user),
          ),
        );
      },
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              image: _getSubjectImage(data.name) != null ? DecorationImage(
                image: AssetImage(_getSubjectImage(data.name)!),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(color.withValues(alpha: 0.5), BlendMode.screen),
              ) : null,
            ),
            child: _getSubjectImage(data.name) == null
              ? Center(child: Icon(_getIcon(data.icon), color: color, size: 24))
              : null,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(data.name, 
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppTheme.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.greenBright.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppTheme.greenBright.withValues(alpha: 0.3)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.verified, color: AppTheme.greenBright, size: 10),
                          SizedBox(width: 2),
                          Text('NDS1 Aligned', style: TextStyle(color: AppTheme.greenBright, fontSize: 8, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(data.description, maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppTheme.white50, fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.arrow_forward_ios, color: color, size: 14),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String name) {
    switch (name) {
      case 'abc': return Icons.abc;
      case 'calculate': return Icons.calculate;
      case 'translate': return Icons.translate;
      case 'account_balance': return Icons.account_balance;
      case 'science': return Icons.science;
      case 'palette': return Icons.palette;
      case 'church': return Icons.church;
      case 'sports': return Icons.sports;
      case 'computer': return Icons.computer;
      case 'agriculture': return Icons.agriculture;
      case 'public': return Icons.public;
      case 'explore': return Icons.explore;
      case 'music_note': return Icons.music_note;
      case 'trending_up': return Icons.trending_up;
      case 'business': return Icons.business;
      case 'restaurant': return Icons.restaurant;
      case 'build': return Icons.build;
      case 'psychology': return Icons.psychology;
      case 'groups': return Icons.groups;
      case 'gavel': return Icons.gavel;
      default: return Icons.book;
    }
  }

  String? _getSubjectImage(String name) {
    if (name.contains('Math')) return 'assets/images/subject_math.png';
    if (name.contains('Science')) return 'assets/images/subject_science.png';
    if (name.contains('English')) return 'assets/images/subject_english.png';
    return null;
  }

  Widget _buildECDPlayArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Play & Learn', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.white)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: GlassCard(
                padding: const EdgeInsets.all(16),
                borderColor: Colors.pinkAccent.withValues(alpha: 0.4),
                boxShadow: [BoxShadow(color: Colors.pinkAccent.withValues(alpha: 0.2), blurRadius: 10)],
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const EcdStoryScreen()));
                },
                child: const Column(
                  children: [
                    Icon(Icons.menu_book_rounded, color: Colors.pinkAccent, size: 40),
                    SizedBox(height: 8),
                    Text('Story Time', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                    Text('Read & Listen', style: TextStyle(color: Colors.white70, fontSize: 11)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GlassCard(
                padding: const EdgeInsets.all(16),
                borderColor: Colors.lightBlueAccent.withValues(alpha: 0.4),
                boxShadow: [BoxShadow(color: Colors.lightBlueAccent.withValues(alpha: 0.2), blurRadius: 10)],
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const EcdWordGamesScreen()));
                },
                child: const Column(
                  children: [
                    Icon(Icons.record_voice_over, color: Colors.lightBlueAccent, size: 40),
                    SizedBox(height: 8),
                    Text('Word Games', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                    Text('Animals & Transport', style: TextStyle(color: Colors.white70, fontSize: 11)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GlassCard(
          padding: const EdgeInsets.all(16),
          borderColor: Colors.orangeAccent.withValues(alpha: 0.4),
          boxShadow: [BoxShadow(color: Colors.orangeAccent.withValues(alpha: 0.2), blurRadius: 10)],
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const EcdColoringScreen()));
          },
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.palette, color: Colors.orangeAccent, size: 30),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Coloring Book', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 4),
                    Text('Draw and color animals on canvas', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
