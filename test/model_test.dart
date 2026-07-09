// test/model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:zim_heritage_app/models/answer_key.dart';
import 'package:zim_heritage_app/models/attendance.dart';
import 'package:zim_heritage_app/models/book.dart';
import 'package:zim_heritage_app/models/exam_prediction.dart';
import 'package:zim_heritage_app/models/heritage.dart';
import 'package:zim_heritage_app/models/homework.dart';
import 'package:zim_heritage_app/models/learner_passport.dart';
import 'package:zim_heritage_app/models/lesson.dart';
import 'package:zim_heritage_app/models/message.dart';
import 'package:zim_heritage_app/models/national_models.dart';
import 'package:zim_heritage_app/models/progress.dart';
import 'package:zim_heritage_app/models/school_event.dart';
import 'package:zim_heritage_app/models/subject.dart';
import 'package:zim_heritage_app/models/submission.dart';
import 'package:zim_heritage_app/models/teacher_content.dart';

void main() {
  group('Subject', () {
    test('fromMap creates Subject with defaults', () {
      final s = Subject.fromMap({}, 's1');
      expect(s.id, 's1');
      expect(s.name, '');
      expect(s.color, '0xFF4CAF50');
      expect(s.icon, 'book');
    });

    test('fromMap parses all fields', () {
      final s = Subject.fromMap({
        'name': 'Mathematics',
        'description': 'Numbers',
        'gradeLevel': 'Form 1',
        'color': '0xFFFF0000',
        'icon': 'calculate',
      }, 's1');
      expect(s.name, 'Mathematics');
      expect(s.description, 'Numbers');
      expect(s.gradeLevel, 'Form 1');
      expect(s.color, '0xFFFF0000');
      expect(s.icon, 'calculate');
    });

    test('toMap produces correct map', () {
      final s = Subject(id: 's1', name: 'Math', description: 'Desc', gradeLevel: 'Form 1', color: '0xFF0000', icon: 'calc');
      final m = s.toMap();
      expect(m['name'], 'Math');
      expect(m['gradeLevel'], 'Form 1');
      expect(m['icon'], 'calc');
    });
  });

  group('Topic', () {
    test('fromMap creates Topic with defaults', () {
      final t = Topic.fromMap({}, 't1');
      expect(t.id, 't1');
      expect(t.subtopics, isEmpty);
      expect(t.term, 'Term 1');
    });

    test('fromMap parses subtopics list', () {
      final t = Topic.fromMap({
        'subjectId': 's1',
        'name': 'Algebra',
        'subtopics': ['Linear', 'Quadratic'],
        'gradeLevel': 'Form 1',
        'term': 'Term 2',
      }, 't1');
      expect(t.subjectId, 's1');
      expect(t.subtopics, ['Linear', 'Quadratic']);
      expect(t.term, 'Term 2');
    });

    test('toMap round-trips', () {
      final t = Topic(id: 't1', subjectId: 's1', name: 'Algebra', description: 'Desc', subtopics: ['A'], gradeLevel: 'Form 1', term: 'Term 2');
      final m = t.toMap();
      expect(m['subjectId'], 's1');
      expect(m['name'], 'Algebra');
      expect(m['subtopics'], ['A']);
    });
  });

  group('Lesson', () {
    test('constructs with empty image assets', () {
      final l = Lesson(
        id: 'l1', subjectId: 's1', topicId: 't1', title: 'Intro',
        gradeLevel: 'Form 1', objectives: ['Know X'], sections: [],
        keyPoints: ['KP1'], practiceQuestions: [], references: [],
      );
      expect(l.imageAssets, []);
    });
  });

  group('Book', () {
    test('fromMap creates Book with defaults', () {
      final b = Book.fromMap({}, 'b1');
      expect(b.type, 'textbook');
      expect(b.url, '');
      expect(b.gradeLevels, isEmpty);
    });

    test('fromMap parses all fields', () {
      final b = Book.fromMap({
        'subjectId': 's1', 'title': 'Maths', 'author': 'J. Smith',
        'description': 'Desc', 'type': 'reference', 'url': 'http://example.com',
        'gradeLevels': ['Form 1', 'Form 2'], 'topics': ['Algebra'],
      }, 'b1');
      expect(b.title, 'Maths');
      expect(b.type, 'reference');
      expect(b.gradeLevels, ['Form 1', 'Form 2']);
    });

    test('toMap round-trips', () {
      final b = Book(id: 'b1', subjectId: 's1', title: 'T', author: 'A', description: 'D', type: 'textbook', url: 'u', gradeLevels: ['F1'], topics: ['Alg']);
      final m = b.toMap();
      expect(m['title'], 'T');
      expect(m['author'], 'A');
      expect(m['gradeLevels'], ['F1']);
    });
  });

  group('Homework', () {
    test('fromMap handles missing fields', () {
      final h = Homework.fromMap({}, 'h1');
      expect(h.status, 'active');
      expect(h.questions, isEmpty);
    });

    test('fromMap parses questions', () {
      final h = Homework.fromMap({
        'subjectId': 's1', 'title': 'HW1', 'description': 'Desc',
        'gradeLevel': 'Form 1', 'dueDate': null,
        'questions': [
          {'questionId': 'q1', 'text': 'What?', 'type': 'short_answer', 'marks': 5},
        ],
        'teacherId': 't1',
      }, 'h1');
      expect(h.questions.length, 1);
      expect(h.questions.first.question, 'What?');
      expect(h.questions.first.marks, 5);
    });

    test('toMap round-trips', () {
      final h = Homework(id: 'h1', subjectId: 's1', title: 'HW', description: 'D', gradeLevel: 'F1', dueDate: DateTime(2026, 7, 10), questions: [], teacherId: 't1');
      final m = h.toMap();
      expect(m['title'], 'HW');
      expect(m['createdBy'], 't1');
    });
  });

  group('HomeworkQuestion', () {
    test('fromMap uses fallback keys', () {
      final q = HomeworkQuestion.fromMap({'id': 'q1', 'question': 'Q?', 'type': 'mcq', 'marks': 2});
      expect(q.id, 'q1');
      expect(q.question, 'Q?');
    });

    test('toMap maps fields', () {
      final q = HomeworkQuestion(id: 'q1', question: 'Q?', type: 'short_answer', marks: 3);
      final m = q.toMap();
      expect(m['questionId'], 'q1');
      expect(m['text'], 'Q?');
    });
  });

  group('HomeworkSubmission', () {
    test('fromMap handles empty answers', () {
      final s = HomeworkSubmission.fromMap({}, 'sub1');
      expect(s.status, 'submitted');
      expect(s.answers, isEmpty);
    });

    test('fromMap parses answers', () {
      final s = HomeworkSubmission.fromMap({
        'homeworkId': 'h1', 'studentId': 'stu1', 'studentName': 'Tendai',
        'submittedAt': null,
        'answers': [{'questionId': 'q1', 'answerText': '42'}],
        'status': 'graded', 'marksObtained': 5, 'totalMarks': 10,
      }, 'sub1');
      expect(s.studentName, 'Tendai');
      expect(s.marksObtained, 5);
      expect(s.status, 'graded');
    });

    test('markSubmission updates fields', () {
      final s = HomeworkSubmission(id: 's1', homeworkId: 'h1', studentId: 'stu1', studentName: 'T', submittedAt: DateTime.now(), answers: []);
      s.status = 'graded';
      s.marksObtained = 8;
      expect(s.status, 'graded');
    });

    test('score getter returns marksObtained', () {
      final s = HomeworkSubmission(id: 's1', homeworkId: 'h1', studentId: 'stu1', studentName: 'T', submittedAt: DateTime.now(), answers: [], marksObtained: 7);
      expect(s.score, 7);
    });
  });

  group('Answer', () {
    test('fromMap uses fallback keys', () {
      final a = Answer.fromMap({'questionId': 'q1', 'answer': 'Yes', 'isCorrect': true});
      expect(a.answerText, 'Yes');
      expect(a.isCorrect, true);
    });

    test('answer getter returns answerText', () {
      final a = Answer(questionId: 'q1', answerText: '42');
      expect(a.answer, '42');
    });
  });

  group('StudentProgress', () {
    test('fromMap falls back to id parsing for missing fields', () {
      final p = StudentProgress.fromMap({}, 'stu1_math');
      expect(p.studentId, 'stu1');
      expect(p.subjectId, 'math');
    });

    test('fromMap parses full object', () {
      final p = StudentProgress.fromMap({
        'studentId': 'stu1', 'subjectId': 'math', 'subjectName': 'Mathematics',
        'quizzesTaken': 5, 'homeworksSubmitted': 3, 'homeworksReviewed': 2, 'overallPercentage': 78.5,
        'topics': [
          {'topicName': 'Algebra', 'status': 'completed', 'percentage': 85},
        ],
      }, 'stu1_math');
      expect(p.subjectName, 'Mathematics');
      expect(p.quizzesTaken, 5);
      expect(p.averageScore, 78.5);
      expect(p.topics.length, 1);
    });

    test('toMap round-trips', () {
      final p = StudentProgress(studentId: 's1', subjectId: 'sub1', subjectName: 'Math', topics: [], quizzesTaken: 3, homeworksSubmitted: 2, homeworksReviewed: 1, averageScore: 75);
      final m = p.toMap();
      expect(m['overallPercentage'], 75);
    });
  });

  group('TopicProgress', () {
    test('fromMap uses defaults', () {
      final t = TopicProgress.fromMap({});
      expect(t.status, 'not_started');
      expect(t.score, 0);
    });

    test('toMap round-trips', () {
      final t = TopicProgress(topicName: 'Algebra', status: 'completed', score: 90);
      final m = t.toMap();
      expect(m['percentage'], 90);
    });
  });

  group('StudentRecord', () {
    test('fromMap creates with empty progress', () {
      final r = StudentRecord.fromMap({'name': 'Tendai', 'gradeLevel': 'Form 1'}, 'r1');
      expect(r.subjectProgress, {});
    });
  });

  group('AttendanceRecord', () {
    test('fromMap uses absent as default status', () {
      final a = AttendanceRecord.fromMap({}, 'a1');
      expect(a.status, 'absent');
      expect(a.date, '');
    });

    test('fromMap parses all fields', () {
      final a = AttendanceRecord.fromMap({
        'studentId': 's1', 'date': '2026-07-09', 'status': 'present',
        'recordedBy': 't1',
      }, 'a1');
      expect(a.studentId, 's1');
      expect(a.status, 'present');
    });
  });

  group('Message', () {
    test('fromMap uses defaults', () {
      final m = Message.fromMap({}, 'm1');
      expect(m.isRead, false);
      expect(m.text, '');
    });

    test('fromMap parses fields', () {
      final m = Message.fromMap({
        'senderId': 's1', 'senderName': 'Tendai', 'receiverId': 'r1',
        'receiverName': 'Teacher', 'text': 'Hello', 'isRead': true,
      }, 'm1');
      expect(m.senderName, 'Tendai');
      expect(m.isRead, true);
    });
  });

  group('OralHistory', () {
    test('default values', () {
      const o = OralHistory(id: 'o1', title: 'Story', storyteller: 'Elder', community: 'Masvingo', language: 'Shona', category: 'folktale', summary: 'Sum', transcript: 'T', durationSeconds: 120, dateRecorded: '2024', recordedBy: 'r');
      expect(o.verified, false);
      expect(o.audioUrl, '');
    });
  });

  group('HeritageSite', () {
    test('default isUnesco false', () {
      const h = HeritageSite(id: 'h1', name: 'Great Zimbabwe', location: 'Masvingo', province: 'Masvingo', description: 'D', significance: 'S', category: 'ruins', lat: -20.27, lng: 30.93);
      expect(h.isUnesco, false);
    });
  });

  group('SchoolEvent', () {
    test('fromMap uses meeting as default type', () {
      final e = SchoolEvent.fromMap({}, 'e1');
      expect(e.type, 'meeting');
      expect(e.title, '');
    });

    test('fromMap parses all fields', () {
      final e = SchoolEvent.fromMap({
        'title': 'Sports Day',
        'description': 'Annual sports',
        'startDate': '2026-07-15',
        'endDate': '2026-07-16',
        'type': 'sports',
        'school': 'Demo High',
        'province': 'Harare',
      }, 'e1');
      expect(e.title, 'Sports Day');
      expect(e.type, 'sports');
      expect(e.school, 'Demo High');
    });

    test('toMap round-trips', () {
      final e = SchoolEvent(id: 'e1', title: 'T', description: 'D', startDate: DateTime(2026, 7, 15), type: 'exam');
      final m = e.toMap();
      expect(m['title'], 'T');
      expect(m['type'], 'exam');
    });
  });

  group('PredictionResult', () {
    test('default constructor works', () {
      const p = PredictionResult(
        subjectId: 's1', subjectName: 'Math', predictedGrade: 65,
        predictedSymbol: 'C', confidence: 0.8, currentAverage: 60,
        weakAreas: [], recommendations: [], riskLevel: 'medium',
      );
      expect(p.riskLevel, 'medium');
    });
  });

  group('LearnerPassport', () {
    test('default constructor works', () {
      const lp = LearnerPassport(
        studentId: 's1', studentName: 'Tendai', gradeLevel: 'Form 1',
        school: 'Demo', passportHash: 'abc123', records: [],
        achievements: [], skills: [], certificates: [],
      );
      expect(lp.passportHash, 'abc123');
    });
  });

  group('AnswerKey', () {
    test('fromMap uses answers key for entries', () {
      final ak = AnswerKey.fromMap({
        'subjectId': 's1', 'topicId': 't1', 'title': 'Answer Key',
        'gradeLevel': 'Form 1',
        'answers': [
          {'question': 'Q1', 'correctAnswer': 'A1', 'explanation': 'E1', 'maxMarks': 5},
        ],
      }, 'ak1');
      expect(ak.title, 'Answer Key');
      expect(ak.entries.length, 1);
      expect(ak.entries.first.answer, 'A1');
    });

    test('fromMap handles empty entries', () {
      final ak = AnswerKey.fromMap({}, 'ak1');
      expect(ak.entries, isEmpty);
    });
  });

  group('AnswerKeyEntry', () {
    test('fromMap falls back to answer key', () {
      final e = AnswerKeyEntry.fromMap({'question': 'Q?', 'answer': 'A!', 'explanation': 'Exp', 'marks': 3});
      expect(e.answer, 'A!');
    });

    test('fromMap uses correctAnswer if answer missing', () {
      final e = AnswerKeyEntry.fromMap({'question': 'Q?', 'correctAnswer': 'CA', 'explanation': 'Exp', 'marks': 2});
      expect(e.answer, 'CA');
    });
  });

  group('ContentTemplate', () {
    test('default values', () {
      final c = ContentTemplate(
        id: 'c1', title: 'Lesson Plan', subjectId: 's1', gradeLevel: 'Form 1',
        topic: 'Algebra', objectives: [], sections: [], estimatedMinutes: 45,
        authorId: 'a1', authorName: 'Author', createdAt: DateTime(2026, 7, 1),
      );
      expect(c.downloads, 0);
      expect(c.isPublished, false);
      expect(c.isPremium, false);
    });
  });

  group('LessonPlan', () {
    test('default constructor works', () {
      const lp = LessonPlan(
        id: 'lp1', title: 'Algebra', subjectId: 's1', gradeLevel: 'Form 1',
        durationMinutes: 45, objectives: [], materials: [], activities: [],
        assessmentMethod: 'Quiz', authorName: 'Teacher',
      );
      expect(lp.assessmentMethod, 'Quiz');
    });
  });

  group('Province', () {
    test('constructor works', () {
      const p = Province(id: 'p1', name: 'Harare', population: 2500000, districts: []);
      expect(p.name, 'Harare');
    });
  });

  group('School', () {
    test('constructor works', () {
      const s = School(id: 's1', name: 'Demo High', type: 'secondary', sector: 'government', enrolment: 500, teachers: 30, passRate: 75, attendanceRate: 90, hasInternet: true, hasElectricity: true, hasWater: true, lat: -17.8, lng: 31.0);
      expect(s.name, 'Demo High');
      expect(s.enrolment, 500);
    });
  });

  group('NationalMetric', () {
    test('constructor with IconType enum', () {
      const m = NationalMetric(label: 'Schools', value: '9,800+', delta: '+5%', isPositive: true, icon: IconType.school);
      expect(m.label, 'Schools');
      expect(m.icon, IconType.school);
    });
  });

  group('NDS1KPI', () {
    test('constructor works', () {
      const k = NDS1KPI(indicator: 'Pass Rate', baseline2021: 45, target2025: 75, current: 62, status: 'on_track');
      expect(k.status, 'on_track');
    });
  });

  group('ConversationPreview', () {
    test('default unreadCount is 0', () {
      final c = ConversationPreview(otherUserId: 'u1', otherUserName: 'Tendai', lastMessage: 'Hi', lastMessageTime: DateTime(0));
      expect(c.unreadCount, 0);
    });
  });

  group('CPDCourse', () {
    test('default progress and completed', () {
      const c = CPDCourse(id: 'c1', title: 'Pedagogy', provider: 'MoPSE', hours: 40, category: 'teaching');
      expect(c.progress, 0);
      expect(c.completed, false);
    });
  });

  group('ResourceBundle', () {
    test('default isFree true', () {
      const r = ResourceBundle(id: 'r1', title: 'Bundle', description: 'D', subjectId: 's1', gradeLevel: 'F1', fileTypes: ['pdf']);
      expect(r.isFree, true);
    });
  });
}
