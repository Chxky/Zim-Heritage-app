import '../models/homework.dart';
import '../models/submission.dart';
import '../models/progress.dart';

class SampleData {
  static final List<Homework> homeworkAssignments = [
    Homework(
      id: 'hw_1',
      subjectId: 'g3_mat',
      title: 'Multiplication Practice',
      description: 'Complete the multiplication problems below. Show all your working.',
      gradeLevel: 'Grade 3',
      dueDate: DateTime.now().add(const Duration(days: 7)),
      questions: [
        HomeworkQuestion(id: 'q1', question: 'What is 6 × 7? Show your working.', type: 'short_answer', marks: 2),
        HomeworkQuestion(id: 'q2', question: 'If there are 4 rows of 5 chairs, how many chairs are there in total?', type: 'short_answer', marks: 3),
        HomeworkQuestion(id: 'q3', question: 'What is 9 × 8?', type: 'short_answer', marks: 1),
        HomeworkQuestion(id: 'q4', question: 'A farmer has 3 fields. Each field has 12 cows. How many cows does he have in total?', type: 'short_answer', marks: 3),
        HomeworkQuestion(id: 'q5', question: 'Complete this multiplication table: 2, 4, 6, __, 10, __, 14', type: 'short_answer', marks: 2),
      ],
      teacherId: 'teacher_1',
    ),
    Homework(
      id: 'hw_2',
      subjectId: 'g3_eng',
      title: 'Parts of Speech Exercise',
      description: 'Identify the parts of speech in each sentence. Write N for noun, V for verb, ADJ for adjective.',
      gradeLevel: 'Grade 3',
      dueDate: DateTime.now().add(const Duration(days: 5)),
      questions: [
        HomeworkQuestion(id: 'q1', question: '"The happy dog ran fast." - Identify the adjective.', type: 'short_answer', marks: 1),
        HomeworkQuestion(id: 'q2', question: '"She sings beautifully." - Identify the verb.', type: 'short_answer', marks: 1),
        HomeworkQuestion(id: 'q3', question: '"The big elephant walked slowly." - Write all the nouns.', type: 'short_answer', marks: 2),
        HomeworkQuestion(id: 'q4', question: 'Write one sentence that contains at least one noun, one verb, and one adjective.', type: 'short_answer', marks: 3),
      ],
      teacherId: 'teacher_1',
    ),
    Homework(
      id: 'hw_3',
      subjectId: 'g5_sci',
      title: 'States of Matter Investigation',
      description: 'Answer the following questions about solids, liquids, and gases. Give examples from your daily life.',
      gradeLevel: 'Grade 5',
      dueDate: DateTime.now().add(const Duration(days: 10)),
      questions: [
        HomeworkQuestion(id: 'q1', question: 'List three examples of solids you use at school.', type: 'short_answer', marks: 2),
        HomeworkQuestion(id: 'q2', question: 'What happens to water when you put it in the freezer?', type: 'short_answer', marks: 2),
        HomeworkQuestion(id: 'q3', question: 'Why can you smell food cooking from another room?', type: 'short_answer', marks: 3),
        HomeworkQuestion(id: 'q4', question: 'Draw and label the water cycle. (Describe in words)', type: 'short_answer', marks: 3),
      ],
      teacherId: 'teacher_1',
    ),
    Homework(
      id: 'hw_4',
      subjectId: 'g7_mat',
      title: 'Algebra Revision',
      description: 'Solve the following algebraic equations. Show all steps clearly.',
      gradeLevel: 'Grade 7',
      dueDate: DateTime.now().add(const Duration(days: 3)),
      questions: [
        HomeworkQuestion(id: 'q1', question: 'Solve: 3x + 7 = 22', type: 'short_answer', marks: 3),
        HomeworkQuestion(id: 'q2', question: 'Simplify: 4(2x + 3) - 5x', type: 'short_answer', marks: 3),
        HomeworkQuestion(id: 'q3', question: 'If 5x - 3 = 2x + 9, find the value of x.', type: 'short_answer', marks: 4),
        HomeworkQuestion(id: 'q4', question: 'The sum of two numbers is 20 and their difference is 4. Find the two numbers.', type: 'short_answer', marks: 5),
      ],
      teacherId: 'teacher_1',
    ),
    Homework(
      id: 'hw_5',
      subjectId: 'g1_mat',
      title: 'Counting Fun',
      description: 'Practice your counting skills with these fun exercises.',
      gradeLevel: 'Grade 1',
      dueDate: DateTime.now().add(const Duration(days: 7)),
      questions: [
        HomeworkQuestion(id: 'q1', question: 'Count from 1 to 20 and write all the numbers.', type: 'short_answer', marks: 5),
        HomeworkQuestion(id: 'q2', question: 'What number comes after 14?', type: 'short_answer', marks: 1),
        HomeworkQuestion(id: 'q3', question: 'Draw 7 stars (describe how many you drew)', type: 'short_answer', marks: 2),
      ],
      teacherId: 'teacher_1',
    ),
    Homework(
      id: 'hw_6',
      subjectId: 'g7_hss',
      title: 'Zimbabwean Heritage Essay',
      description: 'Write a short essay about why it is important to preserve Zimbabwean cultural heritage.',
      gradeLevel: 'Grade 7',
      dueDate: DateTime.now().add(const Duration(days: 14)),
      questions: [
        HomeworkQuestion(id: 'q1', question: 'What does "cultural heritage" mean to you?', type: 'short_answer', marks: 3),
        HomeworkQuestion(id: 'q2', question: 'Name three heritage sites in Zimbabwe and explain why they are important.', type: 'short_answer', marks: 5),
        HomeworkQuestion(id: 'q3', question: 'How can young people help preserve Zimbabwean culture? Give at least three suggestions.', type: 'short_answer', marks: 5),
        HomeworkQuestion(id: 'q4', question: 'Do you think it is important to learn about traditional practices? Why or why not?', type: 'short_answer', marks: 4),
      ],
      teacherId: 'teacher_1',
    ),
    Homework(
      id: 'hw_7',
      subjectId: 'o1_mat',
      title: 'Algebra - Linear Equations',
      description: 'Solve the following linear equations. Show all steps clearly.',
      gradeLevel: 'Form 1',
      dueDate: DateTime.now().add(const Duration(days: 7)),
      questions: [
        HomeworkQuestion(id: 'q1', question: 'Solve: 2x + 5 = 13', type: 'short_answer', marks: 3),
        HomeworkQuestion(id: 'q2', question: 'Solve: 3y - 7 = 14', type: 'short_answer', marks: 3),
        HomeworkQuestion(id: 'q3', question: 'Solve: 4(x + 2) = 20', type: 'short_answer', marks: 4),
        HomeworkQuestion(id: 'q4', question: 'If 5a + 3 = 2a + 15, find a.', type: 'short_answer', marks: 4),
        HomeworkQuestion(id: 'q5', question: 'The sum of a number and 8 is 20. Find the number.', type: 'short_answer', marks: 3),
      ],
      teacherId: 'teacher_1',
    ),
    Homework(
      id: 'hw_8',
      subjectId: 'o1_eng',
      title: 'Parts of Speech Revision',
      description: 'Identify parts of speech and practice sentence analysis.',
      gradeLevel: 'Form 1',
      dueDate: DateTime.now().add(const Duration(days: 5)),
      questions: [
        HomeworkQuestion(id: 'q1', question: 'Identify all nouns: "The clever students completed their homework quickly."', type: 'short_answer', marks: 2),
        HomeworkQuestion(id: 'q2', question: 'Identify the verb: "She has been studying for three hours."', type: 'short_answer', marks: 1),
        HomeworkQuestion(id: 'q3', question: 'Write a sentence containing at least one noun, one verb, one adjective, and one adverb.', type: 'short_answer', marks: 4),
        HomeworkQuestion(id: 'q4', question: 'Change to passive voice: "The teacher marked the assignments."', type: 'short_answer', marks: 3),
      ],
      teacherId: 'teacher_1',
    ),
    Homework(
      id: 'hw_9',
      subjectId: 'a5_bio',
      title: 'DNA Structure and Function',
      description: 'Answer the following questions about DNA and protein synthesis for A-Level Biology.',
      gradeLevel: 'Form 5',
      dueDate: DateTime.now().add(const Duration(days: 10)),
      questions: [
        HomeworkQuestion(id: 'q1', question: 'Describe the structure of a DNA nucleotide.', type: 'short_answer', marks: 3),
        HomeworkQuestion(id: 'q2', question: 'Explain the process of DNA replication.', type: 'short_answer', marks: 5),
        HomeworkQuestion(id: 'q3', question: 'What is the role of mRNA in protein synthesis?', type: 'short_answer', marks: 3),
        HomeworkQuestion(id: 'q4', question: 'Compare and contrast DNA and RNA.', type: 'short_answer', marks: 4),
      ],
      teacherId: 'teacher_1',
    ),
    Homework(
      id: 'hw_10',
      subjectId: 'a5_mat',
      title: 'Calculus - Differentiation',
      description: 'Practice differentiation using the power rule, product rule, and chain rule.',
      gradeLevel: 'Form 5',
      dueDate: DateTime.now().add(const Duration(days: 7)),
      questions: [
        HomeworkQuestion(id: 'q1', question: 'Differentiate: f(x) = 3x^4 + 2x^3 - 5x + 7', type: 'short_answer', marks: 4),
        HomeworkQuestion(id: 'q2', question: 'Differentiate: f(x) = x^2(2x + 1)', type: 'short_answer', marks: 4),
        HomeworkQuestion(id: 'q3', question: 'Find the gradient of the curve y = 2x^3 - 4x at x = 2', type: 'short_answer', marks: 4),
        HomeworkQuestion(id: 'q4', question: 'Find the derivative of f(x) = (3x + 2)^5', type: 'short_answer', marks: 5),
      ],
      teacherId: 'teacher_1',
    ),
  ];

  static final List<HomeworkSubmission> sampleSubmissions = [
    HomeworkSubmission(
      id: 'sub_1',
      homeworkId: 'hw_1',
      studentId: 'student_1',
      studentName: 'Tendai Musoni',
      submittedAt: DateTime.now().subtract(const Duration(days: 2)),
      answers: [
        Answer(questionId: 'q1', answerText: '6 × 7 = 42. Working: 6 + 6 + 6 + 6 + 6 + 6 + 6 = 42 OR 6 × 7 = 42'),
        Answer(questionId: 'q2', answerText: '4 × 5 = 20 chairs. There are 20 chairs in total.'),
        Answer(questionId: 'q3', answerText: '9 × 8 = 72'),
        Answer(questionId: 'q4', answerText: '3 × 12 = 36 cows. The farmer has 36 cows.'),
        Answer(questionId: 'q5', answerText: '2, 4, 6, 8, 10, 12, 14'),
      ],
      status: 'reviewed',
      marksObtained: 10,
      feedback: 'Excellent work Tendai! All answers are correct. You showed good working for the word problems.',
      markedAt: DateTime.now().subtract(const Duration(days: 1)),
      reviewedBy: 'Teacher Chigumira',
    ),
    HomeworkSubmission(
      id: 'sub_2',
      homeworkId: 'hw_1',
      studentId: 'student_2',
      studentName: 'Chipo Dube',
      submittedAt: DateTime.now().subtract(const Duration(days: 1)),
      answers: [
        Answer(questionId: 'q1', answerText: '6 × 7 = 42'),
        Answer(questionId: 'q2', answerText: '20 chairs'),
        Answer(questionId: 'q3', answerText: '72'),
        Answer(questionId: 'q4', answerText: '36 cows'),
        Answer(questionId: 'q5', answerText: '8 and 12'),
      ],
      status: 'submitted',
    ),
    HomeworkSubmission(
      id: 'sub_3',
      homeworkId: 'hw_4',
      studentId: 'student_1',
      studentName: 'Tendai Musoni',
      submittedAt: DateTime.now().subtract(const Duration(hours: 12)),
      answers: [
        Answer(questionId: 'q1', answerText: '3x + 7 = 22\n3x = 22 - 7\n3x = 15\nx = 5'),
        Answer(questionId: 'q2', answerText: '4(2x + 3) - 5x = 8x + 12 - 5x = 3x + 12'),
        Answer(questionId: 'q3', answerText: '5x - 3 = 2x + 9\n5x - 2x = 9 + 3\n3x = 12\nx = 4'),
        Answer(questionId: 'q4', answerText: 'Let the numbers be x and y.\nx + y = 20\nx - y = 4\nAdding: 2x = 24, x = 12\ny = 20 - 12 = 8\nThe numbers are 12 and 8.'),
      ],
      status: 'submitted',
    ),
    HomeworkSubmission(
      id: 'sub_4',
      homeworkId: 'hw_2',
      studentId: 'student_2',
      studentName: 'Chipo Dube',
      submittedAt: DateTime.now().subtract(const Duration(days: 3)),
      answers: [
        Answer(questionId: 'q1', answerText: 'ADJ - happy'),
        Answer(questionId: 'q2', answerText: 'V - sings'),
        Answer(questionId: 'q3', answerText: 'Nouns: elephant'),
        Answer(questionId: 'q4', answerText: 'The big dog runs quickly.'),
      ],
      status: 'reviewed',
      marksObtained: 6,
      feedback: 'Good attempt Chipo! Check question 3 - "elephant" is correct but also look for other nouns in the sentence. For question 4, remember you need an adjective in your sentence.',
      markedAt: DateTime.now().subtract(const Duration(days: 1)),
      reviewedBy: 'Teacher Chigumira',
    ),
    HomeworkSubmission(
      id: 'sub_5',
      homeworkId: 'hw_7',
      studentId: 'student_1',
      studentName: 'Tendai Musoni',
      submittedAt: DateTime.now().subtract(const Duration(days: 1)),
      answers: [
        Answer(questionId: 'q1', answerText: '2x + 5 = 13\n2x = 13 - 5\n2x = 8\nx = 4'),
        Answer(questionId: 'q2', answerText: '3y - 7 = 14\n3y = 14 + 7\n3y = 21\ny = 7'),
        Answer(questionId: 'q3', answerText: '4(x + 2) = 20\n4x + 8 = 20\n4x = 12\nx = 3'),
        Answer(questionId: 'q4', answerText: '5a + 3 = 2a + 15\n5a - 2a = 15 - 3\n3a = 12\na = 4'),
        Answer(questionId: 'q5', answerText: 'Let the number be n.\nn + 8 = 20\nn = 12\nThe number is 12.'),
      ],
      status: 'submitted',
    ),
    HomeworkSubmission(
      id: 'sub_6',
      homeworkId: 'hw_9',
      studentId: 'student_11',
      studentName: 'Rutendo Mafukidze',
      submittedAt: DateTime.now().subtract(const Duration(hours: 6)),
      answers: [
        Answer(questionId: 'q1', answerText: 'A DNA nucleotide consists of three components: a phosphate group, a deoxyribose sugar, and a nitrogenous base (adenine, thymine, cytosine, or guanine).'),
        Answer(questionId: 'q2', answerText: 'DNA replication is semi-conservative. The double helix unwinds, each strand serves as a template, complementary nucleotides are added by DNA polymerase, resulting in two identical DNA molecules each with one original and one new strand.'),
        Answer(questionId: 'q3', answerText: 'mRNA carries the genetic code from DNA in the nucleus to ribosomes in the cytoplasm, where it serves as a template for protein synthesis during translation.'),
        Answer(questionId: 'q4', answerText: 'DNA is double-stranded, contains deoxyribose sugar and thymine, while RNA is single-stranded, contains ribose sugar and uracil. DNA stores genetic information while RNA transmits it.'),
      ],
      status: 'submitted',
    ),
  ];

  static List<Homework> getHomeworkForGrade(String grade) {
    return homeworkAssignments.where((h) => h.gradeLevel == grade).toList();
  }

  static List<Homework> getHomeworkForSubject(String subjectId) {
    return homeworkAssignments.where((h) => h.subjectId == subjectId).toList();
  }

  static List<HomeworkSubmission> getSubmissionsForHomework(String homeworkId) {
    return sampleSubmissions.where((s) => s.homeworkId == homeworkId).toList();
  }

  static List<HomeworkSubmission> getSubmissionsForStudent(String studentId) {
    return sampleSubmissions.where((s) => s.studentId == studentId).toList();
  }

  static final List<StudentProgress> sampleProgress = [
    StudentProgress(
      studentId: 'student_1',
      subjectId: 'o1_mat',
      subjectName: 'Mathematics',
      topics: [
        TopicProgress(topicName: 'Number Theory', status: 'completed', score: 88),
        TopicProgress(topicName: 'Algebra', status: 'completed', score: 92),
        TopicProgress(topicName: 'Geometry', status: 'in_progress', score: 75),
        TopicProgress(topicName: 'Trigonometry', status: 'not_started', score: 0),
      ],
      quizzesTaken: 4,
      homeworksSubmitted: 6,
      homeworksReviewed: 5,
      averageScore: 85.5,
    ),
    StudentProgress(
      studentId: 'student_1',
      subjectId: 'o1_eng',
      subjectName: 'English',
      topics: [
        TopicProgress(topicName: 'Grammar and Structure', status: 'completed', score: 90),
        TopicProgress(topicName: 'Composition Writing', status: 'completed', score: 82),
        TopicProgress(topicName: 'Comprehension', status: 'in_progress', score: 70),
      ],
      quizzesTaken: 3,
      homeworksSubmitted: 4,
      homeworksReviewed: 4,
      averageScore: 78.0,
    ),
    StudentProgress(
      studentId: 'student_2',
      subjectId: 'g3_mat',
      subjectName: 'Mathematics',
      topics: [
        TopicProgress(topicName: 'Multiplication', status: 'completed', score: 75),
        TopicProgress(topicName: 'Division', status: 'in_progress', score: 65),
        TopicProgress(topicName: 'Fractions', status: 'not_started', score: 0),
        TopicProgress(topicName: 'Data Handling', status: 'not_started', score: 0),
      ],
      quizzesTaken: 3,
      homeworksSubmitted: 5,
      homeworksReviewed: 4,
      averageScore: 70.0,
    ),
    StudentProgress(
      studentId: 'student_2',
      subjectId: 'g3_eng',
      subjectName: 'English',
      topics: [
        TopicProgress(topicName: 'Grammar', status: 'completed', score: 72),
        TopicProgress(topicName: 'Comprehension', status: 'in_progress', score: 68),
        TopicProgress(topicName: 'Creative Writing', status: 'not_started', score: 0),
      ],
      quizzesTaken: 2,
      homeworksSubmitted: 4,
      homeworksReviewed: 3,
      averageScore: 65.5,
    ),
    StudentProgress(
      studentId: 'student_10',
      subjectId: 'o4_mat',
      subjectName: 'Mathematics',
      topics: [
        TopicProgress(topicName: 'O-Level Revision', status: 'in_progress', score: 72),
        TopicProgress(topicName: 'Exam Techniques', status: 'not_started', score: 0),
      ],
      quizzesTaken: 3,
      homeworksSubmitted: 4,
      homeworksReviewed: 3,
      averageScore: 72.0,
    ),
    StudentProgress(
      studentId: 'student_11',
      subjectId: 'a5_bio',
      subjectName: 'Biology',
      topics: [
        TopicProgress(topicName: 'Molecular Biology', status: 'completed', score: 85),
        TopicProgress(topicName: 'Genetics', status: 'in_progress', score: 78),
      ],
      quizzesTaken: 2,
      homeworksSubmitted: 3,
      homeworksReviewed: 2,
      averageScore: 82.0,
    ),
    StudentProgress(
      studentId: 'student_11',
      subjectId: 'a5_mat',
      subjectName: 'Mathematics',
      topics: [
        TopicProgress(topicName: 'Pure Mathematics', status: 'in_progress', score: 80),
        TopicProgress(topicName: 'Statistics', status: 'not_started', score: 0),
      ],
      quizzesTaken: 2,
      homeworksSubmitted: 2,
      homeworksReviewed: 1,
      averageScore: 80.0,
    ),
    StudentProgress(
      studentId: 'student_12',
      subjectId: 'a6_che',
      subjectName: 'Chemistry',
      topics: [
        TopicProgress(topicName: 'Inorganic Chemistry', status: 'completed', score: 90),
        TopicProgress(topicName: 'Analytical Chemistry', status: 'in_progress', score: 75),
      ],
      quizzesTaken: 3,
      homeworksSubmitted: 4,
      homeworksReviewed: 4,
      averageScore: 86.0,
    ),
    StudentProgress(
      studentId: 'student_6',
      subjectId: 'ecda_mat',
      subjectName: 'Early Numeracy',
      topics: [
        TopicProgress(topicName: 'Number Concepts', status: 'completed', score: 85),
        TopicProgress(topicName: 'Shapes and Colours', status: 'completed', score: 90),
        TopicProgress(topicName: 'Patterns and Sorting', status: 'in_progress', score: 70),
      ],
      quizzesTaken: 2,
      homeworksSubmitted: 3,
      homeworksReviewed: 3,
      averageScore: 82.0,
    ),
  ];

  static StudentProgress? getStudentProgress(String studentId, String subjectId) {
    return sampleProgress.where(
      (p) => p.studentId == studentId && p.subjectId == subjectId,
    ).firstOrNull;
  }

  static List<StudentProgress> getStudentAllProgress(String studentId) {
    return sampleProgress.where((p) => p.studentId == studentId).toList();
  }

  static final List<StudentRecord> sampleStudents = [
    StudentRecord(id: 'student_1', name: 'Tendai Musoni', gradeLevel: 'Form 1', subjectProgress: {}),
    StudentRecord(id: 'student_2', name: 'Chipo Dube', gradeLevel: 'Grade 3', subjectProgress: {}),
    StudentRecord(id: 'student_3', name: 'Tafadzwa Chikwanha', gradeLevel: 'Grade 5', subjectProgress: {}),
    StudentRecord(id: 'student_4', name: 'Ropafadzo Moyo', gradeLevel: 'Grade 5', subjectProgress: {}),
    StudentRecord(id: 'student_5', name: 'Kudzai Makoni', gradeLevel: 'Grade 1', subjectProgress: {}),
    StudentRecord(id: 'student_6', name: 'Tanaka Zvobgo', gradeLevel: 'ECD A', subjectProgress: {}),
    StudentRecord(id: 'student_7', name: 'Makanaka Banda', gradeLevel: 'ECD B', subjectProgress: {}),
    StudentRecord(id: 'student_8', name: 'Nyasha Chirwa', gradeLevel: 'Form 2', subjectProgress: {}),
    StudentRecord(id: 'student_9', name: 'Tatenda Gumbo', gradeLevel: 'Form 3', subjectProgress: {}),
    StudentRecord(id: 'student_10', name: 'Kudakwashe Sibanda', gradeLevel: 'Form 4', subjectProgress: {}),
    StudentRecord(id: 'student_11', name: 'Rutendo Mafukidze', gradeLevel: 'Form 5', subjectProgress: {}),
    StudentRecord(id: 'student_12', name: 'Anesu Dzvairo', gradeLevel: 'Form 6', subjectProgress: {}),
    StudentRecord(id: 'student_13', name: 'Tariro Mutsvene', gradeLevel: 'Grade 2', subjectProgress: {}),
    StudentRecord(id: 'student_14', name: 'Simba Makoni', gradeLevel: 'Grade 4', subjectProgress: {}),
    StudentRecord(id: 'student_15', name: 'Vimbai Hove', gradeLevel: 'Grade 6', subjectProgress: {}),
  ];

  static List<StudentRecord> getStudentsByGrade(String grade) {
    return sampleStudents.where((s) => s.gradeLevel == grade).toList();
  }
}
