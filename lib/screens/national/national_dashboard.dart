import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/national_models.dart';
import '../../data/national_data.dart';
import '../../services/analytics_service.dart';
import '../../widgets/glass_card.dart';

class NationalDashboard extends StatefulWidget {
  const NationalDashboard({super.key});
  @override
  State<NationalDashboard> createState() => _NationalDashboardState();
}

class _NationalDashboardState extends State<NationalDashboard> with SingleTickerProviderStateMixin {
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
        title: const Text('National Command Centre'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF06120A), Color(0xFF0F2416), Color(0xFF0B1A10)],
              begin: Alignment.topCenter, end: Alignment.bottomCenter,
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.gold,
          labelColor: AppTheme.gold,
          unselectedLabelColor: AppTheme.white50,
          tabs: const [
            Tab(icon: Icon(Icons.dashboard), text: 'Overview'),
            Tab(icon: Icon(Icons.track_changes), text: 'NDS1 KPIs'),
            Tab(icon: Icon(Icons.map), text: 'Provinces'),
            Tab(icon: Icon(Icons.flag), text: 'Vision 2030'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverview(),
          _buildNDS1Tab(),
          _buildProvincesTab(),
          _buildVision2030Tab(),
        ],
      ),
    );
  }

  Widget _buildOverview() {
    final metrics = getNationalMetrics();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlassCard(
            padding: const EdgeInsets.all(20),
            borderColor: AppTheme.gold.withValues(alpha: 0.2),
            boxShadow: AppTheme.goldGlow,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.gold.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.gold.withValues(alpha: 0.2)),
                      ),
                      child: const Icon(Icons.account_balance, color: AppTheme.gold, size: 32),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Republic of Zimbabwe', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.white)),
                          Text('Ministry of Primary & Secondary Education', style: TextStyle(fontSize: 13, color: AppTheme.white60)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildHeaderStat('10', 'Provinces', Icons.map),
                    const SizedBox(width: 12),
                    _buildHeaderStat('63', 'Districts', Icons.hub),
                    const SizedBox(width: 12),
                    _buildHeaderStat('9,872', 'Schools', Icons.school),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('National Education KPIs',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
          const SizedBox(height: 12),
          ...metrics.map((m) => _buildMetricCard(m)),
          const SizedBox(height: 20),
          GlassCard(
            padding: const EdgeInsets.all(20),
            borderColor: Colors.orange.withValues(alpha: 0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning_amber, color: Colors.orange, size: 20),
                    const SizedBox(width: 8),
                    const Text('Early Warning: Intervention Required',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange)),
                  ],
                ),
                const SizedBox(height: 12),
                _buildAlertItem('Matabeleland North', '58.3% pass rate — below national average', Colors.red),
                _buildAlertItem('Masvingo', '68.2% pass rate — needs improvement', Colors.orange),
                _buildAlertItem('7 schools without electricity', 'Infrastructure gap in rural areas', Colors.orange),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppTheme.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: AppTheme.gold),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.white)),
            Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.white50)),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(NationalMetric m) {
    Color c;
    IconData icn;
    switch (m.icon) {
      case IconType.school: c = Colors.blue; icn = Icons.school; break;
      case IconType.student: c = AppTheme.greenBright; icn = Icons.people; break;
      case IconType.teacher: c = Colors.purple; icn = Icons.person; break;
      case IconType.passRate: c = AppTheme.gold; icn = Icons.trending_up; break;
      case IconType.attendance: c = Colors.orange; icn = Icons.calendar_view_day; break;
      case IconType.internet: c = Colors.cyan; icn = Icons.wifi; break;
      default: c = AppTheme.white60; icn = Icons.circle; break;
    }
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      borderColor: c.withValues(alpha: 0.2),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: c.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
            child: Icon(icn, color: c, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(m.value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: c)),
                Text(m.label, style: const TextStyle(fontSize: 12, color: AppTheme.white60)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: m.isPositive ? AppTheme.greenBright.withValues(alpha: 0.15) : Colors.red.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(m.isPositive ? Icons.arrow_upward : Icons.arrow_downward, size: 12,
                    color: m.isPositive ? AppTheme.greenBright : Colors.red),
                const SizedBox(width: 2),
                Text(m.delta, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold,
                    color: m.isPositive ? AppTheme.greenBright : Colors.red)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertItem(String title, String subtitle, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            width: 8, height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: color)),
                Text(subtitle, style: const TextStyle(fontSize: 11, color: AppTheme.white50)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNDS1Tab() {
    final kpis = getNDS1KPIs();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlassCard(
            padding: const EdgeInsets.all(20),
            borderColor: AppTheme.gold.withValues(alpha: 0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.track_changes, color: AppTheme.gold, size: 24),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('NDS1 Education KPIs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
                          Text('National Development Strategy 1 (2021-2025)', style: TextStyle(fontSize: 11, color: AppTheme.white50)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.greenBright.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.greenBright.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: AppTheme.greenBright, size: 16),
                      const SizedBox(width: 8),
                      Text('${kpis.where((k) => k.status == 'on-track').length} of ${kpis.length} KPIs on track',
                        style: const TextStyle(color: AppTheme.greenBright, fontWeight: FontWeight.w600, fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...kpis.map((kpi) => _buildKPI(kpi)),
        ],
      ),
    );
  }

  Widget _buildKPI(NDS1KPI kpi) {
    final progress = ((kpi.current - kpi.baseline2021) / (kpi.target2025 - kpi.baseline2021) * 100).clamp(0, 100);
    final statusColor = kpi.status == 'on-track' ? AppTheme.greenBright : Colors.orange;
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      borderColor: statusColor.withValues(alpha: 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(kpi.indicator,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.white)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(kpi.status.replaceAll('-', ' ').toUpperCase(),
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: statusColor)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildKPIStat('2021', '${kpi.baseline2021}%', AppTheme.white50),
              _buildKPIStat('Current', '${kpi.current}%', AppTheme.gold),
              _buildKPIStat('2025 Target', '${kpi.target2025}%', AppTheme.greenBright),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: AppTheme.white10,
              valueColor: AlwaysStoppedAnimation(statusColor),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 4),
          Text('${progress.toStringAsFixed(0)}% towards target',
            style: const TextStyle(fontSize: 10, color: AppTheme.white50)),
        ],
      ),
    );
  }

  Widget _buildKPIStat(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.white50)),
        ],
      ),
    );
  }

  Widget _buildProvincesTab() {
    final provinces = getProvinces();
    final rates = AnalyticsService.passRateByProvince();
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: provinces.length,
      itemBuilder: (context, index) {
        final p = provinces[index];
        final rate = rates[p.name] ?? 0;
        return GlassCard(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(14),
          borderColor: rate >= 70 ? AppTheme.greenBright.withValues(alpha: 0.2) :
                       rate >= 60 ? Colors.orange.withValues(alpha: 0.2) :
                       Colors.red.withValues(alpha: 0.2),
          onTap: () {},
          child: Row(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: (rate >= 70 ? AppTheme.greenBright : rate >= 60 ? Colors.orange : Colors.red).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text('${index + 1}',
                    style: TextStyle(fontWeight: FontWeight.bold, color: rate >= 70 ? AppTheme.greenBright : rate >= 60 ? Colors.orange : Colors.red)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppTheme.white)),
                    Text('${p.districts.length} districts  •  ${p.population ~/ 1000}K pop',
                      style: const TextStyle(fontSize: 11, color: AppTheme.white50)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${rate.toStringAsFixed(1)}%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,
                      color: rate >= 70 ? AppTheme.greenBright : rate >= 60 ? Colors.orange : Colors.red)),
                  const Text('pass rate', style: TextStyle(fontSize: 10, color: AppTheme.white50)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVision2030Tab() {
    final goals = getNdsGoals();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlassCard(
            padding: const EdgeInsets.all(20),
            borderColor: AppTheme.gold.withValues(alpha: 0.2),
            boxShadow: AppTheme.goldGlow,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppTheme.gold.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.gold.withValues(alpha: 0.2)),
                  ),
                  child: const Icon(Icons.flag, color: AppTheme.gold, size: 40),
                ),
                const SizedBox(height: 16),
                const Text('Vision 2030',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.white)),
                const SizedBox(height: 4),
                const Text('An empowered upper-middle-income society through quality education for all',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: AppTheme.white60)),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.greenBright.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.greenBright.withValues(alpha: 0.15)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildVisionStat('Education', 'SDG 4', Icons.school),
                      _buildVisionStat('Equality', 'SDG 5', Icons.people),
                      _buildVisionStat('Reduced Gaps', 'SDG 10', Icons.trending_down),
                      _buildVisionStat('Partnerships', 'SDG 17', Icons.handshake),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('National Goals Progress',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
          const SizedBox(height: 12),
          ...goals.map((g) => _buildGoalCard(g)),
        ],
      ),
    );
  }

  Widget _buildVisionStat(String label, String sub, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.greenBright, size: 22),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.white70, fontWeight: FontWeight.w500)),
        Text(sub, style: const TextStyle(fontSize: 9, color: AppTheme.white50)),
      ],
    );
  }

  Widget _buildGoalCard(NdsGoal g) {
    final color = Color(int.parse(g.color));
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      borderColor: color.withValues(alpha: 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                child: Icon(Icons.flag, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(g.title,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: color)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(g.description,
            style: const TextStyle(fontSize: 12, color: AppTheme.white70, height: 1.4)),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: g.progress,
              backgroundColor: AppTheme.white10,
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${(g.progress * 100).toStringAsFixed(0)}% complete',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
              Text(g.target,
                style: const TextStyle(fontSize: 11, color: AppTheme.white50)),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
          const SizedBox(height: 8),
          const Text('Milestones:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.white60)),
          const SizedBox(height: 4),
          ...g.milestones.map((m) => Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Row(
              children: [
                Icon(Icons.check_circle_outline, size: 12, color: color),
                const SizedBox(width: 6),
                Text(m, style: const TextStyle(fontSize: 11, color: AppTheme.white50)),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
