import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mokrabela/firebase_options.dart';
import 'package:mokrabela/services/auth_gate.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
//import 'package:mokrabela/scripts/seed_test_story.dart';
//import 'package:mokrabela/scripts/seed_test_breathing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      if (!e.toString().contains('duplicate-app')) {
        rethrow;
      }
      // If duplicate, ignore and proceed
      debugPrint('Firebase already initialized: $e');
    }
  }
  // await addTestBreathingExercise();
  //await addTestStory();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'MokraBela',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          locale: _locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('fr'), Locale('ar')],
          home: AuthGate(
            onLanguageChange: _changeLanguage,
            currentLocale: _locale,
          ),
        );
      },
    );
  }
}
