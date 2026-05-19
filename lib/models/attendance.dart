class AttendanceRecord {
  final String id;
  final String studentId;
  final String date; // YYYY-MM-DD
  final String status; // 'present', 'absent', 'late', 'excused'
  final String? recordedBy;
  final DateTime timestamp;

  const AttendanceRecord({
    required this.id,
    required this.studentId,
    required this.date,
    required this.status,
    this.recordedBy,
    required this.timestamp,
  });

  factory AttendanceRecord.fromMap(Map<String, dynamic> map, String id) {
    return AttendanceRecord(
      id: id,
      studentId: map['studentId'] as String? ?? '',
      date: map['date'] as String? ?? '',
      status: map['status'] as String? ?? 'absent',
      recordedBy: map['recordedBy'] as String?,
      timestamp: map['timestamp'] is DateTime
          ? map['timestamp'] as DateTime
          : DateTime.tryParse(map['timestamp']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'date': date,
      'status': status,
      'recordedBy': recordedBy,
      'timestamp': timestamp,
    };
  }
}
