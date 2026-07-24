import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import 'app_config.dart';
import 'mock_data_service.dart';

class UserRepository {
  static Future<User?> getUserByUid(String uid) async {
    if (!AppConfig.useFirebase) return MockDataService.getUserByUid(uid);
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (!doc.exists) return MockDataService.getUserByUid(uid);
      return User.fromMap(doc.data() as Map<String, dynamic>, uid);
    } catch (_) {
      return MockDataService.getUserByUid(uid);
    }
  }

  static Stream<User?> streamUserByUid(String uid) {
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots().map((doc) {
      if (!doc.exists) return null;
      return User.fromMap(doc.data() as Map<String, dynamic>, uid);
    }).handleError((_) => null);
  }

  static Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    if (!AppConfig.useFirebase) {
      await MockDataService.updateUser(uid, data);
      return;
    }
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update(data);
    } catch (_) {
      await MockDataService.updateUser(uid, data);
    }
  }

  static Future<void> createUser(User user) async {
    if (!AppConfig.useFirebase) {
      await MockDataService.createUser(user);
      return;
    }
    try {
      await FirebaseFirestore.instance.collection('users').doc(user.id).set(user.toMap());
    } catch (_) {
      await MockDataService.createUser(user);
    }
  }

  static Future<List<User>> getAllUsers() async {
    if (!AppConfig.useFirebase) return MockDataService.getAllUsers();
    try {
      final snapshot = await FirebaseFirestore.instance.collection('users').get();
      if (snapshot.docs.isEmpty) return MockDataService.getAllUsers();
      return snapshot.docs
          .map((doc) => User.fromMap(doc.data(), doc.id))
          .toList();
    } catch (_) {
      return MockDataService.getAllUsers();
    }
  }

  static Future<List<User>> getUsersByRole(String role) async {
    if (!AppConfig.useFirebase) return MockDataService.getUsersByRole(role);
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users').where('role', isEqualTo: role).get();
      if (snapshot.docs.isEmpty) return MockDataService.getUsersByRole(role);
      return snapshot.docs
          .map((doc) => User.fromMap(doc.data(), doc.id))
          .toList();
    } catch (_) {
      return MockDataService.getUsersByRole(role);
    }
  }

  static Future<List<User>> getUsersByGrade(String gradeLevel) async {
    if (!AppConfig.useFirebase) return MockDataService.getUsersByGrade(gradeLevel);
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users').where('gradeLevel', isEqualTo: gradeLevel).get();
      if (snapshot.docs.isEmpty) return MockDataService.getUsersByGrade(gradeLevel);
      return snapshot.docs
          .map((doc) => User.fromMap(doc.data(), doc.id))
          .toList();
    } catch (_) {
      return MockDataService.getUsersByGrade(gradeLevel);
    }
  }

  static Future<int> getUserCount() async {
    if (!AppConfig.useFirebase) return MockDataService.getUserCount();
    try {
      final snapshot = await FirebaseFirestore.instance.collection('users').get();
      return snapshot.docs.length;
    } catch (_) {
      return MockDataService.getUserCount();
    }
  }
}
