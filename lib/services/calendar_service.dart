import 'dart:ui';
import '../models/school_event.dart';

class CalendarService {
  static final List<SchoolEvent> _events = [];

  static Future<List<SchoolEvent>> getEvents({String? school, String? province}) async {
    var events = List<SchoolEvent>.from(_events);
    if (school != null) {
      events = events.where((e) => e.school == null || e.school == school).toList();
    }
    events.sort((a, b) => a.startDate.compareTo(b.startDate));
    return events;
  }

  static Future<List<SchoolEvent>> getEventsForDate(DateTime date) async {
    final dateStr = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return _events.where((e) {
      final startStr = '${e.startDate.year}-${e.startDate.month.toString().padLeft(2, '0')}-${e.startDate.day.toString().padLeft(2, '0')}';
      if (startStr == dateStr) return true;
      if (e.endDate != null) {
        final endStr = '${e.endDate!.year}-${e.endDate!.month.toString().padLeft(2, '0')}-${e.endDate!.day.toString().padLeft(2, '0')}';
        return dateStr.compareTo(startStr) >= 0 && dateStr.compareTo(endStr) <= 0;
      }
      return false;
    }).toList();
  }

  static Future<List<SchoolEvent>> getUpcomingEvents({int limit = 5}) async {
    final now = DateTime.now();
    final upcoming = _events.where((e) => e.startDate.isAfter(now) || _isSameDay(e.startDate, now)).toList();
    upcoming.sort((a, b) => a.startDate.compareTo(b.startDate));
    return upcoming.take(limit).toList();
  }

  static bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static Future<void> addEvent(SchoolEvent event) async {
    _events.add(event);
  }

  static Color getEventColor(String type) {
    switch (type) {
      case 'term': return const Color(0xFF00A85A);
      case 'exam': return const Color(0xFFFFC72C);
      case 'meeting': return const Color(0xFF5C6BC0);
      case 'holiday': return const Color(0xFFCC0000);
      case 'sports': return const Color(0xFF00BCD4);
      case 'cultural': return const Color(0xFF9C27B0);
      default: return const Color(0xFFFFFFFF);
    }
  }

  static void seedDemoData() {
    if (_events.isNotEmpty) return;
    final now = DateTime.now();
    final year = now.year;

    _events.addAll([
      SchoolEvent(
        id: 'term1_start', title: 'Term 1 Begins',
        description: 'First term of $year academic year begins for all schools.',
        startDate: DateTime(year, 1, 13), endDate: DateTime(year, 1, 13),
        type: 'term',
      ),
      SchoolEvent(
        id: 'term1_end', title: 'Term 1 Ends',
        description: 'Last day of Term 1. Schools close for April holiday.',
        startDate: DateTime(year, 4, 10), endDate: DateTime(year, 4, 10),
        type: 'term',
      ),
      SchoolEvent(
        id: 'term2_start', title: 'Term 2 Begins',
        description: 'Second term begins after April holiday.',
        startDate: DateTime(year, 5, 6), endDate: DateTime(year, 5, 6),
        type: 'term',
      ),
      SchoolEvent(
        id: 'term2_end', title: 'Term 2 Ends',
        description: 'Last day of Term 2. Schools close for August holiday.',
        startDate: DateTime(year, 8, 7), endDate: DateTime(year, 8, 7),
        type: 'term',
      ),
      SchoolEvent(
        id: 'term3_start', title: 'Term 3 Begins',
        description: 'Third and final term of the academic year.',
        startDate: DateTime(year, 9, 8), endDate: DateTime(year, 9, 8),
        type: 'term',
      ),
      SchoolEvent(
        id: 'term3_end', title: 'Term 3 Ends / Year End',
        description: 'Academic year ends. Schools close for December holiday.',
        startDate: DateTime(year, 12, 4), endDate: DateTime(year, 12, 4),
        type: 'term',
      ),
      SchoolEvent(
        id: 'zimsec_olevel', title: 'ZIMSEC O-Level Exams Begin',
        description: 'Ordinary Level examinations commence nationwide.',
        startDate: DateTime(year, 10, 15), endDate: DateTime(year, 11, 15),
        type: 'exam',
      ),
      SchoolEvent(
        id: 'zimsec_alevel', title: 'ZIMSEC A-Level Exams Begin',
        description: 'Advanced Level examinations commence nationwide.',
        startDate: DateTime(year, 10, 1), endDate: DateTime(year, 11, 15),
        type: 'exam',
      ),
      SchoolEvent(
        id: 'zimsec_g7', title: 'Grade 7 Examinations',
        description: 'Grade 7 ZIMSEC examinations.',
        startDate: DateTime(year, 10, 20), endDate: DateTime(year, 10, 24),
        type: 'exam',
      ),
      // Cambridge International Exams
      SchoolEvent(
        id: 'cambridge_igcse', title: 'Cambridge IGCSE Exams Begin',
        description: 'Cambridge IGCSE examinations commence. Main session for Zimbabwe schools.',
        startDate: DateTime(year, 10, 1), endDate: DateTime(year, 11, 15),
        type: 'exam',
      ),
      SchoolEvent(
        id: 'cambridge_as', title: 'Cambridge AS Level Exams Begin',
        description: 'Cambridge AS Level examinations commence.',
        startDate: DateTime(year, 10, 1), endDate: DateTime(year, 11, 15),
        type: 'exam',
      ),
      SchoolEvent(
        id: 'cambridge_alevel', title: 'Cambridge A-Level Exams Begin',
        description: 'Cambridge A-Level examinations commence.',
        startDate: DateTime(year, 10, 1), endDate: DateTime(year, 11, 15),
        type: 'exam',
      ),
      SchoolEvent(
        id: 'cambridge_checkpoint_primary', title: 'Cambridge Primary Checkpoint',
        description: 'Cambridge Primary Checkpoint examinations for Grade 6 students.',
        startDate: DateTime(year, 10, 14), endDate: DateTime(year, 10, 18),
        type: 'exam',
      ),
      SchoolEvent(
        id: 'cambridge_checkpoint_lower', title: 'Cambridge Lower Secondary Checkpoint',
        description: 'Cambridge Lower Secondary Checkpoint examinations for Form 2 students.',
        startDate: DateTime(year, 10, 14), endDate: DateTime(year, 10, 18),
        type: 'exam',
      ),
      SchoolEvent(
        id: 'cambridge_results', title: 'Cambridge Results Release',
        description: 'Cambridge IGCSE, AS & A Level results released.',
        startDate: DateTime(year, 1, 10), endDate: DateTime(year, 1, 10),
        type: 'exam',
      ),
      SchoolEvent(
        id: 'sports_day', title: 'National Sports Day',
        description: 'Inter-school sports competitions across all provinces.',
        startDate: DateTime(year, 6, 14), endDate: DateTime(year, 6, 14),
        type: 'sports',
      ),
      SchoolEvent(
        id: 'heritage_day', title: 'Heritage Day Celebrations',
        description: 'Cultural heritage celebrations. Traditional dances, poetry, and exhibitions.',
        startDate: DateTime(year, 5, 25), endDate: DateTime(year, 5, 25),
        type: 'cultural',
      ),
      SchoolEvent(
        id: 'teachers_day', title: 'Teachers Day',
        description: 'Celebrating teachers across Zimbabwe.',
        startDate: DateTime(year, 10, 5), endDate: DateTime(year, 10, 5),
        type: 'cultural',
      ),
      SchoolEvent(
        id: 'parent_meeting', title: 'Parent-Teacher Conference',
        description: 'Term 2 progress review meeting with parents.',
        startDate: DateTime(year, 6, 28), endDate: DateTime(year, 6, 28),
        type: 'meeting',
      ),
      SchoolEvent(
        id: 'independence', title: 'Independence Day',
        description: 'Zimbabwe Independence Day - Public Holiday.',
        startDate: DateTime(year, 4, 18), endDate: DateTime(year, 4, 18),
        type: 'holiday',
      ),
      SchoolEvent(
        id: 'heroes_day', title: 'Heroes Day',
        description: 'Zimbabwe Heroes Day - Public Holiday.',
        startDate: DateTime(year, 8, 11), endDate: DateTime(year, 8, 11),
        type: 'holiday',
      ),
      SchoolEvent(
        id: 'unity_day', title: 'Unity Day',
        description: 'Zimbabwe Unity Day - Public Holiday.',
        startDate: DateTime(year, 12, 22), endDate: DateTime(year, 12, 22),
        type: 'holiday',
      ),
    ]);
  }
}
