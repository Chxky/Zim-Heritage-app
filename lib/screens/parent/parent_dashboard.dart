import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../theme/app_theme.dart';
import '../../models/user.dart';
import '../../widgets/glass_card.dart';

class ParentDashboard extends StatelessWidget {
  final User user;

  const ParentDashboard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceDark,
      appBar: AppBar(
        title: const Text('Parent Portal'),
        backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.2),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome, ${user.name}', style: const TextStyle(color: AppTheme.white, fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Track your child\'s progress in the Heritage-Based Curriculum.', style: TextStyle(color: AppTheme.white60)),
            const SizedBox(height: 24),
            _buildChildSummary(),
            const SizedBox(height: 24),
            const Text('Heritage Studies Progress', style: TextStyle(color: AppTheme.gold, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildProgressChart(),
            const SizedBox(height: 24),
            const Text('VR Tour Engagement (Hours)', style: TextStyle(color: AppTheme.gold, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildEngagementChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildChildSummary() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderColor: AppTheme.gold.withValues(alpha: 0.3),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: AppTheme.gold,
            child: Icon(Icons.person, size: 40, color: AppTheme.black),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tendai (Demo Student)', style: TextStyle(color: AppTheme.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const Text('Grade 7 • Zimbabwe School', style: TextStyle(color: AppTheme.white60)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.greenBright.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('On Track', style: TextStyle(color: AppTheme.greenBright, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressChart() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 200,
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: false),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, m) => Text('${v.toInt()}%', style: const TextStyle(color: AppTheme.white50, fontSize: 10)), reservedSize: 40)),
              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, m) => Text('Term ${v.toInt()}', style: const TextStyle(color: AppTheme.white50, fontSize: 10)), reservedSize: 40)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: const [
                  FlSpot(1, 65),
                  FlSpot(2, 75),
                  FlSpot(3, 85),
                  FlSpot(4, 92),
                ],
                isCurved: true,
                color: AppTheme.gold,
                barWidth: 4,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(
                  show: true,
                  color: AppTheme.gold.withValues(alpha: 0.2),
                ),
              ),
            ],
            minX: 1,
            maxX: 4,
            minY: 0,
            maxY: 100,
          ),
        ),
      ),
    );
  }

  Widget _buildEngagementChart() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 200,
        child: BarChart(
          BarChartData(
            gridData: const FlGridData(show: false),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, m) => Text('${v.toInt()}h', style: const TextStyle(color: AppTheme.white50, fontSize: 10)), reservedSize: 40)),
              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, m) {
                switch(v.toInt()) {
                  case 0: return const Text('Mon', style: TextStyle(color: AppTheme.white50, fontSize: 10));
                  case 1: return const Text('Tue', style: TextStyle(color: AppTheme.white50, fontSize: 10));
                  case 2: return const Text('Wed', style: TextStyle(color: AppTheme.white50, fontSize: 10));
                  case 3: return const Text('Thu', style: TextStyle(color: AppTheme.white50, fontSize: 10));
                  case 4: return const Text('Fri', style: TextStyle(color: AppTheme.white50, fontSize: 10));
                }
                return const Text('');
              }, reservedSize: 40)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: false),
            barGroups: [
              BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 1, color: AppTheme.primaryGreen, width: 16)]),
              BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 2.5, color: AppTheme.primaryGreen, width: 16)]),
              BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 1.5, color: AppTheme.primaryGreen, width: 16)]),
              BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 3, color: AppTheme.primaryGreen, width: 16)]),
              BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 2, color: AppTheme.primaryGreen, width: 16)]),
            ],
            maxY: 4,
          ),
        ),
      ),
    );
  }
}
