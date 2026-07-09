import 'package:cloud_firestore/cloud_firestore.dart';

import 'app_config.dart';
import 'auth_service.dart';

class AnalyticsTracker {
  static Future<void> trackPageView(String screenName) async {
    if (!AppConfig.useFirebase) return;
    try {
      await FirebaseFirestore.instance.collection('analytics').add({
        'type': 'page_view',
        'screen': screenName,
        'userId': AuthService.currentUser?.id ?? '',
        'role': AuthService.currentUser?.role ?? '',
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (_) {}
  }

  static Future<void> trackEvent(String event, {Map<String, dynamic>? properties}) async {
    if (!AppConfig.useFirebase) return;
    try {
      await FirebaseFirestore.instance.collection('analytics').add({
        'type': 'event',
        'event': event,
        'properties': properties ?? {},
        'userId': AuthService.currentUser?.id ?? '',
        'role': AuthService.currentUser?.role ?? '',
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (_) {}
  }
}
