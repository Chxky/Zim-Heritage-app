import '../data/answer_keys.dart' as ak;
import '../data/sample_data.dart';
import '../data/zimbabwe_curriculum.dart';
import '../models/answer_key.dart';
import '../models/homework.dart';
import '../models/progress.dart';
import '../models/subject.dart';
import '../models/submission.dart';
import '../models/user.dart';

class MockDataService {
  static final List<User> _users = [
    User(id: 'student_mazvita', name: 'Mazvita', email: 'mazvita@demo.com', role: 'student', gradeLevel: 'Form 4', school: 'Demo High School', schoolMotto: 'Learn, Lead, Inspire', age: 16, isVerified: true),
    User(id: 'student_1', name: 'Tendai Musoni', email: 'student@demo.com', role: 'student', gradeLevel: 'Form 1', school: 'Demo High School', schoolMotto: 'Learn, Lead, Inspire', age: 14, isVerified: true),
    User(id: 'teacher_1', name: 'Teacher Chigumira', email: 'teacher@demo.com', role: 'teacher', gradeLevel: 'N/A', school: 'Demo High School', schoolMotto: 'Learn, Lead, Inspire', age: 35, isVerified: true),
    User(id: 'parent_1', name: 'Amai Moyo', email: 'parent@demo.com', role: 'parent', gradeLevel: 'N/A', school: 'Demo High School', schoolMotto: 'Learn, Lead, Inspire', age: 40, isVerified: true),
    User(id: 'admin_1', name: 'Pardon Mahara', email: 'admin@demo.com', role: 'admin', gradeLevel: 'N/A', school: 'ZimHeritage Education', schoolMotto: 'Preserving our heritage', age: 30, isVerified: true),
    User(id: 'ecd_1', name: 'Ruva', email: 'ecd@demo.com', role: 'student', gradeLevel: 'ECD A', school: 'Sunshine Primary', schoolMotto: 'Shining Bright', age: 4, isVerified: true),
  ];

  static User? _currentUser;

  static User? get currentUser => _currentUser;

  static final List<Homework> _homeworks = List.from(SampleData.homeworkAssignments);
  static final List<HomeworkSubmission> _submissions = List.from(SampleData.sampleSubmissions);
  static final List<StudentProgress> _progress = List.from(SampleData.sampleProgress);

  static Future<User> signInWithGoogle() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final existing = _users.where((u) => u.authProvider == 'google').firstOrNull;
    if (existing != null) {
      _currentUser = existing;
      return existing;
    }
    final id = 'google_${DateTime.now().millisecondsSinceEpoch}';
    final user = User(
      id: id,
      name: 'Google User',
      email: 'google.user@gmail.com',
      role: 'parent',
      gradeLevel: 'N/A',
      school: '',
      age: 30,
      isVerified: true,
      authProvider: 'google',
      schoolMotto: 'Registered Google User',
    );
    _users.add(user);
    _currentUser = user;
    return user;
  }



  static Future<User?> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final cleanEmail = email.trim().toLowerCase();
    final targetEmail = cleanEmail.contains('@') ? cleanEmail : '$cleanEmail@demo.com';

    final user = _users.where((u) => u.email.toLowerCase() == targetEmail || (targetEmail.contains('mazvita') && u.email.contains('mazvita'))).firstOrNull;
    if (user == null) {
      if (targetEmail.contains('mazvita') || targetEmail.endsWith('@demo.com')) {
        final demoUser = User(
          id: targetEmail.contains('mazvita') ? 'student_mazvita' : 'demo_user',
          name: targetEmail.contains('mazvita') ? 'Mazvita' : 'Demo Student',
          email: targetEmail,
          role: targetEmail.contains('teacher') ? 'teacher' : (targetEmail.contains('admin') ? 'admin' : (targetEmail.contains('parent') ? 'parent' : 'student')),
          gradeLevel: 'Form 4',
          school: 'Demo High School',
          age: 16,
          isVerified: true,
        );
        _users.add(demoUser);
        _currentUser = demoUser;
        return demoUser;
      }
      throw Exception('No account found for this email.');
    }
    _currentUser = user;
    return user;
  }

  static Future<User> register({
    required String name,
    required String email,
    required String password,
    required String role,
    required String gradeLevel,
    required String school,
    required int age,
    bool hasFacialRecognition = false,
    String curriculum = 'zimsec',
    String? schoolMotto,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (_users.any((u) => u.email == email)) throw Exception('Email already registered.');
    final id = 'user_${DateTime.now().millisecondsSinceEpoch}';
    final user = User(
      id: id, name: name, email: email, role: role,
      gradeLevel: gradeLevel, school: school, age: age,
      isVerified: true, hasFacialRecognition: hasFacialRecognition,
      curriculum: curriculum, schoolMotto: schoolMotto,
    );
    _users.add(user);
    _currentUser = user;
    return user;
  }

  static Future<void> logout() async {
    _currentUser = null;
  }

  static Future<User?> getCurrentUserFromSession() async {
    return _currentUser;
  }

  static Future<User> refreshUser() async {
    if (_currentUser == null) throw Exception('Not logged in');
    return _currentUser!;
  }

  static bool get isLoggedIn => _currentUser != null;

  static Future<void> sendPasswordReset(String email) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final user = _users.where((u) => u.email == email).firstOrNull;
    if (user == null) throw Exception('No account found for this email.');
  }

  static Future<User?> getUserByUid(String uid) async {
    return _users.where((u) => u.id == uid).firstOrNull;
  }

  static Future<List<User>> getAllUsers() async {
    return List.from(_users);
  }

  static Future<List<User>> getUsersByRole(String role) async {
    return _users.where((u) => u.role == role).toList();
  }

  static Future<List<User>> getUsersByGrade(String gradeLevel) async {
    return _users.where((u) => u.gradeLevel == gradeLevel).toList();
  }

  static Future<int> getUserCount() async {
    return _users.length;
  }

  static Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    final index = _users.indexWhere((u) => u.id == uid);
    if (index == -1) return;
    final old = _users[index];
    _users[index] = old.copyWith(
      name: data['name'] as String?,
      school: data['school'] as String?,
      age: data['age'] as int?,
      isVerified: data['isVerified'] as bool?,
      schoolMotto: data['schoolMotto'] as String?,
    );
  }

  static Future<void> createUser(User user) async {
    _users.add(user);
  }

  static Future<List<Homework>> getHomeworksByGrade(String gradeLevel) async {
    final hws = _homeworks.where((h) => h.gradeLevel == gradeLevel);
    return hws.toList();
  }

  static Future<List<Homework>> getHomeworksByGradeAndSubject(String gradeLevel, String subjectId) async {
    return _homeworks.where((h) => h.gradeLevel == gradeLevel && h.subjectId == subjectId).toList();
  }

  static Future<Homework?> getHomeworkById(String homeworkId) async {
    return _homeworks.where((h) => h.id == homeworkId).firstOrNull;
  }

  static Future<void> createHomework(Homework homework) async {
    _homeworks.add(homework);
  }

  static Future<void> updateHomework(String id, Map<String, dynamic> data) async {
    final index = _homeworks.indexWhere((h) => h.id == id);
    if (index == -1) return;
    final old = _homeworks[index];
    _homeworks[index] = Homework(
      id: old.id,
      subjectId: data['subjectId'] as String? ?? old.subjectId,
      title: data['title'] as String? ?? old.title,
      description: data['description'] as String? ?? old.description,
      gradeLevel: data['gradeLevel'] as String? ?? old.gradeLevel,
      dueDate: data['dueDate'] as DateTime? ?? old.dueDate,
      questions: old.questions,
      attachments: old.attachments,
      status: data['status'] as String? ?? old.status,
      teacherId: data['createdBy'] as String? ?? old.teacherId,
    );
  }

  static Future<void> deleteHomework(String id) async {
    _homeworks.removeWhere((h) => h.id == id);
  }

  static Future<int> getHomeworkCount() async {
    return _homeworks.length;
  }

  static Future<List<HomeworkSubmission>> getSubmissionsByStudent(String studentId) async {
    return _submissions.where((s) => s.studentId == studentId).toList();
  }

  static Future<List<HomeworkSubmission>> getAllSubmissions() async {
    return List.from(_submissions);
  }

  static Future<List<HomeworkSubmission>> getSubmissionsForHomework(String homeworkId) async {
    return _submissions.where((s) => s.homeworkId == homeworkId).toList();
  }

  static Future<void> submitHomework(HomeworkSubmission submission) async {
    _submissions.add(submission);
  }

  static Future<void> markSubmission(String submissionId, Map<String, dynamic> data) async {
    final index = _submissions.indexWhere((s) => s.id == submissionId);
    if (index == -1) return;
    final old = _submissions[index];
    _submissions[index] = HomeworkSubmission(
      id: old.id, homeworkId: old.homeworkId,
      studentId: old.studentId, studentName: old.studentName,
      answers: old.answers, submittedAt: old.submittedAt,
      status: data['status'] as String? ?? old.status,
      marksObtained: data['marksObtained'] as int? ?? old.marksObtained,
      totalMarks: data['totalMarks'] as int? ?? old.totalMarks,
      feedback: data['feedback'] as String? ?? old.feedback,
      markedAt: data['markedAt'] as DateTime? ?? old.markedAt,
      reviewedBy: data['reviewedBy'] as String? ?? old.reviewedBy,
    );
  }

  static Future<int> getSubmissionCount() async {
    return _submissions.length;
  }

  static Future<int> getPendingSubmissionCount() async {
    return _submissions.where((s) => s.status == 'submitted').length;
  }

  static Future<List<StudentProgress>> getProgressForStudent(String studentId) async {
    final progress = SampleData.getStudentAllProgress(studentId);
    if (progress.isNotEmpty) return progress;
    return _progress.where((p) => p.studentId == studentId).toList();
  }

  static Future<StudentProgress?> getProgressForStudentAndSubject(String studentId, String subjectId) async {
    return _progress.where((p) => p.studentId == studentId && p.subjectId == subjectId).firstOrNull;
  }

  static Future<void> updateProgress(String progressId, Map<String, dynamic> data) async {
    final index = _progress.indexWhere((p) => '${p.studentId}_${p.subjectId}' == progressId);
    if (index == -1) return;
    final old = _progress[index];
    _progress[index] = StudentProgress(
      studentId: old.studentId,
      subjectId: old.subjectId,
      subjectName: data['subjectName'] as String? ?? old.subjectName,
      topics: old.topics,
      quizzesTaken: data['quizzesTaken'] as int? ?? old.quizzesTaken,
      homeworksSubmitted: data['homeworksSubmitted'] as int? ?? old.homeworksSubmitted,
      homeworksReviewed: data['homeworksReviewed'] as int? ?? old.homeworksReviewed,
      averageScore: (data['averageScore'] as num?)?.toDouble() ?? old.averageScore,
    );
  }

  static Future<void> createProgress(StudentProgress progress) async {
    _progress.add(progress);
  }

  static List<AnswerKey> getAnswerKeysForGradeSync(String grade) {
    return ak.getAllAnswerKeysForGrade(grade);
  }

  static List<Subject> getSubjectsForGradeSync(String grade) {
    return getSubjectsForGrade(grade);
  }

  static List<String> getGradeLevelsSync() {
    return getGradeLevels();
  }
}
