import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static Future<void> load() async {
    try {
      await dotenv.load(fileName: '.env');
    } catch (_) {
      try {
        await dotenv.load(fileName: '.env.example');
      } catch (_) {}
    }
  }

  static bool get useFirebase {
    return dotenv.env['USE_FIREBASE']?.toLowerCase() == 'true';
  }

  static String get geminiApiKey {
    return dotenv.env['GEMINI_API_KEY'] ?? '';
  }

  static String get sentryDsn {
    return dotenv.env['SENTRY_DSN'] ?? '';
  }

  static String get appLocale {
    return dotenv.env['APP_LOCALE'] ?? 'en';
  }
}
