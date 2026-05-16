class StudentProgress {
  final String studentId;
  final String subjectId;
  final String subjectName;
  final List<TopicProgress> topics;
  final int quizzesTaken;
  final int homeworksSubmitted;
  final int homeworksReviewed;
  final double averageScore;

  StudentProgress({
    required this.studentId,
    required this.subjectId,
    required this.subjectName,
    required this.topics,
    required this.quizzesTaken,
    required this.homeworksSubmitted,
    required this.homeworksReviewed,
    required this.averageScore,
  });

  factory StudentProgress.fromMap(Map<String, dynamic> map, String id) {
    return StudentProgress(
      studentId: map['studentId'] as String? ?? id.split('_').firstOrNull ?? '',
      subjectId: map['subjectId'] as String? ?? id.split('_').lastOrNull ?? '',
      subjectName: map['subjectName'] as String? ?? '',
      topics: (map['topics'] as List<dynamic>?)
              ?.map((t) => TopicProgress.fromMap(t as Map<String, dynamic>))
              .toList() ??
          [],
      quizzesTaken: map['quizzesTaken'] as int? ?? 0,
      homeworksSubmitted: map['homeworksSubmitted'] as int? ?? 0,
      homeworksReviewed: map['homeworksReviewed'] as int? ?? 0,
      averageScore: (map['overallPercentage'] as num? ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'subjectId': subjectId,
      'subjectName': subjectName,
      'topics': topics.map((t) => t.toMap()).toList(),
      'quizzesTaken': quizzesTaken,
      'homeworksSubmitted': homeworksSubmitted,
      'homeworksReviewed': homeworksReviewed,
      'overallPercentage': averageScore,
      'gradeLevel': '',
    };
  }
}

class TopicProgress {
  final String topicName;
  final String status;
  final double score;

  TopicProgress({
    required this.topicName,
    required this.status,
    required this.score,
  });

  factory TopicProgress.fromMap(Map<String, dynamic> map) {
    return TopicProgress(
      topicName: map['topicName'] as String? ?? '',
      status: map['status'] as String? ?? 'not_started',
      score: (map['percentage'] as num? ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'topicName': topicName,
      'status': status,
      'percentage': score,
    };
  }
}

class StudentRecord {
  final String id;
  final String name;
  final String gradeLevel;
  final Map<String, StudentProgress> subjectProgress;

  StudentRecord({
    required this.id,
    required this.name,
    required this.gradeLevel,
    required this.subjectProgress,
  });

  factory StudentRecord.fromMap(Map<String, dynamic> map, String id) {
    return StudentRecord(
      id: id,
      name: map['name'] as String? ?? '',
      gradeLevel: map['gradeLevel'] as String? ?? '',
      subjectProgress: {},
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gradeLevel': gradeLevel,
    };
  }
}
