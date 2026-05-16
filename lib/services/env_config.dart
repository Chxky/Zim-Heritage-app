import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static Future<void> load() async {
    await dotenv.load(fileName: '.env');
  }

  static bool get useFirebase {
    return dotenv.env['USE_FIREBASE']?.toLowerCase() == 'true';
  }

  static String get geminiApiKey {
    return dotenv.env['GEMINI_API_KEY'] ?? '';
  }
}
