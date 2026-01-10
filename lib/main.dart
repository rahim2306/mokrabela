import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mokrabela/firebase_options.dart';
import 'package:mokrabela/screens/auth/login.dart';
import 'package:mokrabela/theme/adhd_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MokraBela',
      debugShowCheckedModeBanner: false,
      theme: ADHDKidsTheme.lightTheme,
      home: LoginPage(),
    );
  }
}
