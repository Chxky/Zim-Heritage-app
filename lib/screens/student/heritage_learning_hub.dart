import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import 'modules/unhu_ubuntu_screen.dart';
import 'modules/ancient_states_screen.dart';
import 'modules/liberation_struggle_screen.dart';
import 'modules/civic_governance_screen.dart';

class HeritageLearningHub extends StatelessWidget {
  const HeritageLearningHub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heritage Learning Hub'),
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
      backgroundColor: AppTheme.surfaceDark,
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.splashGradient),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              const Text('Unit 1: Unhu / Ubuntu', 
                style: TextStyle(color: AppTheme.gold, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildLessonCard(
                context,
                title: 'The Philosophy of Unhu',
                description: 'Explore the core values of Zimbabwean culture, including respect, compassion, and communal responsibility.',
                icon: Icons.people_outline,
                color: Colors.orangeAccent,
                targetScreen: const UnhuUbuntuScreen(),
              ),
              const SizedBox(height: 24),
              const Text('Unit 2: National History', 
                style: TextStyle(color: AppTheme.gold, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildInteractiveHistoryCard(
                context,
                title: 'Great Zimbabwe & Ancient States',
                description: 'Learn about the Mutapa Empire, the Rozvi State, and the architectural marvels of Great Zimbabwe.',
                icon: Icons.castle,
                color: AppTheme.gold,
                hasVR: true,
                targetScreen: const AncientStatesScreen(),
              ),
              const SizedBox(height: 12),
              _buildLessonCard(
                context,
                title: 'The Liberation Struggle',
                description: 'The First and Second Chimurenga, and the path to Zimbabwe\'s independence in 1980.',
                icon: Icons.flag,
                color: Colors.greenAccent,
                targetScreen: const LiberationStruggleScreen(),
              ),
              const SizedBox(height: 24),
              const Text('Unit 3: Civic Governance', 
                style: TextStyle(color: AppTheme.gold, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildLessonCard(
                context,
                title: 'The Constitution & Rights',
                description: 'Understanding the laws, rights, and responsibilities of a Zimbabwean citizen.',
                icon: Icons.gavel,
                color: Colors.lightBlueAccent,
                targetScreen: const CivicGovernanceScreen(),
              ),
              const SizedBox(height: 32),
              _buildQuizCTA(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderColor: AppTheme.gold.withValues(alpha: 0.3),
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
                Text('Heritage Studies', 
                  style: TextStyle(color: AppTheme.white, fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Core Curriculum Interactive Modules', 
                  style: TextStyle(color: AppTheme.gold, fontSize: 13, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonCard(BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required Widget targetScreen,
  }) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderColor: color.withValues(alpha: 0.3),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => targetScreen));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: AppTheme.white, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(description, style: const TextStyle(color: AppTheme.white70, fontSize: 13, height: 1.4)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppTheme.white50),
        ],
      ),
    );
  }

  Widget _buildInteractiveHistoryCard(BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required bool hasVR,
    required Widget targetScreen,
  }) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderColor: color.withValues(alpha: 0.3),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => targetScreen));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: AppTheme.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(description, style: const TextStyle(color: AppTheme.white70, fontSize: 13, height: 1.4)),
                  ],
                ),
              ),
            ],
          ),
          if (hasVR) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.purpleAccent, Colors.deepPurple]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.pushNamed(context, '/heritage'); // Routes to the Virtual Tour hub
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.vrpano, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text('Launch VR Virtual Tour', 
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuizCTA(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryGreen.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          const Icon(Icons.quiz, color: AppTheme.primaryGreen, size: 40),
          const SizedBox(height: 12),
          const Text('Knowledge Check', 
            style: TextStyle(color: AppTheme.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Test your knowledge of the Heritage Syllabus and earn badges!', 
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.white70, fontSize: 13)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Starting Quiz...')));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              foregroundColor: AppTheme.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text('Start Practice Quiz'),
          ),
        ],
      ),
    );
  }
}
