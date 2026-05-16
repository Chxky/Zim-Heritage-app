import 'env_config.dart';

class AppConfig {
  /// Whether to use Firebase (real backend) or mock data (offline mode).
  /// Controlled by USE_FIREBASE in .env
  static bool get useFirebase => EnvConfig.useFirebase;
}
