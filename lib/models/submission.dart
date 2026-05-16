class HomeworkSubmission {
  final String id;
  final String homeworkId;
  final String studentId;
  final String studentName;
  final DateTime submittedAt;
  final List<Answer> answers;
  String status;
  int? marksObtained;
  int? totalMarks;
  String? feedback;
  DateTime? markedAt;
  String? reviewedBy;

  HomeworkSubmission({
    required this.id,
    required this.homeworkId,
    required this.studentId,
    required this.studentName,
    required this.submittedAt,
    required this.answers,
    this.status = 'submitted',
    this.marksObtained,
    this.totalMarks,
    this.feedback,
    this.markedAt,
    this.reviewedBy,
  });

  factory HomeworkSubmission.fromMap(Map<String, dynamic> map, String id) {
    return HomeworkSubmission(
      id: id,
      homeworkId: map['homeworkId'] as String? ?? '',
      studentId: map['studentId'] as String? ?? '',
      studentName: map['studentName'] as String? ?? '',
      submittedAt: (map['submittedAt'] as dynamic)?.toDate() ?? DateTime.now(),
      answers: (map['answers'] as List<dynamic>?)
              ?.map((a) => Answer.fromMap(a as Map<String, dynamic>))
              .toList() ??
          [],
      status: map['status'] as String? ?? 'submitted',
      marksObtained: map['marksObtained'] as int?,
      totalMarks: map['totalMarks'] as int?,
      feedback: map['feedback'] as String?,
      markedAt: (map['markedAt'] as dynamic)?.toDate(),
      reviewedBy: map['reviewedBy'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'homeworkId': homeworkId,
      'studentId': studentId,
      'studentName': studentName,
      'submittedAt': submittedAt,
      'answers': answers.map((a) => a.toMap()).toList(),
      'status': status,
      'marksObtained': marksObtained,
      'totalMarks': totalMarks,
      'feedback': feedback,
      'markedAt': markedAt,
      'reviewedBy': reviewedBy,
    };
  }

  int? get score => marksObtained;
}

class Answer {
  final String questionId;
  final String answerText;
  final bool? isCorrect;
  final List<String>? fileAttachments;
  final int marksAwarded;

  Answer({
    required this.questionId,
    required this.answerText,
    this.isCorrect,
    this.fileAttachments,
    this.marksAwarded = 0,
  });

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      questionId: map['questionId'] as String? ?? '',
      answerText: map['answerText'] as String? ?? map['answer'] as String? ?? '',
      isCorrect: map['isCorrect'] as bool?,
      fileAttachments: (map['fileAttachments'] as List<dynamic>?)?.cast<String>(),
      marksAwarded: map['marksAwarded'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionId': questionId,
      'answerText': answerText,
      'isCorrect': isCorrect,
      'fileAttachments': fileAttachments,
      'marksAwarded': marksAwarded,
    };
  }

  String get answer => answerText;
}
