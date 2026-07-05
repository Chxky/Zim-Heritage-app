import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user.dart';
import 'app_config.dart';
import 'mock_data_service.dart';

class AuthService {
  static User? _currentUser;
  static User? get currentUser => _currentUser;

  static Future<User?> login(String email, String password) async {
    if (AppConfig.useFirebase) {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final uid = credential.user!.uid;
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (!doc.exists) {
        await FirebaseAuth.instance.signOut();
        throw Exception('User profile not found. Contact admin.');
      }
      _currentUser = User.fromMap(doc.data() as Map<String, dynamic>, uid);
      return _currentUser;
    }
    final user = await MockDataService.login(email, password);
    _currentUser = user;
    return user;
  }

  static Future<User> signInWithGoogle() async {
    if (AppConfig.useFirebase) {
      UserCredential userCredential;
      String email;
      String displayName;

      try {
        userCredential = await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
        final fbUser = userCredential.user!;
        email = fbUser.email ?? '';
        displayName = fbUser.displayName ?? email.split('@').first;
      } catch (_) {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) throw Exception('Google sign-in cancelled.');
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        email = googleUser.email;
        displayName = googleUser.displayName ?? email.split('@').first;
      }

      final uid = userCredential.user!.uid;
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        _currentUser = User.fromMap(doc.data() as Map<String, dynamic>, uid);
        return _currentUser!;
      }

      final newUser = User(
        id: uid,
        name: displayName,
        email: email,
        role: 'parent',
        gradeLevel: 'N/A',
        school: '',
        isVerified: true,
        authProvider: 'google',
      );
      await FirebaseFirestore.instance.collection('users').doc(uid).set(newUser.toMap());
      _currentUser = newUser;
      return newUser;
    }
    final user = await MockDataService.signInWithGoogle();
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
    if (AppConfig.useFirebase) {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final uid = credential.user!.uid;
      final user = User(
        id: uid, name: name, email: email.trim(), role: role,
        gradeLevel: gradeLevel, school: school, age: age,
        isVerified: true, hasFacialRecognition: hasFacialRecognition,
        curriculum: curriculum,
        schoolMotto: schoolMotto,
      );
      await FirebaseFirestore.instance.collection('users').doc(uid).set(user.toMap());
      _currentUser = user;
      return user;
    }
    final user = await MockDataService.register(
      name: name, email: email, password: password, role: role,
      gradeLevel: gradeLevel, school: school, age: age,
      hasFacialRecognition: hasFacialRecognition,
      curriculum: curriculum,
      schoolMotto: schoolMotto,
    );
    _currentUser = user;
    return user;
  }

  static Future<void> logout() async {
    if (AppConfig.useFirebase) {
      try { await GoogleSignIn().signOut(); } catch (_) {}
      await FirebaseAuth.instance.signOut();
    } else {
      await MockDataService.logout();
    }
    _currentUser = null;
  }

  static Future<User?> getCurrentUserFromSession() async {
    if (!AppConfig.useFirebase) return MockDataService.getCurrentUserFromSession();
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) return null;
    final doc = await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).get();
    if (!doc.exists) return null;
    _currentUser = User.fromMap(doc.data() as Map<String, dynamic>, firebaseUser.uid);
    return _currentUser;
  }

  static Future<User> refreshUser() async {
    if (!AppConfig.useFirebase) return MockDataService.refreshUser();
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) throw Exception('Not logged in');
    final doc = await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).get();
    if (!doc.exists) throw Exception('User profile not found');
    _currentUser = User.fromMap(doc.data() as Map<String, dynamic>, firebaseUser.uid);
    return _currentUser!;
  }

  static bool get isLoggedIn => AppConfig.useFirebase
      ? FirebaseAuth.instance.currentUser != null
      : MockDataService.isLoggedIn;

  static Future<void> sendPasswordReset(String email) async {
    if (!AppConfig.useFirebase) {
      await MockDataService.sendPasswordReset(email);
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found': message = 'No account found for this email.'; break;
        case 'invalid-email': message = 'Invalid email address.'; break;
        default: message = 'Failed to send reset email: ${e.message}';
      }
      throw Exception(message);
    }
  }
}
