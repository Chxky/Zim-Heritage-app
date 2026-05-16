class Lesson {
  final String id;
  final String subjectId;
  final String topicId;
  final String title;
  final String gradeLevel;
  final List<String> objectives;
  final List<LessonSection> sections;
  final List<String> keyPoints;
  final List<PracticeQuestion> practiceQuestions;
  final List<String> references;
  final List<String> imageAssets;

  Lesson({
    required this.id,
    required this.subjectId,
    required this.topicId,
    required this.title,
    required this.gradeLevel,
    required this.objectives,
    required this.sections,
    required this.keyPoints,
    required this.practiceQuestions,
    required this.references,
    this.imageAssets = const [],
  });
}

class LessonSection {
  final String heading;
  final String content;
  final List<String> bulletPoints;
  final List<String>? imageHints;
  final String? example;

  LessonSection({
    required this.heading,
    required this.content,
    this.bulletPoints = const [],
    this.imageHints,
    this.example,
  });
}

class PracticeQuestion {
  final String question;
  final String answer;
  final String explanation;

  PracticeQuestion({
    required this.question,
    required this.answer,
    required this.explanation,
  });
}

class PastExamQuestion {
  final String id;
  final String subjectId;
  final String gradeLevel;
  final String year;
  final String term;
  final String paper;
  final String question;
  final int marks;
  final String? answer;
  final String? explanation;
  final String topic;

  PastExamQuestion({
    required this.id,
    required this.subjectId,
    required this.gradeLevel,
    required this.year,
    required this.term,
    required this.paper,
    required this.question,
    required this.marks,
    this.answer,
    this.explanation,
    required this.topic,
  });
}
