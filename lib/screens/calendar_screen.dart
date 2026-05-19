import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/school_event.dart';
import '../services/calendar_service.dart';
import '../widgets/glass_card.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _currentMonth = DateTime.now();
  DateTime? _selectedDate;
  List<SchoolEvent> _events = [];
  List<SchoolEvent> _selectedDateEvents = [];

  @override
  void initState() {
    super.initState();
    CalendarService.seedDemoData();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final events = await CalendarService.getEvents();
    if (mounted) setState(() => _events = events);
  }

  Future<void> _selectDate(DateTime date) async {
    final events = await CalendarService.getEventsForDate(date);
    if (mounted) {
      setState(() {
        _selectedDate = date;
        _selectedDateEvents = events;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('School Calendar'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildCalendar(),
            const SizedBox(height: 16),
            if (_selectedDate != null) _buildSelectedDateEvents(),
            const SizedBox(height: 16),
            _buildUpcomingEvents(),
            const SizedBox(height: 16),
            _buildEventLegend(),
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
                onPressed: () => setState(() => _currentMonth = DateTime(year, month - 1)),
              ),
              Text('${_getMonthName(month)} $year',
                style: const TextStyle(color: AppTheme.white, fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: AppTheme.white),
                onPressed: () => setState(() => _currentMonth = DateTime(year, month + 1)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((d) =>
              Expanded(child: Center(child: Text(d,
                style: const TextStyle(color: AppTheme.white60, fontSize: 11))))
            ).toList(),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7, childAspectRatio: 1,
            ),
            itemCount: (firstDayWeekday - 1) + daysInMonth,
            itemBuilder: (ctx, i) {
              if (i < firstDayWeekday - 1) return const SizedBox.shrink();
              final day = i - (firstDayWeekday - 2);
              final date = DateTime(year, month, day);
              final hasEvent = _events.any((e) => _isDateInRange(date, e));
              final isSelected = _selectedDate != null && _isSameDay(date, _selectedDate!);
              final isToday = _isSameDay(date, DateTime.now());
              final isWeekend = date.weekday >= 6;

              return GestureDetector(
                onTap: () => _selectDate(date),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.gold.withValues(alpha: 0.2) : null,
                    borderRadius: BorderRadius.circular(8),
                    border: isToday ? Border.all(color: AppTheme.gold, width: 1.5) : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('$day',
                        style: TextStyle(
                          color: isWeekend ? AppTheme.white30 : (isSelected ? AppTheme.gold : AppTheme.white),
                          fontWeight: (isToday || isSelected) ? FontWeight.bold : FontWeight.normal,
                          fontSize: 13,
                        )),
                      if (hasEvent)
                        Container(
                          width: 6, height: 6,
                          decoration: BoxDecoration(
                            color: _getEventColorForDate(date),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedDateEvents() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderColor: AppTheme.gold.withValues(alpha: 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_selectedDate!.day} ${_getMonthName(_selectedDate!.month)} ${_selectedDate!.year}',
            style: const TextStyle(color: AppTheme.gold, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (_selectedDateEvents.isEmpty)
            const Text('No events on this day', style: TextStyle(color: AppTheme.white60))
          else
            ..._selectedDateEvents.map((e) => _buildEventTile(e)),
        ],
      ),
    );
  }

  Widget _buildUpcomingEvents() {
    return FutureBuilder<List<SchoolEvent>>(
      future: CalendarService.getUpcomingEvents(limit: 5),
      builder: (ctx, snapshot) {
        final events = snapshot.data ?? [];
        return GlassCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Upcoming Events',
                style: TextStyle(color: AppTheme.gold, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              if (events.isEmpty)
                const Text('No upcoming events', style: TextStyle(color: AppTheme.white60))
              else
                ...events.map((e) => _buildEventTile(e)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEventTile(SchoolEvent event) {
    final color = CalendarService.getEventColor(event.type);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 4, height: 40,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.title,
                  style: const TextStyle(color: AppTheme.white, fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 2),
                Text(event.description,
                  style: const TextStyle(color: AppTheme.white60, fontSize: 12),
                  maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(event.type.toUpperCase(),
              style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildEventLegend() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Event Types',
            style: TextStyle(color: AppTheme.white60, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _buildLegendChip('Term', CalendarService.getEventColor('term')),
              _buildLegendChip('Exam', CalendarService.getEventColor('exam')),
              _buildLegendChip('Meeting', CalendarService.getEventColor('meeting')),
              _buildLegendChip('Holiday', CalendarService.getEventColor('holiday')),
              _buildLegendChip('Sports', CalendarService.getEventColor('sports')),
              _buildLegendChip('Cultural', CalendarService.getEventColor('cultural')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendChip(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: AppTheme.white60, fontSize: 11)),
      ],
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isDateInRange(DateTime date, SchoolEvent event) {
    if (_isSameDay(date, event.startDate)) return true;
    if (event.endDate != null) {
      return date.isAfter(event.startDate) && date.isBefore(event.endDate!.add(const Duration(days: 1)));
    }
    return false;
  }

  Color _getEventColorForDate(DateTime date) {
    for (final event in _events) {
      if (_isDateInRange(date, event)) return CalendarService.getEventColor(event.type);
    }
    return AppTheme.white30;
  }

  String _getMonthName(int month) {
    const months = ['', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'];
    return months[month];
  }
}
