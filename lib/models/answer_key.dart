class AnswerKey {
  final String id;
  final String subjectId;
  final String topicId;
  final String title;
  final String gradeLevel;
  final List<AnswerKeyEntry> entries;

  AnswerKey({
    required this.id,
    required this.subjectId,
    required this.topicId,
    required this.title,
    required this.gradeLevel,
    required this.entries,
  });

  factory AnswerKey.fromMap(Map<String, dynamic> map, String id) {
    return AnswerKey(
      id: id,
      subjectId: map['subjectId'] as String? ?? '',
      topicId: map['topicId'] as String? ?? '',
      title: map['title'] as String? ?? '',
      gradeLevel: map['gradeLevel'] as String? ?? '',
      entries: (map['answers'] as List<dynamic>?)
              ?.map((e) => AnswerKeyEntry.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subjectId': subjectId,
      'topicId': topicId,
      'title': title,
      'gradeLevel': gradeLevel,
      'answers': entries.map((e) => e.toMap()).toList(),
    };
  }
}

class AnswerKeyEntry {
  final String question;
  final String answer;
  final String explanation;
  final int marks;

  AnswerKeyEntry({
    required this.question,
    required this.answer,
    required this.explanation,
    required this.marks,
  });

  factory AnswerKeyEntry.fromMap(Map<String, dynamic> map) {
    return AnswerKeyEntry(
      question: map['question'] as String? ?? '',
      answer: map['correctAnswer'] as String? ?? map['answer'] as String? ?? '',
      explanation: map['explanation'] as String? ?? '',
      marks: map['maxMarks'] as int? ?? map['marks'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'correctAnswer': answer,
      'explanation': explanation,
      'maxMarks': marks,
    };
  }
}
