import 'package:firebase_messaging/firebase_messaging.dart';
import 'app_config.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static String? _deviceToken;

  static Future<String?> get deviceToken async {
    _deviceToken ??= await _messaging.getToken();
    return _deviceToken;
  }

  static Future<void> init() async {
    if (!AppConfig.useFirebase) return;

    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) return;

    _deviceToken = await _messaging.getToken();

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }
  }

  static void _handleForegroundMessage(RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {}
  }

  static void _handleNotificationTap(RemoteMessage message) {
    final data = message.data;
    final route = data['route'] as String?;
    if (route != null) {}
  }

  static Future<void> subscribeToTopic(String topic) async {
    if (!AppConfig.useFirebase) return;
    await _messaging.subscribeToTopic(topic);
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    if (!AppConfig.useFirebase) return;
    await _messaging.unsubscribeFromTopic(topic);
  }
}
