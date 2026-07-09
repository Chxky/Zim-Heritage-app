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

  /// URL of the Firebase Cloud Function that proxies Gemini requests.
  /// When set, the client sends prompts here instead of calling Gemini directly.
  /// The Cloud Function holds the actual API key server-side.
  static String get geminiFunctionUrl {
    return dotenv.env['GEMINI_FUNCTION_URL'] ?? '';
  }

  static String get sentryDsn {
    return dotenv.env['SENTRY_DSN'] ?? '';
  }

  static String get appLocale {
    return dotenv.env['APP_LOCALE'] ?? 'en';
  }
}
