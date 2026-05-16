import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/answer_key.dart';

class AnswerKeyRepository {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('answer_keys');

  static Future<AnswerKey?> getAnswerKeyForHomework(String homeworkId) async {
    final doc = await _collection.doc(homeworkId).get();
    if (!doc.exists) return null;
    return AnswerKey.fromMap(doc.data() as Map<String, dynamic>, homeworkId);
  }

  static Future<List<AnswerKey>> getAnswerKeysForGrade(String grade) async {
    final snapshot =
        await _collection.where('gradeLevel', isEqualTo: grade).get();
    return snapshot.docs
        .map((doc) => AnswerKey.fromMap(doc.data(), doc.id))
        .toList();
  }

  static Future<List<AnswerKey>> getAnswerKeysForSubject(
      String subjectId) async {
    final snapshot =
        await _collection.where('subjectId', isEqualTo: subjectId).get();
    return snapshot.docs
        .map((doc) => AnswerKey.fromMap(doc.data(), doc.id))
        .toList();
  }

  static Future<void> createAnswerKey(AnswerKey answerKey) async {
    await _collection.doc(answerKey.id).set(answerKey.toMap());
  }

  static Future<void> updateAnswerKey(
      String id, Map<String, dynamic> data) async {
    await _collection.doc(id).update(data);
  }
}
