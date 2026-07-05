import 'package:flutter_test/flutter_test.dart';
import 'package:zim_heritage_app/models/user.dart';
import 'package:zim_heritage_app/services/deep_link_service.dart';
import 'package:zim_heritage_app/services/l10n_service.dart';
import 'package:zim_heritage_app/services/security_service.dart';
import 'package:zim_heritage_app/theme/app_theme.dart';

void main() {
  group('SecurityService', () {
    test('sanitizeInput escapes HTML special chars in correct order', () {
      expect(SecurityService.sanitizeInput('<script>alert("xss")</script>'),
          '&lt;script&gt;alert(&quot;xss&quot;)&lt;/script&gt;');
    });

    test('sanitizeInput trims whitespace', () {
      expect(SecurityService.sanitizeInput('  hello  '), 'hello');
    });

    test('sanitizeInput handles mixed content', () {
      expect(SecurityService.sanitizeInput("it's <b>nice</b> & good"),
          'it&#x27;s &lt;b&gt;nice&lt;/b&gt; &amp; good');
    });

    test('isValidEmail validates email formats', () {
      expect(SecurityService.isValidEmail('user@example.com'), true);
      expect(SecurityService.isValidEmail('invalid-email'), false);
      expect(SecurityService.isValidEmail(''), false);
      expect(SecurityService.isValidEmail('user@'), false);
    });

    test('isValidPassword checks minimum length', () {
      expect(SecurityService.isValidPassword('123456'), true);
      expect(SecurityService.isValidPassword('12345'), false);
      expect(SecurityService.isValidPassword(''), false);
    });

    test('isValidName validates names', () {
      expect(SecurityService.isValidName('John Moyo'), true);
      expect(SecurityService.isValidName('A'), false);
      expect(SecurityService.isValidName(''), false);
    });

    test('sanitizeFilename removes illegal chars', () {
      expect(SecurityService.sanitizeFilename('file<>.txt'), 'file__.txt');
    });
  });

  group('DeepLinkService', () {
    test('resolveRoute returns correct routes', () {
      expect(DeepLinkService.resolveRoute('dashboard'), '/dashboard');
      expect(DeepLinkService.resolveRoute('login'), '/login');
      expect(DeepLinkService.resolveRoute('leaderboard'), '/leaderboard');
      expect(DeepLinkService.resolveRoute('unknown'), null);
    });

    test('parseQueryParams handles empty strings', () {
      expect(DeepLinkService.parseQueryParams(null), {});
      expect(DeepLinkService.parseQueryParams(''), {});
    });

    test('parseQueryParams parses key-value pairs', () {
      final result = DeepLinkService.parseQueryParams('name=John&grade=Form+1');
      expect(result['name'], 'John');
      expect(result['grade'], 'Form 1');
    });
  });

  group('L10nService', () {
    test('supportedLocales contains en, sn, nd', () {
      expect(L10nService.supportedLocales.length, 3);
      expect(L10nService.supportedLocales.map((l) => l.languageCode), containsAll(['en', 'sn', 'nd']));
    });

    test('localeNames contains all locales', () {
      expect(L10nService.localeNames['en'], 'English');
      expect(L10nService.localeNames['sn'], 'chiShona');
      expect(L10nService.localeNames['nd'], 'isiNdebele');
    });
  });

  group('AppTheme', () {
    test('has required color constants', () {
      expect(AppTheme.primaryGreen, isNotNull);
      expect(AppTheme.gold, isNotNull);
      expect(AppTheme.surfaceDark, isNotNull);
      expect(AppTheme.red, isNotNull);
      expect(AppTheme.white, isNotNull);
      expect(AppTheme.greenBright, isNotNull);
    });

    test('gold color has correct hex value', () {
      expect(AppTheme.gold.toARGB32(), 0xFFFFC72C);
    });
  });

  group('User Model', () {
    test('fromMap creates valid user', () {
      final map = {
        'name': 'Test Student',
        'email': 'test@example.com',
        'role': 'student',
        'gradeLevel': 'Form 1',
        'school': 'Test School',
      };
      final user = User.fromMap(map, 'user_1');
      expect(user.name, 'Test Student');
      expect(user.email, 'test@example.com');
      expect(user.role, 'student');
      expect(user.gradeLevel, 'Form 1');
      expect(user.id, 'user_1');
    });

    test('fromMap uses defaults for missing fields', () {
      final user = User.fromMap({}, 'user_2');
      expect(user.name, '');
      expect(user.role, 'student');
      expect(user.curriculum, 'zimsec');
      expect(user.age, 0);
    });

    test('toMap produces correct fields', () {
      final user = User(
        id: 'user_1',
        name: 'Test',
        email: 'test@test.com',
        role: 'teacher',
        gradeLevel: 'N/A',
        school: 'School',
      );
      final map = user.toMap();
      expect(map['name'], 'Test');
      expect(map['role'], 'teacher');
      expect(map['authProvider'], 'email');
      expect(map['curriculum'], 'zimsec');
    });

    test('copyWith overrides specified fields', () {
      final user = User(
        id: 'u1', name: 'Old', email: 'old@test.com',
        role: 'student', gradeLevel: 'Grade 7', school: 'School',
      );
      final updated = user.copyWith(name: 'New', email: 'new@test.com');
      expect(updated.name, 'New');
      expect(updated.email, 'new@test.com');
      expect(updated.role, 'student');
      expect(updated.id, 'u1');
    });
  });
}
