class Subject {
  final String id;
  final String name;
  final String description;
  final String gradeLevel;
  final String color;
  final String icon;

  Subject({
    required this.id,
    required this.name,
    required this.description,
    required this.gradeLevel,
    required this.color,
    required this.icon,
  });

  factory Subject.fromMap(Map<String, dynamic> map, String id) {
    return Subject(
      id: id,
      name: map['name'] as String? ?? '',
      description: map['description'] as String? ?? '',
      gradeLevel: map['gradeLevel'] as String? ?? '',
      color: map['color'] as String? ?? '0xFF4CAF50',
      icon: map['icon'] as String? ?? 'book',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'gradeLevel': gradeLevel,
      'color': color,
      'icon': icon,
    };
  }
}

class Topic {
  final String id;
  final String subjectId;
  final String name;
  final String description;
  final List<String> subtopics;
  final String gradeLevel;
  final String term;

  Topic({
    required this.id,
    required this.subjectId,
    required this.name,
    required this.description,
    required this.subtopics,
    required this.gradeLevel,
    required this.term,
  });

  factory Topic.fromMap(Map<String, dynamic> map, String id) {
    return Topic(
      id: id,
      subjectId: map['subjectId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      description: map['description'] as String? ?? '',
      subtopics: List<String>.from(map['subtopics'] as List? ?? []),
      gradeLevel: map['gradeLevel'] as String? ?? '',
      term: map['term'] as String? ?? 'Term 1',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subjectId': subjectId,
      'name': name,
      'description': description,
      'subtopics': subtopics,
      'gradeLevel': gradeLevel,
      'term': term,
    };
  }
}
