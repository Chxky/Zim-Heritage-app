import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/demo_data.dart';

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
      backgroundColor: const Color(0xFF0B1A10),
      appBar: AppBar(
        title: Text('Ministry Intelligence Dashboard', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF0B1A10), Color(0xFF004D2E)]),
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.download), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
      {'label': 'Students', 'value': '${(totalStudents/1e6).toStringAsFixed(1)}M', 'icon': Icons.people},
      {'label': 'Teachers', 'value': '98,432', 'icon': Icons.person},
      {'label': 'Pass Rate', 'value': '62.3%', 'icon': Icons.trending_up},
    ];

    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.1,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: kpis.map((kpi) => _glassCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(kpi['icon'] as IconData, color: const Color(0xFFFFC72C), size: 28),
            const SizedBox(height: 8),
            Text(kpi['value'] as String, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 4),
            Text(kpi['label'] as String, style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70)),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildProvinceChart() {
    final provinces = DemoData.provinceMetrics.entries.toList();
    return _glassCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Pass Rate %', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
              Switch(
                value: _showRiskMap,
                onChanged: (val) => setState(() => _showRiskMap = val),
                activeThumbColor: const Color(0xFFFFC72C),
              ),
              Text('Risk Map', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 100,
                barTouchData: BarTouchData(enabled: true, touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final prov = provinces[group.x.toInt()];
                    return BarTooltipItem('${prov.key}\n${rod.toY.toStringAsFixed(1)}%', TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
                  },
                )),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final prov = provinces[value.toInt()];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(prov.key.substring(0,3), style: GoogleFonts.poppins(fontSize: 10, color: Colors.white60)),
                      );
                    },
                  )),
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30, getTitlesWidget: (value, meta) => Text('${value.toInt()}%', style: TextStyle(color: Colors.white38, fontSize: 10)))),
                ),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: provinces.asMap().entries.map((entry) {
                  final i = entry.key;
                  final prov = entry.value;
                  final passRate = (prov.value['passRate'] as double);
                  final color = passRate < 50 ? Colors.redAccent : (passRate < 60 ? Colors.orange : const Color(0xFF006B3F));
                  return BarChartGroupData(x: i, barRods: [
                    BarChartRodData(toY: passRate, color: color, width: 18, borderRadius: BorderRadius.circular(6)),
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
        final color = risk == 'high' ? Colors.redAccent : (risk == 'medium' ? Colors.orange : const Color(0xFF006B3F));
        return ListTile(
          dense: true,
          leading: Icon(Icons.circle, color: color, size: 12),
          title: Text(entry.key, style: GoogleFonts.poppins(color: Colors.white, fontSize: 14)),
          trailing: Text('${entry.value['passRate']}%', style: GoogleFonts.poppins(color: color, fontWeight: FontWeight.bold)),
        );
      }).toList(),
    );
  }

  Widget _buildRiskAlerts() {
    final risky = DemoData.provinceMetrics.entries.where((e) => e.value['risk'] == 'high').toList();
    if (risky.isEmpty) {
      return _glassCard(child: Center(child: Text('No critical alerts', style: GoogleFonts.poppins(color: Colors.white70))));
    }
    return _glassCard(
      child: Column(
        children: risky.map((prov) => ListTile(
          leading: const Icon(Icons.warning_amber, color: Colors.redAccent),
          title: Text(prov.key, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
          subtitle: Text('Pass rate ${prov.value['passRate']}% · Needs immediate intervention', style: GoogleFonts.poppins(color: Colors.white54)),
        )).toList(),
      ),
    );
  }

  Widget _buildNds1Progress() {
    return _glassCard(
      child: Column(
        children: DemoData.nds1Indicators.map((ind) {
          final current = (ind['current'] as double);
          final target = (ind['target'] as double);
          final progress = (current / target).clamp(0.0, 1.0);
          final color = progress >= 0.9 ? const Color(0xFF006B3F) : (progress >= 0.5 ? const Color(0xFFFFC72C) : Colors.redAccent);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ind['name'] as String, style: GoogleFonts.poppins(color: Colors.white, fontSize: 13)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.white12,
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                          minHeight: 10,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text('${current.toStringAsFixed(1)}% → ${target.toStringAsFixed(0)}%', style: GoogleFonts.poppins(color: Colors.white54, fontSize: 11)),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _glassCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(color: const Color(0xFFFFC72C).withValues(alpha: 0.1), blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: child,
    );
  }

  Widget _buildSectionTitle(String title, {IconData? icon}) {
    return Row(
      children: [
        if (icon != null) Icon(icon, color: const Color(0xFFFFC72C), size: 24),
        const SizedBox(width: 8),
        Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: const Color(0xFFFFC72C))),
      ],
    );
  }
}
