// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'موكرابيلا';

  @override
  String get welcome => 'مرحبا';

  @override
  String hello(String name) {
    return 'مرحبا، $name!';
  }

  @override
  String get languageSelector => 'اختر اللغة';

  @override
  String get english => 'الإنجليزية';

  @override
  String get french => 'الفرنسية';

  @override
  String get arabic => 'العربية';

  @override
  String get changeLanguage => 'تغيير اللغة';

  @override
  String currentLanguage(String language) {
    return 'اللغة الحالية: $language';
  }
}
