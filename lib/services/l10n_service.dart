import 'package:flutter/material.dart';

class L10nService {
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('sn'),
    Locale('nd'),
  ];

  static const Locale fallbackLocale = Locale('en');

  static const Map<String, String> localeNames = {
    'en': 'English',
    'sn': 'chiShona',
    'nd': 'isiNdebele',
  };

  static String getString(BuildContext context, String key, {Map<String, String>? params}) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)?.translate(key, params) ?? key;
  }

  static bool isRtl(Locale locale) => false;
}

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  String translate(String key, [Map<String, String>? params]) {
    final translations = _translations[locale.languageCode] ?? _translations['en']!;
    var text = translations[key] ?? key;
    if (params != null) {
      for (final entry in params.entries) {
        text = text.replaceAll('{$entry}', entry.value);
      }
    }
    return text;
  }

  static const Map<String, Map<String, String>> _translations = {
    'en': {
      'appTitle': 'ZimHeritage',
      'signIn': 'Sign In',
      'logout': 'Logout',
      'loading': 'Loading...',
      'errorOccurred': 'An error occurred',
      'tryAgain': 'Try Again',
      'noData': 'No data available',
      'offlineMode': 'Offline Mode',
      'onlineMode': 'Online Mode',
    },
    'sn': {
      'appTitle': 'ZimHeritage',
      'signIn': 'Pinda',
      'logout': 'Buditsa',
      'loading': 'Kurodha...',
      'errorOccurred': 'Pane chakakanganisika',
      'tryAgain': 'Edza Zvakare',
      'noData': 'Hapana data',
      'offlineMode': 'Offline Mode',
      'onlineMode': 'Online Mode',
    },
    'nd': {
      'appTitle': 'ZimHeritage',
      'signIn': 'Ngena',
      'logout': 'Phuma',
      'loading': 'Iyalayisha...',
      'errorOccurred': 'Kuvele iphutha',
      'tryAgain': 'Zama futhi',
      'noData': 'Akukho data',
      'offlineMode': 'Imodi engekho online',
      'onlineMode': 'Imodi eku-inthanethi',
    },
  };
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'sn', 'nd'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);

  @override
  bool shouldReload(covariant _AppLocalizationsDelegate old) => false;
}
