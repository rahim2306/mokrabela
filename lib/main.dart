import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mokrabela/firebase_options.dart';
import 'package:mokrabela/services/auth_gate.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
          home: LanguageSwitcherWrapper(
            onLanguageChange: _changeLanguage,
            child: const AuthGate(),
          ),
        );
      },
    );
  }
}

class LanguageSwitcherWrapper extends StatelessWidget {
  final Function(Locale) onLanguageChange;
  final Widget child;

  const LanguageSwitcherWrapper({
    super.key,
    required this.onLanguageChange,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            tooltip: AppLocalizations.of(context)!.languageSelector,
            onSelected: onLanguageChange,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: const Locale('en'),
                child: Row(
                  children: [
                    const Text('🇬🇧'),
                    const SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.english),
                  ],
                ),
              ),
              PopupMenuItem(
                value: const Locale('fr'),
                child: Row(
                  children: [
                    const Text('🇫🇷'),
                    const SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.french),
                  ],
                ),
              ),
              PopupMenuItem(
                value: const Locale('ar'),
                child: Row(
                  children: [
                    const Text('🇸🇦'),
                    const SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.arabic),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: child,
    );
  }
}
