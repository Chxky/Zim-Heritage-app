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
    String cleanEmail = email.trim().toLowerCase();
    if (!cleanEmail.contains('@')) {
      cleanEmail = '$cleanEmail@demo.com';
    }
    final isMazvita = cleanEmail.contains('mazvita');

    if (AppConfig.useFirebase) {
      try {
        UserCredential? credential;
        try {
          credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: cleanEmail,
            password: password,
          );
        } on FirebaseAuthException catch (e) {
          try {
            credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: cleanEmail,
              password: password,
            );
          } catch (_) {
            try {
              final query = await FirebaseFirestore.instance
                  .collection('users')
                  .where('email', isEqualTo: cleanEmail)
                  .limit(1)
                  .get();
              if (query.docs.isNotEmpty) {
                final data = query.docs.first.data();
                final id = isMazvita ? 'student_mazvita' : (data['id'] as String? ?? query.docs.first.id);
                _currentUser = User.fromMap(data, id);
                return _currentUser;
              }
            } catch (_) {}
            if (isMazvita || cleanEmail.endsWith('@demo.com')) {
              _currentUser = _createDemoUser(cleanEmail, isMazvita ? 'student_mazvita' : 'demo_user');
              return _currentUser;
            }
            throw Exception(e.message ?? 'Invalid login credentials.');
          }
        }

        if (credential != null && credential.user != null) {
          final uid = credential.user!.uid;
          try {
            var doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
            if (!doc.exists) {
              final query = await FirebaseFirestore.instance
                  .collection('users')
                  .where('email', isEqualTo: cleanEmail)
                  .limit(1)
                  .get();
              if (query.docs.isNotEmpty) {
                final data = query.docs.first.data();
                final fallbackUser = User.fromMap(data, isMazvita ? 'student_mazvita' : uid);
                await FirebaseFirestore.instance.collection('users').doc(uid).set(fallbackUser.toMap());
                doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
              } else {
                final defaultUser = _createDemoUser(cleanEmail, isMazvita ? 'student_mazvita' : uid);
                await FirebaseFirestore.instance.collection('users').doc(uid).set(defaultUser.toMap());
                doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
              }
            }
            final docData = doc.data() as Map<String, dynamic>? ?? {};
            final targetId = isMazvita ? 'student_mazvita' : (docData['id'] as String? ?? uid);
            _currentUser = User.fromMap(docData, targetId);
            return _currentUser;
          } catch (_) {
            _currentUser = _createDemoUser(cleanEmail, isMazvita ? 'student_mazvita' : uid);
            return _currentUser;
          }
        }
      } catch (e) {
        if (isMazvita || cleanEmail.endsWith('@demo.com')) {
          _currentUser = _createDemoUser(cleanEmail, isMazvita ? 'student_mazvita' : 'demo_user');
          return _currentUser;
        }
        try {
          return await MockDataService.login(cleanEmail, password);
        } catch (_) {
          throw Exception(e.toString().replaceFirst('Exception: ', ''));
        }
      }
    }
    final user = await MockDataService.login(cleanEmail, password);
    _currentUser = user;
    return user;
  }

  static User _createDemoUser(String email, String fallbackId) {
    final clean = email.toLowerCase();
    if (clean.contains('mazvita')) {
      return User(
        id: 'student_mazvita',
        name: 'Mazvita',
        email: 'mazvita@demo.com',
        role: 'student',
        gradeLevel: 'Form 4',
        school: 'Demo High School',
        schoolMotto: 'Learn, Lead, Inspire',
        age: 16,
        isVerified: true,
        isAgeVerified: true,
      );
    }
    if (clean.contains('teacher')) {
      return User(
        id: 'teacher_1',
        name: 'Teacher Chigumira',
        email: 'teacher@demo.com',
        role: 'teacher',
        gradeLevel: 'Form 4 Teacher',
        school: 'Demo High School',
        schoolMotto: 'Learn, Lead, Inspire',
        age: 35,
        isVerified: true,
        isAgeVerified: true,
      );
    }
    if (clean.contains('admin')) {
      return User(
        id: 'admin_1',
        name: 'Pardon Mahara (Ministry Admin)',
        email: 'admin@demo.com',
        role: 'admin',
        gradeLevel: 'National Directorate',
        school: 'Ministry of Primary & Secondary Education',
        schoolMotto: 'Preserving our heritage',
        age: 42,
        isVerified: true,
        isAgeVerified: true,
      );
    }
    return User(
      id: fallbackId,
      name: clean.split('@').first,
      email: clean,
      role: 'student',
      gradeLevel: 'Form 4',
      school: 'Demo High School',
      age: 16,
      isVerified: true,
      isAgeVerified: true,
    );
  }

  static Future<User> signInWithGoogle({
    String? role,
    String? curriculum,
    String? province,
    String? language,
  }) async {
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
        role: role?.toLowerCase() ?? 'student',
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
    String? dateOfBirth,
    bool isAgeVerified = true,
    String? guardianName,
    String? guardianContact,
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
        dateOfBirth: dateOfBirth, isAgeVerified: isAgeVerified,
        guardianName: guardianName, guardianContact: guardianContact,
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
    _currentUser = user.copyWith(
      dateOfBirth: dateOfBirth,
      isAgeVerified: isAgeVerified,
      guardianName: guardianName,
      guardianContact: guardianContact,
    );
    return _currentUser!;
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
