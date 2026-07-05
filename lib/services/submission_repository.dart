import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/submission.dart';
import 'app_config.dart';
import 'mock_data_service.dart';

class SubmissionRepository {
  static Future<List<HomeworkSubmission>> getSubmissionsByStudent(String studentId) async {
    if (!AppConfig.useFirebase) return MockDataService.getSubmissionsByStudent(studentId);
    final snapshot = await FirebaseFirestore.instance
        .collection('submissions').where('studentId', isEqualTo: studentId).get();
    return snapshot.docs
        .map((doc) => HomeworkSubmission.fromMap(doc.data(), doc.id))
        .toList();
  }

  static Future<List<HomeworkSubmission>> getAllSubmissions() async {
    if (!AppConfig.useFirebase) return MockDataService.getAllSubmissions();
    final snapshot = await FirebaseFirestore.instance
        .collection('submissions').orderBy('submittedAt', descending: true).get();
    return snapshot.docs
        .map((doc) => HomeworkSubmission.fromMap(doc.data(), doc.id))
        .toList();
  }

  static Stream<List<HomeworkSubmission>> streamSubmissionsByStudent(String studentId) {
    return FirebaseFirestore.instance
        .collection('submissions').where('studentId', isEqualTo: studentId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => HomeworkSubmission.fromMap(doc.data(), doc.id))
            .toList());
  }

  static Future<List<HomeworkSubmission>> getSubmissionsForHomework(String homeworkId) async {
    if (!AppConfig.useFirebase) return MockDataService.getSubmissionsForHomework(homeworkId);
    final snapshot = await FirebaseFirestore.instance
        .collection('submissions').where('homeworkId', isEqualTo: homeworkId).get();
    return snapshot.docs
        .map((doc) => HomeworkSubmission.fromMap(doc.data(), doc.id))
        .toList();
  }

  static Stream<List<HomeworkSubmission>> streamSubmissionsForHomework(String homeworkId) {
    return FirebaseFirestore.instance
        .collection('submissions').where('homeworkId', isEqualTo: homeworkId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => HomeworkSubmission.fromMap(doc.data(), doc.id))
            .toList());
  }

  static Future<void> submitHomework(HomeworkSubmission submission) async {
    if (!AppConfig.useFirebase) {
      await MockDataService.submitHomework(submission);
      return;
    }
    await FirebaseFirestore.instance.collection('submissions').doc(submission.id).set(submission.toMap());
  }

  static Future<void> markSubmission(String submissionId, Map<String, dynamic> data) async {
    if (!AppConfig.useFirebase) {
      await MockDataService.markSubmission(submissionId, data);
      return;
    }
    await FirebaseFirestore.instance.collection('submissions').doc(submissionId).update(data);
  }

  static Future<int> getSubmissionCount() async {
    if (!AppConfig.useFirebase) return MockDataService.getSubmissionCount();
    final snapshot = await FirebaseFirestore.instance.collection('submissions').get();
    return snapshot.docs.length;
  }

  static Future<int> getPendingSubmissionCount() async {
    if (!AppConfig.useFirebase) return MockDataService.getPendingSubmissionCount();
    final snapshot = await FirebaseFirestore.instance
        .collection('submissions').where('status', isEqualTo: 'submitted').get();
    return snapshot.docs.length;
  }
}
