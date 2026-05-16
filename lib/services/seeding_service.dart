import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'env_config.dart';
import '../models/user.dart';
import '../data/sample_data.dart';

class SeedingService {
  static Future<void> seedAllIfNeeded() async {
    if (!EnvConfig.useFirebase) return;

    final needsUsers = await _collectionEmpty('users');
    final needsHomeworks = await _collectionEmpty('homeworks');
    final needsSubmissions = await _collectionEmpty('submissions');
    final needsProgress = await _collectionEmpty('progress');

    if (needsUsers) await _seedDemoUsers();
    if (needsHomeworks) await _seedHomeworks();
    if (needsSubmissions) await _seedSubmissions();
    if (needsProgress) await _seedProgress();
  }

  static Future<bool> _collectionEmpty(String collection) async {
    final snapshot = await FirebaseFirestore.instance.collection(collection).limit(1).get();
    return snapshot.docs.isEmpty;
  }

  static Future<void> _seedDemoUsers() async {
    final users = <User>[
      User(id: 'student_1', name: 'Tendai Musoni', email: 'student@demo.com', role: 'student', gradeLevel: 'Form 1', school: 'Demo High School', age: 14, isVerified: true),
      User(id: 'teacher_1', name: 'Teacher Chigumira', email: 'teacher@demo.com', role: 'teacher', gradeLevel: 'N/A', school: 'Demo High School', age: 35, isVerified: true),
      User(id: 'parent_1', name: 'Amai Moyo', email: 'parent@demo.com', role: 'parent', gradeLevel: 'N/A', school: 'Demo High School', age: 40, isVerified: true),
      User(id: 'admin_1', name: 'Pardon Mahara', email: 'admin@demo.com', role: 'admin', gradeLevel: 'N/A', school: 'ZimHeritage Education', age: 30, isVerified: true),
    ];

    for (final user in users) {
      await FirebaseFirestore.instance.collection('users').doc(user.id).set(user.toMap());
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email,
          password: '123456',
        );
      } catch (_) {}
    }
  }

  static Future<void> _seedHomeworks() async {
    for (final hw in SampleData.homeworkAssignments) {
      await FirebaseFirestore.instance.collection('homeworks').doc(hw.id).set(hw.toMap());
    }
  }

  static Future<void> _seedSubmissions() async {
    for (final sub in SampleData.sampleSubmissions) {
      await FirebaseFirestore.instance.collection('submissions').doc(sub.id).set(sub.toMap());
    }
  }

  static Future<void> _seedProgress() async {
    for (final prog in SampleData.sampleProgress) {
      final id = '${prog.studentId}_${prog.subjectId}';
      await FirebaseFirestore.instance.collection('progress').doc(id).set(prog.toMap());
    }
  }

  static Future<bool> needsSeeding() async {
    return _collectionEmpty('users');
  }
}
