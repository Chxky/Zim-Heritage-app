import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_config.dart';
import 'mock_data_service.dart';
import '../models/user.dart';

class UserRepository {
  static Future<User?> getUserByUid(String uid) async {
    if (!AppConfig.useFirebase) return MockDataService.getUserByUid(uid);
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return User.fromMap(doc.data() as Map<String, dynamic>, uid);
  }

  static Stream<User?> streamUserByUid(String uid) {
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots().map((doc) {
      if (!doc.exists) return null;
      return User.fromMap(doc.data() as Map<String, dynamic>, uid);
    });
  }

  static Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    if (!AppConfig.useFirebase) {
      await MockDataService.updateUser(uid, data);
      return;
    }
    await FirebaseFirestore.instance.collection('users').doc(uid).update(data);
  }

  static Future<void> createUser(User user) async {
    if (!AppConfig.useFirebase) {
      await MockDataService.createUser(user);
      return;
    }
    await FirebaseFirestore.instance.collection('users').doc(user.id).set(user.toMap());
  }

  static Future<List<User>> getAllUsers() async {
    if (!AppConfig.useFirebase) return MockDataService.getAllUsers();
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    return snapshot.docs
        .map((doc) => User.fromMap(doc.data(), doc.id))
        .toList();
  }

  static Future<List<User>> getUsersByRole(String role) async {
    if (!AppConfig.useFirebase) return MockDataService.getUsersByRole(role);
    final snapshot = await FirebaseFirestore.instance
        .collection('users').where('role', isEqualTo: role).get();
    return snapshot.docs
        .map((doc) => User.fromMap(doc.data(), doc.id))
        .toList();
  }

  static Future<List<User>> getUsersByGrade(String gradeLevel) async {
    if (!AppConfig.useFirebase) return MockDataService.getUsersByGrade(gradeLevel);
    final snapshot = await FirebaseFirestore.instance
        .collection('users').where('gradeLevel', isEqualTo: gradeLevel).get();
    return snapshot.docs
        .map((doc) => User.fromMap(doc.data(), doc.id))
        .toList();
  }

  static Future<int> getUserCount() async {
    if (!AppConfig.useFirebase) return MockDataService.getUserCount();
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    return snapshot.docs.length;
  }
}
