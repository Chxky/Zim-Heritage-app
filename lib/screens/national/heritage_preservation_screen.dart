import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/heritage.dart';
import '../../data/heritage_data.dart';
import '../../widgets/glass_card.dart';

class HeritagePreservationScreen extends StatefulWidget {
  const HeritagePreservationScreen({super.key});
  @override
  State<HeritagePreservationScreen> createState() => _HeritagePreservationScreenState();
}

class _HeritagePreservationScreenState extends State<HeritagePreservationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
        title: const Text('Heritage Preservation'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF4A148C), Color(0xFF7B1FA2), Color(0xFFAB47BC)],
              begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.gold,
          labelColor: AppTheme.gold,
          unselectedLabelColor: AppTheme.white50,
          tabs: const [
            Tab(icon: Icon(Icons.map), text: 'Sites'),
            Tab(icon: Icon(Icons.record_voice_over), text: 'Oral History'),
            Tab(icon: Icon(Icons.psychology), text: 'Knowledge'),
            Tab(icon: Icon(Icons.celebration), text: 'Culture'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSitesTab(),
          _buildOralHistoryTab(),
          _buildKnowledgeTab(),
          _buildCultureTab(),
        ],
      ),
    );
  }

  Widget _buildSitesTab() {
    final sites = getHeritageSites();
    final unescoCount = sites.where((s) => s.isUnesco).length;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sites.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GlassCard(
              padding: const EdgeInsets.all(16),
              borderColor: const Color(0xFFAB47BC).withValues(alpha: 0.2),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFAB47BC).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.map, color: Color(0xFFAB47BC), size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Zimbabwe Heritage Sites', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
                        Text('${sites.length} sites • $unescoCount UNESCO • ${sites.where((s) => !s.isUnesco).length} national',
                          style: const TextStyle(fontSize: 12, color: AppTheme.white60)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        final site = sites[index - 1];
        return _buildSiteCard(site);
      },
    );
  }

  Widget _buildSiteCard(HeritageSite s) {
    Color catColor;
    switch (s.category) {
      case 'unesco_cultural': catColor = Colors.amber; break;
      case 'unesco_natural': catColor = AppTheme.greenBright; break;
      case 'national_monument': catColor = Colors.blue; break;
      case 'rock_art': catColor = Colors.orange; break;
      case 'archaeological': catColor = Colors.brown; break;
      default: catColor = AppTheme.gold;
    }
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      borderColor: catColor.withValues(alpha: 0.2),
      onTap: () => _showSiteDetail(context, s, catColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: catColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: catColor.withValues(alpha: 0.15)),
                ),
                child: Icon(s.isUnesco ? Icons.emoji_events : Icons.location_on, color: catColor, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppTheme.white)),
                    Text('${s.location}, ${s.province}', style: const TextStyle(fontSize: 11, color: AppTheme.white50)),
                  ],
                ),
              ),
              if (s.isUnesco)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(color: catColor.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6)),
                  child: const Text('UNESCO', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.amber)),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(s.description, maxLines: 2, overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: AppTheme.white70, height: 1.3)),
        ],
      ),
    );
  }

  Widget _buildOralHistoryTab() {
    final histories = getOralHistories();
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: histories.length,
      itemBuilder: (context, index) {
        final h = histories[index];
        return GlassCard(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(14),
          borderColor: Colors.teal.withValues(alpha: 0.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.teal.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.record_voice_over, color: Colors.teal, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(h.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppTheme.white)),
                        Text('${h.storyteller} • ${h.community}', style: const TextStyle(fontSize: 11, color: AppTheme.white60)),
                      ],
                    ),
                  ),
                  if (h.verified)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: AppTheme.greenBright.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
                      child: const Icon(Icons.verified, size: 16, color: AppTheme.greenBright),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(h.summary, style: const TextStyle(fontSize: 12, color: AppTheme.white70, height: 1.3)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 12, color: AppTheme.white50),
                  const SizedBox(width: 4),
                  Text('${(h.durationSeconds / 60).toStringAsFixed(0)} min',
                    style: const TextStyle(fontSize: 10, color: AppTheme.white50)),
                  const SizedBox(width: 12),
                  const Icon(Icons.translate, size: 12, color: AppTheme.white50),
                  const SizedBox(width: 4),
                  Text(h.language, style: const TextStyle(fontSize: 10, color: AppTheme.white50)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.teal.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(4)),
                    child: Text(h.category, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.teal)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildKnowledgeTab() {
    final knowledge = getIndigenousKnowledge();
    final preserved = knowledge.where((k) => k.preserved).length;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: knowledge.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GlassCard(
              padding: const EdgeInsets.all(16),
              borderColor: Colors.cyan.withValues(alpha: 0.2),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.cyan.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.psychology, color: Colors.cyan, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Indigenous Knowledge Systems', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.white)),
                        Text('$preserved preserved • ${knowledge.length - preserved} awaiting documentation',
                          style: const TextStyle(fontSize: 11, color: AppTheme.white60)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        final k = knowledge[index - 1];
        return _buildKnowledgeCard(k);
      },
    );
  }

  Widget _buildKnowledgeCard(IndigenousKnowledge k) {
    Color catColor;
    IconData catIcon;
    switch (k.category) {
      case 'medicine': catColor = Colors.teal; catIcon = Icons.medication; break;
      case 'agriculture': catColor = AppTheme.greenBright; catIcon = Icons.agriculture; break;
      case 'technology': catColor = Colors.blue; catIcon = Icons.handyman; break;
      case 'environment': catColor = Colors.green; catIcon = Icons.eco; break;
      default: catColor = Colors.orange; catIcon = Icons.lightbulb;
    }
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      borderColor: catColor.withValues(alpha: 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: catColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
                child: Icon(catIcon, color: catColor, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(k.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppTheme.white)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: k.preserved ? AppTheme.greenBright.withValues(alpha: 0.12) : Colors.orange.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(k.preserved ? 'Preserved' : 'At Risk',
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold,
                    color: k.preserved ? AppTheme.greenBright : Colors.orange)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(k.description, style: const TextStyle(fontSize: 12, color: AppTheme.white70, height: 1.3)),
          if (k.application.isNotEmpty) ...[
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: catColor.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Icon(Icons.touch_app, size: 14, color: catColor),
                  const SizedBox(width: 6),
                  Expanded(child: Text(k.application, style: TextStyle(fontSize: 11, color: catColor))),
                ],
              ),
            ),
          ],
          if (k.curriculumLink.isNotEmpty) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.book, size: 12, color: Colors.blue),
                const SizedBox(width: 4),
                Text('Curriculum: ${k.curriculumLink}', style: const TextStyle(fontSize: 10, color: Colors.blue)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCultureTab() {
    final practices = getCulturalPractices();
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: practices.length,
      itemBuilder: (context, index) {
        final p = practices[index];
        return GlassCard(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(14),
          borderColor: Colors.deepOrange.withValues(alpha: 0.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.celebration, color: Colors.deepOrange, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppTheme.white)),
                        Text(p.community, style: const TextStyle(fontSize: 11, color: AppTheme.white60)),
                      ],
                    ),
                  ),
                  if (p.season.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: AppTheme.gold.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
                      child: Text(p.season, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppTheme.gold)),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(p.description, style: const TextStyle(fontSize: 12, color: AppTheme.white70, height: 1.3)),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.info, size: 12, color: Colors.deepOrange),
                  const SizedBox(width: 4),
                  Expanded(child: Text(p.significance, style: const TextStyle(fontSize: 11, color: Colors.deepOrange, fontWeight: FontWeight.w500))),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSiteDetail(BuildContext context, HeritageSite s, Color catColor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(margin: const EdgeInsets.only(bottom: 16), alignment: Alignment.center,
                width: 40, height: 4,
                decoration: BoxDecoration(color: AppTheme.white30, borderRadius: BorderRadius.circular(2))),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: catColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(16)),
                    child: Icon(s.isUnesco ? Icons.emoji_events : Icons.location_on, color: catColor, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.white)),
                        Text('${s.location}, ${s.province} Province', style: const TextStyle(fontSize: 13, color: AppTheme.white60)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('About', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.white)),
              const SizedBox(height: 8),
              Text(s.description, style: const TextStyle(fontSize: 14, color: AppTheme.white80, height: 1.6)),
              const SizedBox(height: 16),
              const Text('Significance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.white)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: catColor.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: catColor.withValues(alpha: 0.15)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, color: catColor, size: 18),
                    const SizedBox(width: 10),
                    Expanded(child: Text(s.significance, style: TextStyle(fontSize: 13, color: catColor, height: 1.4))),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.near_me),
                      label: const Text('Directions'),
                      style: OutlinedButton.styleFrom(foregroundColor: catColor, side: BorderSide(color: catColor)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.videocam),
                      label: const Text('Virtual Tour'),
                      style: ElevatedButton.styleFrom(backgroundColor: catColor, foregroundColor: AppTheme.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
