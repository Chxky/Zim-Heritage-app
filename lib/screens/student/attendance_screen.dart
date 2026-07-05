import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../services/attendance_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

class AttendanceScreen extends StatefulWidget {
  final User user;
  const AttendanceScreen({super.key, required this.user});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  DateTime _currentMonth = DateTime.now();
  Map<String, int> _summary = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    AttendanceService.seedDemoData();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final summary = await AttendanceService.getAttendanceSummary(widget.user.id);
      if (mounted) setState(() { _summary = summary; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
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
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildSummaryCards(),
                  const SizedBox(height: 16),
                  _buildCalendar(),
                  const SizedBox(height: 16),
                  _buildLegend(),
                ],
              ),
            ),
    );
  }

  Widget _buildSummaryCards() {
    final total = _summary['total'] ?? 0;
    final present = _summary['present'] ?? 0;
    final rate = total > 0 ? ((present / total) * 100).toStringAsFixed(0) : '0';

    return Row(
      children: [
        _buildStatCard('Present', '${_summary['present'] ?? 0}', AppTheme.greenBright, Icons.check_circle),
        const SizedBox(width: 8),
        _buildStatCard('Absent', '${_summary['absent'] ?? 0}', AppTheme.redBright, Icons.cancel),
        const SizedBox(width: 8),
        _buildStatCard('Late', '${_summary['late'] ?? 0}', AppTheme.gold, Icons.access_time),
        const SizedBox(width: 8),
        _buildStatCard('Rate', '$rate%', AppTheme.white, Icons.percent),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, Color color, IconData icon) {
    return Expanded(
      child: GlassCard(
        padding: const EdgeInsets.all(12),
        borderColor: color.withValues(alpha: 0.3),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            Text(label, style: const TextStyle(color: AppTheme.white60, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    final year = _currentMonth.year;
    final month = _currentMonth.month;
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final firstDayWeekday = DateTime(year, month, 1).weekday;

    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: AppTheme.white),
                onPressed: () => setState(() {
                  _currentMonth = DateTime(year, month - 1);
                }),
              ),
              Text(
                '${_getMonthName(month)} $year',
                style: const TextStyle(color: AppTheme.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: AppTheme.white),
                onPressed: () => setState(() {
                  _currentMonth = DateTime(year, month + 1);
                }),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Day headers
          Row(
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((d) =>
              Expanded(child: Center(child: Text(d, style: const TextStyle(color: AppTheme.white60, fontSize: 11))))
            ).toList(),
          ),
          const SizedBox(height: 8),
          // Calendar grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: (firstDayWeekday - 1) + daysInMonth,
            itemBuilder: (ctx, i) {
              if (i < firstDayWeekday - 1) return const SizedBox.shrink();
              final day = i - (firstDayWeekday - 2);
              final dateStr = '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
              final isWeekend = DateTime(year, month, day).weekday >= 6;
              final isToday = DateTime.now().year == year && DateTime.now().month == month && DateTime.now().day == day;

              return FutureBuilder<List>(
                future: AttendanceService.getAttendanceForStudent(widget.user.id, month: '$year-${month.toString().padLeft(2, '0')}'),
                builder: (ctx, snapshot) {
                  final records = snapshot.data ?? [];
                  final record = records.where((r) => r.date == dateStr).firstOrNull;
                  Color? bgColor;
                  Color textColor = AppTheme.white;
                  if (record != null) {
                    switch (record.status) {
                      case 'present': bgColor = AppTheme.greenBright.withValues(alpha: 0.3); break;
                      case 'absent': bgColor = AppTheme.redBright.withValues(alpha: 0.3); break;
                      case 'late': bgColor = AppTheme.gold.withValues(alpha: 0.3); break;
                      case 'excused': bgColor = Colors.blue.withValues(alpha: 0.3); break;
                    }
                  }
                  if (isWeekend) textColor = AppTheme.white30;

                  return Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(8),
                      border: isToday ? Border.all(color: AppTheme.gold, width: 1.5) : null,
                    ),
                    child: Center(
                      child: Text('$day',
                        style: TextStyle(color: textColor, fontSize: 13,
                          fontWeight: isToday ? FontWeight.bold : FontWeight.normal)),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLegendItem(AppTheme.greenBright, 'Present'),
          _buildLegendItem(AppTheme.redBright, 'Absent'),
          _buildLegendItem(AppTheme.gold, 'Late'),
          _buildLegendItem(Colors.blue, 'Excused'),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 12, height: 12,
          decoration: BoxDecoration(color: color.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color.withValues(alpha: 0.5)))),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: AppTheme.white60, fontSize: 11)),
      ],
    );
  }

  String _getMonthName(int month) {
    const months = ['', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'];
    return months[month];
  }
}
