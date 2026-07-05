import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/homework.dart';
import 'app_config.dart';
import 'mock_data_service.dart';

class HomeworkRepository {
  static Future<List<Homework>> getHomeworksByGrade(String gradeLevel) async {
    if (!AppConfig.useFirebase) return MockDataService.getHomeworksByGrade(gradeLevel);
    final snapshot = await FirebaseFirestore.instance
        .collection('homeworks').where('gradeLevel', isEqualTo: gradeLevel).get();
    return snapshot.docs
        .map((doc) => Homework.fromMap(doc.data(), doc.id))
        .toList();
  }

  static Stream<List<Homework>> streamHomeworksByGrade(String gradeLevel) {
    return FirebaseFirestore.instance
        .collection('homeworks').where('gradeLevel', isEqualTo: gradeLevel)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Homework.fromMap(doc.data(), doc.id))
            .toList());
  }

  static Future<List<Homework>> getHomeworksByGradeAndSubject(
      String gradeLevel, String subjectId) async {
    if (!AppConfig.useFirebase) {
      return MockDataService.getHomeworksByGradeAndSubject(gradeLevel, subjectId);
    }
    final snapshot = await FirebaseFirestore.instance
        .collection('homeworks')
        .where('gradeLevel', isEqualTo: gradeLevel)
        .where('subjectId', isEqualTo: subjectId)
        .get();
    return snapshot.docs
        .map((doc) => Homework.fromMap(doc.data(), doc.id))
        .toList();
  }

  static Future<Homework?> getHomeworkById(String homeworkId) async {
    if (!AppConfig.useFirebase) return MockDataService.getHomeworkById(homeworkId);
    final doc = await FirebaseFirestore.instance.collection('homeworks').doc(homeworkId).get();
    if (!doc.exists) return null;
    return Homework.fromMap(doc.data() as Map<String, dynamic>, homeworkId);
  }

  static Future<void> createHomework(Homework homework) async {
    if (!AppConfig.useFirebase) {
      await MockDataService.createHomework(homework);
      return;
    }
    await FirebaseFirestore.instance.collection('homeworks').doc(homework.id).set(homework.toMap());
  }

  static Future<void> updateHomework(String id, Map<String, dynamic> data) async {
    if (!AppConfig.useFirebase) {
      await MockDataService.updateHomework(id, data);
      return;
    }
    await FirebaseFirestore.instance.collection('homeworks').doc(id).update(data);
  }

  static Future<void> deleteHomework(String id) async {
    if (!AppConfig.useFirebase) {
      await MockDataService.deleteHomework(id);
      return;
    }
    await FirebaseFirestore.instance.collection('homeworks').doc(id).delete();
  }

  static Future<int> getHomeworkCount() async {
    if (!AppConfig.useFirebase) return MockDataService.getHomeworkCount();
    final snapshot = await FirebaseFirestore.instance.collection('homeworks').get();
    return snapshot.docs.length;
  }
}
