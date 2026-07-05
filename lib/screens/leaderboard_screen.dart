import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';

class LeaderboardScreen extends StatefulWidget {
  final String? currentUserId;
  final String? currentUserSchool;

  const LeaderboardScreen({super.key, this.currentUserId, this.currentUserSchool});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static final List<Map<String, dynamic>> _schoolLeaderboard = [
    {'rank': 1, 'name': 'Tendai Musoni', 'xp': 2450, 'level': 'Heritage Champion', 'badge': 'assets/images/zimbabwe_bird_logo.svg'},
    {'rank': 2, 'name': 'Rutendo Mafukidze', 'xp': 2100, 'level': 'Achiever', 'badge': ''},
    {'rank': 3, 'name': 'Chipo Dube', 'xp': 1850, 'level': 'Scholar', 'badge': ''},
    {'rank': 4, 'name': 'Tapiwa Ncube', 'xp': 1600, 'level': 'Scholar', 'badge': ''},
    {'rank': 5, 'name': 'Farai Moyo', 'xp': 1400, 'level': 'Explorer', 'badge': ''},
    {'rank': 6, 'name': 'Blessing Sibanda', 'xp': 1200, 'level': 'Explorer', 'badge': ''},
    {'rank': 7, 'name': 'Ruvimbo Nyathi', 'xp': 1050, 'level': 'Explorer', 'badge': ''},
    {'rank': 8, 'name': 'Tanaka Chirwa', 'xp': 900, 'level': 'Learner', 'badge': ''},
    {'rank': 9, 'name': 'Kudzai Mlambo', 'xp': 750, 'level': 'Learner', 'badge': ''},
    {'rank': 10, 'name': 'Anesu Dziva', 'xp': 600, 'level': 'Learner', 'badge': ''},
  ];

  static final List<Map<String, dynamic>> _districtLeaderboard = [
    {'rank': 1, 'name': 'Harare Central', 'xp': 45200, 'type': 'District'},
    {'rank': 2, 'name': 'Bulawayo', 'xp': 42100, 'type': 'District'},
    {'rank': 3, 'name': 'Masvingo', 'xp': 38500, 'type': 'District'},
    {'rank': 4, 'name': 'Midlands', 'xp': 35800, 'type': 'District'},
    {'rank': 5, 'name': 'Manicaland', 'xp': 33200, 'type': 'District'},
  ];

  static final List<Map<String, dynamic>> _provinceLeaderboard = [
    {'rank': 1, 'name': 'Harare', 'xp': 125000, 'passRate': 78.5},
    {'rank': 2, 'name': 'Bulawayo', 'xp': 118000, 'passRate': 75.2},
    {'rank': 3, 'name': 'Mashonaland East', 'xp': 105000, 'passRate': 72.1},
    {'rank': 4, 'name': 'Midlands', 'xp': 98000, 'passRate': 68.4},
    {'rank': 5, 'name': 'Manicaland', 'xp': 92000, 'passRate': 66.8},
    {'rank': 6, 'name': 'Mashonaland West', 'xp': 88000, 'passRate': 65.2},
    {'rank': 7, 'name': 'Mashonaland Central', 'xp': 82000, 'passRate': 63.1},
    {'rank': 8, 'name': 'Masvingo', 'xp': 78000, 'passRate': 61.5},
    {'rank': 9, 'name': 'Matabeleland North', 'xp': 65000, 'passRate': 58.3},
    {'rank': 10, 'name': 'Matabeleland South', 'xp': 62000, 'passRate': 56.8},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
        title: const Text('Leaderboard', style: TextStyle(fontWeight: FontWeight.bold)),
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
            Tab(text: 'School'),
            Tab(text: 'District'),
            Tab(text: 'Province'),
            Tab(text: 'National'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSchoolTab(),
          _buildDistrictTab(),
          _buildProvinceTab(),
          _buildNationalTab(),
        ],
      ),
    );
  }

  Widget _buildSchoolTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _schoolLeaderboard.length,
      itemBuilder: (ctx, i) {
        final entry = _schoolLeaderboard[i];
        final rank = entry['rank'] as int;
        final isTop3 = rank <= 3;
        final isCurrentUser = entry['name'] == 'Tendai Musoni';

        return GlassCard(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(16),
          borderColor: isTop3
              ? (rank == 1 ? AppTheme.gold : (rank == 2 ? AppTheme.white50 : AppTheme.white30))
              : (isCurrentUser ? AppTheme.greenBright.withValues(alpha: 0.3) : null),
          child: Row(
            children: [
              _buildRankBadge(rank),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry['name'] as String,
                      style: TextStyle(
                        fontWeight: isTop3 ? FontWeight.bold : FontWeight.w500,
                        color: isCurrentUser ? AppTheme.greenBright : AppTheme.white,
                        fontSize: 15,
                      )),
                    Text(entry['level'] as String,
                      style: const TextStyle(color: AppTheme.white60, fontSize: 12)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${entry['xp']} XP',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isTop3 ? AppTheme.gold : AppTheme.white,
                      fontSize: 16,
                    )),
                  if (isCurrentUser)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.greenBright.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('You', style: TextStyle(color: AppTheme.greenBright, fontSize: 10)),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDistrictTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _districtLeaderboard.length,
      itemBuilder: (ctx, i) {
        final entry = _districtLeaderboard[i];
        final rank = entry['rank'] as int;

        return GlassCard(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(16),
          borderColor: rank <= 3
              ? (rank == 1 ? AppTheme.gold : (rank == 2 ? AppTheme.white50 : AppTheme.white30))
              : null,
          child: Row(
            children: [
              _buildRankBadge(rank),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry['name'] as String,
                      style: TextStyle(
                        fontWeight: rank <= 3 ? FontWeight.bold : FontWeight.w500,
                        color: AppTheme.white,
                        fontSize: 15,
                      )),
                    Text(entry['type'] as String,
                      style: const TextStyle(color: AppTheme.white60, fontSize: 12)),
                  ],
                ),
              ),
              Text('${entry['xp']} XP',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: rank <= 3 ? AppTheme.gold : AppTheme.white,
                  fontSize: 16,
                )),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProvinceTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _provinceLeaderboard.length,
      itemBuilder: (ctx, i) {
        final entry = _provinceLeaderboard[i];
        final rank = entry['rank'] as int;
        final passRate = entry['passRate'] as double;

        return GlassCard(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(16),
          borderColor: rank <= 3
              ? (rank == 1 ? AppTheme.gold : (rank == 2 ? AppTheme.white50 : AppTheme.white30))
              : null,
          child: Row(
            children: [
              _buildRankBadge(rank),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry['name'] as String,
                      style: TextStyle(
                        fontWeight: rank <= 3 ? FontWeight.bold : FontWeight.w500,
                        color: AppTheme.white,
                        fontSize: 15,
                      )),
                    Row(
                      children: [
                        const Text('Pass Rate: ', style: TextStyle(color: AppTheme.white60, fontSize: 12)),
                        Text('${passRate.toStringAsFixed(1)}%',
                          style: TextStyle(
                            color: passRate >= 70 ? AppTheme.greenBright : AppTheme.gold,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          )),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${entry['xp']} XP',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: rank <= 3 ? AppTheme.gold : AppTheme.white,
                      fontSize: 16,
                    )),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNationalTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.gold.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.gold.withValues(alpha: 0.3)),
            ),
            child: const Icon(Icons.emoji_events, color: AppTheme.gold, size: 64),
          ),
          const SizedBox(height: 24),
          const Text('National Rankings Coming Soon!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.white)),
          const SizedBox(height: 8),
          const Text('Compete with schools across Zimbabwe',
            style: TextStyle(color: AppTheme.white60)),
          const SizedBox(height: 24),
          GlassCard(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const Text('Your School Rank',
                  style: TextStyle(color: AppTheme.white60, fontSize: 14)),
                const SizedBox(height: 8),
                const Text('#42', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppTheme.gold)),
                const Text('out of 9,872 schools',
                  style: TextStyle(color: AppTheme.white60)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildMiniStat('XP', '2,450', AppTheme.greenBright),
                    Container(width: 1, height: 30, color: AppTheme.white20),
                    _buildMiniStat('Level', 'Heritage Champion', AppTheme.gold),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankBadge(int rank) {
    if (rank == 1) {
      return Container(
        width: 36, height: 36,
        decoration: BoxDecoration(
          color: AppTheme.gold.withValues(alpha: 0.2),
          shape: BoxShape.circle,
          border: Border.all(color: AppTheme.gold, width: 2),
          boxShadow: [BoxShadow(color: AppTheme.gold.withValues(alpha: 0.3), blurRadius: 8)],
        ),
        child: const Center(child: Text('1', style: TextStyle(color: AppTheme.gold, fontWeight: FontWeight.bold, fontSize: 16))),
      );
    }
    if (rank == 2) {
      return Container(
        width: 36, height: 36,
        decoration: BoxDecoration(
          color: AppTheme.white10,
          shape: BoxShape.circle,
          border: Border.all(color: AppTheme.white50, width: 2),
        ),
        child: const Center(child: Text('2', style: TextStyle(color: AppTheme.white70, fontWeight: FontWeight.bold, fontSize: 16))),
      );
    }
    if (rank == 3) {
      return Container(
        width: 36, height: 36,
        decoration: BoxDecoration(
          color: AppTheme.white10,
          shape: BoxShape.circle,
          border: Border.all(color: AppTheme.white30, width: 2),
        ),
        child: const Center(child: Text('3', style: TextStyle(color: AppTheme.white60, fontWeight: FontWeight.bold, fontSize: 16))),
      );
    }
    return Container(
      width: 36, height: 36,
      decoration: const BoxDecoration(
        color: AppTheme.white10,
        shape: BoxShape.circle,
      ),
      child: Center(child: Text('$rank', style: const TextStyle(color: AppTheme.white50, fontSize: 14))),
    );
  }

  Widget _buildMiniStat(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16)),
          Text(label, style: const TextStyle(color: AppTheme.white60, fontSize: 12)),
        ],
      ),
    );
  }
}
