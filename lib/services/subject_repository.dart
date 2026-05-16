import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/subject.dart';

class SubjectRepository {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('subjects');

  static Future<List<Subject>> getSubjectsByGrade(String gradeLevel) async {
    final snapshot =
        await _collection.where('gradeLevel', isEqualTo: gradeLevel).get();
    return snapshot.docs
        .map((doc) => Subject.fromMap(doc.data(), doc.id))
        .toList();
  }

  static Stream<List<Subject>> streamSubjectsByGrade(String gradeLevel) {
    return _collection
        .where('gradeLevel', isEqualTo: gradeLevel)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Subject.fromMap(doc.data(), doc.id))
            .toList());
  }

  static Future<List<Subject>> getAllSubjects() async {
    final snapshot = await _collection.get();
    return snapshot.docs
        .map((doc) => Subject.fromMap(doc.data(), doc.id))
        .toList();
  }

  static Future<Subject?> getSubjectById(String subjectId) async {
    final doc = await _collection.doc(subjectId).get();
    if (!doc.exists) return null;
    return Subject.fromMap(doc.data() as Map<String, dynamic>, subjectId);
  }

  static Future<void> createSubject(Subject subject) async {
    await _collection.doc(subject.id).set(subject.toMap());
  }

  static Future<void> updateSubject(String id, Map<String, dynamic> data) async {
    await _collection.doc(id).update(data);
  }

  static Future<void> deleteSubject(String id) async {
    await _collection.doc(id).delete();
  }

  static Future<List<Topic>> getTopicsForSubject(
      String subjectId, String gradeLevel) async {
    final snapshot = await _collection
        .doc(subjectId)
        .collection('topics')
        .where('gradeLevel', isEqualTo: gradeLevel)
        .get();
    return snapshot.docs
        .map((doc) => Topic.fromMap(doc.data(), doc.id))
        .toList();
  }

  static Stream<List<Topic>> streamTopicsForSubject(
      String subjectId, String gradeLevel) {
    return _collection
        .doc(subjectId)
        .collection('topics')
        .where('gradeLevel', isEqualTo: gradeLevel)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Topic.fromMap(doc.data(), doc.id))
            .toList());
  }
}
