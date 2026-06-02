import 'package:sentry_flutter/sentry_flutter.dart';
import 'env_config.dart';

class SentryService {
  static Future<void> init() async {
    final dsn = EnvConfig.sentryDsn;
    if (dsn.isEmpty) return;
    await SentryFlutter.init(
      (options) {
        options.dsn = dsn;
        options.tracesSampleRate = 0.2;
      },
    );
  }

  static void captureError(Object exception, StackTrace stack, {String? hint}) {
    Sentry.captureException(exception, stackTrace: stack, hint: hint != null ? Hint.withMap({'hint': hint}) : null);
  }

  static void captureMessage(String message) {
    Sentry.captureMessage(message);
  }

  static void setUserContext(String id, String email, String? role) {
    Sentry.configureScope((scope) {
      scope.setUser(SentryUser(id: id, email: email, data: {'role': role ?? ''}));
    });
  }

  static void clearUserContext() {
    Sentry.configureScope((scope) {
      scope.setUser(null);
    });
  }
}
