class SchoolEvent {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime? endDate;
  final String type; // 'term', 'exam', 'meeting', 'holiday', 'sports', 'cultural'
  final String? school;
  final String? province;

  const SchoolEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    this.endDate,
    required this.type,
    this.school,
    this.province,
  });

  factory SchoolEvent.fromMap(Map<String, dynamic> map, String id) {
    return SchoolEvent(
      id: id,
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      startDate: map['startDate'] is DateTime
          ? map['startDate'] as DateTime
          : DateTime.tryParse(map['startDate']?.toString() ?? '') ?? DateTime.now(),
      endDate: map['endDate'] is DateTime
          ? map['endDate'] as DateTime?
          : DateTime.tryParse(map['endDate']?.toString() ?? ''),
      type: map['type'] as String? ?? 'meeting',
      school: map['school'] as String?,
      province: map['province'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'type': type,
      'school': school,
      'province': province,
    };
  }
}
