import 'package:cloud_firestore/cloud_firestore.dart';

import 'app_config.dart';
import 'auth_service.dart';

class FeedbackService {
  static Future<void> submit({
    required String type,
    required String message,
    String? screen,
    String? email,
  }) async {
    if (!AppConfig.useFirebase) return;

    try {
      await FirebaseFirestore.instance.collection('feedback').add({
        'type': type,
        'message': message,
        'screen': screen ?? '',
        'email': email ?? AuthService.currentUser?.email ?? '',
        'userId': AuthService.currentUser?.id ?? '',
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'new',
      });
    } catch (_) {}
  }
}
