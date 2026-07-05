import 'package:flutter/material.dart';

import '../services/challenge_service.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Challenge> _available = [];
  List<Challenge> _active = [];
  List<Challenge> _completed = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadChallenges();
  }

  Future<void> _loadChallenges() async {
    final available = await ChallengeService.getAvailableChallenges();
    final active = await ChallengeService.getActiveChallenges();
    final completedIds = <Challenge>[];
    for (final c in available) {
      if (await ChallengeService.isCompleted(c.id)) {
        completedIds.add(c);
      }
    }
    if (mounted) {
      setState(() {
        _available = available;
        _active = active;
        _completed = completedIds;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenges', style: TextStyle(fontWeight: FontWeight.bold)),
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
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.gold,
          labelColor: AppTheme.gold,
          unselectedLabelColor: AppTheme.white60,
          tabs: const [
            Tab(text: 'Available'),
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildChallengeList(_available, showAccept: true),
          _buildChallengeList(_active, showProgress: true),
          _buildChallengeList(_completed, showCompleted: true),
        ],
      ),
    );
  }

  Widget _buildChallengeList(List<Challenge> challenges,
      {bool showAccept = false, bool showProgress = false, bool showCompleted = false}) {
    if (challenges.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(showCompleted ? Icons.emoji_events : Icons.flag,
              size: 64, color: AppTheme.white30),
            const SizedBox(height: 16),
            Text(
              showCompleted ? 'No completed challenges yet' : 'No challenges available',
              style: const TextStyle(color: AppTheme.white60, fontSize: 16)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: challenges.length,
      itemBuilder: (ctx, i) {
        final challenge = challenges[i];
        return GlassCard(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(challenge.icon, style: const TextStyle(fontSize: 28)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(challenge.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.white,
                            fontSize: 16,
                          )),
                        Text(challenge.description,
                          style: const TextStyle(color: AppTheme.white60, fontSize: 13)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.gold.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.gold.withValues(alpha: 0.3)),
                    ),
                    child: Text('+${challenge.xpReward} XP',
                      style: const TextStyle(color: AppTheme.gold, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: challenge.type == 'weekly'
                          ? AppTheme.greenBright.withValues(alpha: 0.15)
                          : Colors.purple.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(challenge.type.toUpperCase(),
                      style: TextStyle(
                        color: challenge.type == 'weekly' ? AppTheme.greenBright : Colors.purple,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      )),
                  ),
                  const Spacer(),
                  if (showAccept)
                    ElevatedButton(
                      onPressed: () async {
                        await ChallengeService.acceptChallenge(challenge.id);
                        _loadChallenges();
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Challenge accepted: ${challenge.title}'),
                              backgroundColor: AppTheme.greenBright),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.greenBright,
                        foregroundColor: AppTheme.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child: const Text('Accept'),
                    ),
                  if (showProgress)
                    FutureBuilder<int>(
                      future: ChallengeService.getProgress(challenge.id),
                      builder: (ctx, snapshot) {
                        final progress = snapshot.data ?? 0;
                        final pct = (progress / challenge.target).clamp(0.0, 1.0);
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 60,
                              child: LinearProgressIndicator(
                                value: pct,
                                backgroundColor: AppTheme.white10,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  pct >= 1.0 ? AppTheme.greenBright : AppTheme.gold),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text('$progress/${challenge.target}',
                              style: const TextStyle(color: AppTheme.white60, fontSize: 12)),
                          ],
                        );
                      },
                    ),
                  if (showCompleted)
                    const Icon(Icons.check_circle, color: AppTheme.greenBright, size: 24),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
