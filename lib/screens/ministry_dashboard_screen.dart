import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../data/demo_data.dart';
import '../data/national_data.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';

class MinistryDashboardScreen extends StatefulWidget {
  const MinistryDashboardScreen({super.key});

  @override
  State<MinistryDashboardScreen> createState() => _MinistryDashboardScreenState();
}

class _MinistryDashboardScreenState extends State<MinistryDashboardScreen> {
  bool _showRiskMap = false;

  int get totalStudents => DemoData.provinceMetrics.values.fold(0, (sum, e) => sum + (e['students'] as int));
  int get totalSchools => DemoData.provinceMetrics.values.fold(0, (sum, e) => sum + (e['schools'] as int));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text('REPUBLIC OF ZIMBABWE', style: TextStyle(fontSize: 10, color: AppTheme.gold, letterSpacing: 2, fontWeight: FontWeight.bold)),
            Text('Ministry Intelligence Dashboard', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
          ],
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.surfaceDark, AppTheme.gold.withValues(alpha: 0.1)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Image.asset('assets/images/zim_flag_real.png', height: 20, width: 30, fit: BoxFit.cover),
          ),
          IconButton(
            icon: const Icon(Icons.map_outlined, color: AppTheme.gold),
            tooltip: 'Zimbabwe Map',
            onPressed: () => Navigator.pushNamed(context, '/zimbabwe-map'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildKpiRow(),
            const SizedBox(height: 20),
            _buildSectionTitle('Province Performance', icon: Icons.map),
            const SizedBox(height: 12),
            _buildProvinceChart(),
            const SizedBox(height: 20),
            _buildSectionTitle('Early Warning System', icon: Icons.warning_amber_rounded),
            const SizedBox(height: 12),
            _buildRiskAlerts(),
            const SizedBox(height: 20),
            _buildSectionTitle('NDS1 Education Targets', icon: Icons.track_changes),
            const SizedBox(height: 12),
            _buildNds1Progress(),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiRow() {
    final kpis = [
      {'label': 'Schools', 'value': totalSchools.toString(), 'icon': Icons.school},
      {'label': 'Students', 'value': '${(totalStudents / 1e6).toStringAsFixed(1)}M', 'icon': Icons.people},
      {'label': 'Teachers', 'value': '98,432', 'icon': Icons.person},
      {'label': 'Pass Rate', 'value': '62.3%', 'icon': Icons.trending_up},
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.8,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: kpis.map((kpi) => GlassCard(
        padding: const EdgeInsets.all(12),
        borderColor: AppTheme.gold.withValues(alpha: 0.4),
        boxShadow: AppTheme.goldGlow,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.gold.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(kpi['icon'] as IconData, color: AppTheme.gold, size: 28),
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(kpi['value'] as String,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.white)),
                Text(kpi['label'] as String,
                  style: const TextStyle(fontSize: 12, color: AppTheme.gold, fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildProvinceChart() {
    final provinces = DemoData.provinceMetrics.entries.toList();
    return GlassCard(
        borderColor: AppTheme.gold.withValues(alpha: 0.2),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Pass Rate %', style: TextStyle(color: AppTheme.white70, fontSize: 12)),
                Switch(
                  value: _showRiskMap,
                  onChanged: (val) => setState(() => _showRiskMap = val),
                  activeThumbColor: AppTheme.gold,
                  activeTrackColor: AppTheme.gold.withValues(alpha: 0.3),
                ),
                const Text('Risk Map', style: TextStyle(color: AppTheme.gold, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 100,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final prov = provinces[group.x.toInt()];
                      return BarTooltipItem(
                        '${prov.key}\n${rod.toY.toStringAsFixed(1)}%',
                        const TextStyle(color: AppTheme.white, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final prov = provinces[value.toInt()];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(prov.key.substring(0, 3),
                          style: const TextStyle(fontSize: 10, color: AppTheme.white60)),
                      );
                    },
                  )),
                  leftTitles: AxisTitles(sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) => Text('${value.toInt()}%',
                      style: const TextStyle(color: AppTheme.white30, fontSize: 10)),
                  )),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: provinces.asMap().entries.map((entry) {
                  final i = entry.key;
                  final prov = entry.value;
                  final passRate = (prov.value['passRate'] as double);
                  final color = passRate < 50
                      ? AppTheme.redBright
                      : (passRate < 60 ? AppTheme.gold : AppTheme.primaryGreen);
                  return BarChartGroupData(x: i, barRods: [
                    BarChartRodData(toY: passRate, color: color, width: 18,
                      borderRadius: BorderRadius.circular(6)),
                  ]);
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (_showRiskMap) _buildProvinceRiskList(),
        ],
      ),
    );
  }

  Widget _buildProvinceRiskList() {
    return Column(
      children: DemoData.provinceMetrics.entries.map((entry) {
        final risk = entry.value['risk'] as String;
        final color = risk == 'high'
            ? AppTheme.redBright
            : (risk == 'medium' ? AppTheme.gold : AppTheme.primaryGreen);
        return ListTile(
          dense: true,
          leading: Icon(Icons.circle, color: color, size: 12),
          title: Text(entry.key, style: const TextStyle(color: AppTheme.white, fontSize: 14)),
          trailing: Text('${entry.value['passRate']}%',
            style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          onTap: () => _showProvinceDetail(entry.key),
        );
      }).toList(),
    );
  }

  void _showProvinceDetail(String provinceName) {
    final data = DemoData.provinceMetrics[provinceName];
    if (data == null) return;
    final provinces = getProvinces();
    final provinceData = provinces.where((p) => p.name == provinceName).firstOrNull;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: ListView(
            controller: controller,
            padding: const EdgeInsets.all(24),
            children: [
              Center(child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(color: AppTheme.white30, borderRadius: BorderRadius.circular(2)),
              )),
              const SizedBox(height: 20),
              Text(provinceName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.white)),
              const SizedBox(height: 4),
              const Text('Province Education Overview',
                style: TextStyle(color: AppTheme.white60, fontSize: 14)),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildProvinceStat('Schools', '${data['schools']}', Icons.school, AppTheme.greenBright),
                  const SizedBox(width: 12),
                  _buildProvinceStat('Students', '${data['students']}', Icons.people, AppTheme.gold),
                  const SizedBox(width: 12),
                  _buildProvinceStat('Pass Rate', '${data['passRate']}%', Icons.trending_up,
                    (data['passRate'] as double) >= 70 ? AppTheme.greenBright : AppTheme.redBright),
                ],
              ),
              const SizedBox(height: 20),
              if (provinceData != null) ...[
                const Text('Districts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
                const SizedBox(height: 12),
                ...provinceData.districts.map((d) => GlassCard(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(d.name, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.white)),
                      const SizedBox(height: 8),
                      Text('${d.schools.length} schools · Population: ${d.population}',
                        style: const TextStyle(color: AppTheme.white60, fontSize: 13)),
                      if (d.schools.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        ...d.schools.map((s) => Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              Icon(s.type == 'primary' ? Icons.school : Icons.science,
                                size: 14, color: AppTheme.white50),
                              const SizedBox(width: 6),
                              Expanded(child: Text(s.name,
                                style: const TextStyle(color: AppTheme.white70, fontSize: 12))),
                              Text('${s.passRate.toStringAsFixed(0)}%',
                                style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold,
                                  color: s.passRate >= 70 ? AppTheme.greenBright : AppTheme.gold,
                                )),
                            ],
                          ),
                        )),
                      ],
                    ],
                  ),
                )),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProvinceStat(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: GlassCard(
        padding: const EdgeInsets.all(12),
        borderColor: color.withValues(alpha: 0.3),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 6),
            Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
            Text(label, style: const TextStyle(color: AppTheme.white60, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _buildRiskAlerts() {
    final risky = DemoData.provinceMetrics.entries.where((e) => e.value['risk'] == 'high').toList();
    if (risky.isEmpty) {
      return const GlassCard(
        padding: EdgeInsets.all(20),
        child: Center(child: Text('No critical alerts',
          style: TextStyle(color: AppTheme.white70))),
      );
    }
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: risky.map((prov) => ListTile(
          leading: const Icon(Icons.warning_amber, color: AppTheme.redBright),
          title: Text(prov.key,
            style: const TextStyle(color: AppTheme.white, fontWeight: FontWeight.w600)),
          subtitle: Text('Pass rate ${prov.value['passRate']}% · Needs immediate intervention',
            style: const TextStyle(color: AppTheme.white50)),
        )).toList(),
      ),
    );
  }

  Widget _buildNds1Progress() {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: DemoData.nds1Indicators.map((ind) {
          final current = (ind['current'] as double);
          final target = (ind['target'] as double);
          final progress = (current / target).clamp(0.0, 1.0);
          final color = progress >= 0.9
              ? AppTheme.primaryGreen
              : (progress >= 0.5 ? AppTheme.gold : AppTheme.redBright);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ind['name'] as String,
                  style: const TextStyle(color: AppTheme.white, fontSize: 13)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: AppTheme.white10,
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                          minHeight: 10,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text('${current.toStringAsFixed(1)}% → ${target.toStringAsFixed(0)}%',
                      style: const TextStyle(color: AppTheme.white50, fontSize: 11)),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.gold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: const Border(left: BorderSide(color: AppTheme.gold, width: 4)),
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon, color: AppTheme.gold, size: 24),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.gold, letterSpacing: 1)),
        ],
      ),
    );
  }
}
