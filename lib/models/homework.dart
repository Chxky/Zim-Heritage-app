class Homework {
  final String id;
  final String subjectId;
  final String title;
  final String description;
  final String gradeLevel;
  final DateTime dueDate;
  final List<HomeworkQuestion> questions;
  final List<String> attachments;
  final String status;
  final String teacherId;

  Homework({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.description,
    required this.gradeLevel,
    required this.dueDate,
    required this.questions,
    this.attachments = const [],
    this.status = 'active',
    required this.teacherId,
  });

  factory Homework.fromMap(Map<String, dynamic> map, String id) {
    return Homework(
      id: id,
      subjectId: map['subjectId'] as String? ?? '',
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      gradeLevel: map['gradeLevel'] as String? ?? '',
      dueDate: (map['dueDate'] as dynamic)?.toDate() ?? DateTime.now(),
      questions: (map['questions'] as List<dynamic>?)
              ?.map((q) => HomeworkQuestion.fromMap(q as Map<String, dynamic>))
              .toList() ??
          [],
      attachments: List<String>.from(map['attachments'] as List? ?? []),
      status: map['status'] as String? ?? 'active',
      teacherId: map['createdBy'] as String? ?? map['teacherId'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subjectId': subjectId,
      'title': title,
      'description': description,
      'gradeLevel': gradeLevel,
      'dueDate': dueDate,
      'questions': questions.map((q) => q.toMap()).toList(),
      'attachments': attachments,
      'status': status,
      'createdBy': teacherId,
    };
  }
}

class HomeworkQuestion {
  final String id;
  final String question;
  final String type;
  final List<String>? options;
  final String? correctAnswer;
  final int marks;

  HomeworkQuestion({
    required this.id,
    required this.question,
    required this.type,
    this.options,
    this.correctAnswer,
    required this.marks,
  });

  factory HomeworkQuestion.fromMap(Map<String, dynamic> map) {
    return HomeworkQuestion(
      id: map['questionId'] as String? ?? map['id'] as String? ?? '',
      question: map['text'] as String? ?? map['question'] as String? ?? '',
      type: map['type'] as String? ?? 'short_answer',
      options: (map['options'] as List<dynamic>?)?.cast<String>(),
      correctAnswer: map['correctAnswer'] as String?,
      marks: map['marks'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionId': id,
      'text': question,
      'type': type,
      'options': options,
      'correctAnswer': correctAnswer,
      'marks': marks,
    };
  }
}
