import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/subject.dart';

class CurriculumRepository {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('curriculum');

  static Future<List<Subject>> getFullCurriculumForGrade(
      String gradeLevel) async {
    final doc = await _collection.doc(gradeLevel).get();
    if (!doc.exists) return [];
    final data = doc.data() as Map<String, dynamic>;
    final subjects = data['subjects'] as List<dynamic>? ?? [];
    return subjects.asMap().entries.map((entry) {
      final s = entry.value as Map<String, dynamic>;
      return Subject(
        id: '${gradeLevel}_${entry.key}',
        name: s['name'] as String? ?? '',
        description: s['description'] as String? ?? '',
        gradeLevel: gradeLevel,
        color: s['color'] as String? ?? '0xFF4CAF50',
        icon: s['icon'] as String? ?? 'book',
      );
    }).toList();
  }

  static Future<List<String>> getGradeLevels() async {
    final snapshot = await _collection.get();
    return snapshot.docs.map((doc) => doc.id).toList();
  }

  static Future<void> updateCurriculum(
      String gradeLevel, Map<String, dynamic> data) async {
    await _collection.doc(gradeLevel).set(data, SetOptions(merge: true));
  }
}
