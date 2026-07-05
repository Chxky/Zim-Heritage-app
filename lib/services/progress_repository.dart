import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/progress.dart';
import 'app_config.dart';
import 'mock_data_service.dart';

class ProgressRepository {
  static Future<List<StudentProgress>> getProgressForStudent(String studentId) async {
    if (!AppConfig.useFirebase) return MockDataService.getProgressForStudent(studentId);
    final snapshot = await FirebaseFirestore.instance
        .collection('progress').where('studentId', isEqualTo: studentId).get();
    return snapshot.docs
        .map((doc) => StudentProgress.fromMap(doc.data(), doc.id))
        .toList();
  }

  static Stream<List<StudentProgress>> streamProgressForStudent(String studentId) {
    return FirebaseFirestore.instance
        .collection('progress').where('studentId', isEqualTo: studentId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => StudentProgress.fromMap(doc.data(), doc.id))
            .toList());
  }

  static Future<StudentProgress?> getProgressForStudentAndSubject(
      String studentId, String subjectId) async {
    if (!AppConfig.useFirebase) {
      return MockDataService.getProgressForStudentAndSubject(studentId, subjectId);
    }
    final snapshot = await FirebaseFirestore.instance
        .collection('progress')
        .where('studentId', isEqualTo: studentId)
        .where('subjectId', isEqualTo: subjectId)
        .limit(1)
        .get();
    if (snapshot.docs.isEmpty) return null;
    return StudentProgress.fromMap(snapshot.docs.first.data(), snapshot.docs.first.id);
  }

  static Future<void> updateProgress(String progressId, Map<String, dynamic> data) async {
    if (!AppConfig.useFirebase) {
      await MockDataService.updateProgress(progressId, data);
      return;
    }
    await FirebaseFirestore.instance.collection('progress').doc(progressId).update(data);
  }

  static Future<void> createProgress(StudentProgress progress) async {
    if (!AppConfig.useFirebase) {
      await MockDataService.createProgress(progress);
      return;
    }
    final id = '${progress.studentId}_${progress.subjectId}';
    await FirebaseFirestore.instance.collection('progress').doc(id).set(progress.toMap());
  }
}
