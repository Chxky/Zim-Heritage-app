import '../models/attendance.dart';

class AttendanceService {
  static final List<AttendanceRecord> _records = [];

  static Future<void> markAttendance(String studentId, String status, String date, {String? recordedBy}) async {
    final existing = _records.indexWhere((r) => r.studentId == studentId && r.date == date);
    final record = AttendanceRecord(
      id: '${studentId}_$date',
      studentId: studentId,
      date: date,
      status: status,
      recordedBy: recordedBy,
      timestamp: DateTime.now(),
    );
    if (existing >= 0) {
      _records[existing] = record;
    } else {
      _records.add(record);
    }
  }

  static Future<List<AttendanceRecord>> getAttendanceForStudent(String studentId, {String? month}) async {
    var records = _records.where((r) => r.studentId == studentId).toList();
    if (month != null) {
      records = records.where((r) => r.date.startsWith(month)).toList();
    }
    records.sort((a, b) => b.date.compareTo(a.date));
    return records;
  }

  static Future<Map<String, int>> getAttendanceSummary(String studentId) async {
    final records = _records.where((r) => r.studentId == studentId).toList();
    return {
      'present': records.where((r) => r.status == 'present').length,
      'absent': records.where((r) => r.status == 'absent').length,
      'late': records.where((r) => r.status == 'late').length,
      'excused': records.where((r) => r.status == 'excused').length,
      'total': records.length,
    };
  }

  static Future<double> getAttendanceRate(String studentId) async {
    final summary = await getAttendanceSummary(studentId);
    final total = summary['total'] ?? 0;
    if (total == 0) return 0;
    final present = summary['present'] ?? 0;
    final late_ = summary['late'] ?? 0;
    return ((present + late_) / total) * 100;
  }

  static Future<List<AttendanceRecord>> getAttendanceForDate(String date) async {
    return _records.where((r) => r.date == date).toList();
  }

  static Future<List<String>> getStudentsForDate(String date) async {
    return _records.where((r) => r.date == date).map((r) => r.studentId).toList();
  }

  static Future<void> bulkMarkAttendance(List<String> studentIds, String status, String date, {String? recordedBy}) async {
    for (final id in studentIds) {
      await markAttendance(id, status, date, recordedBy: recordedBy);
    }
  }

  static void seedDemoData() {
    if (_records.isNotEmpty) return;
    final now = DateTime.now();
    final students = ['student_1', 'student_2', 'student_3', 'student_4', 'student_5'];
    for (int i = 30; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) continue;
      final dateStr = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      for (final student in students) {
        final rand = (student.hashCode + i) % 10;
        final status = rand < 7 ? 'present' : (rand < 9 ? 'late' : 'absent');
        _records.add(AttendanceRecord(
          id: '${student}_$dateStr',
          studentId: student,
          date: dateStr,
          status: status,
          recordedBy: 'teacher_1',
          timestamp: date,
        ));
      }
    }
  }
}
