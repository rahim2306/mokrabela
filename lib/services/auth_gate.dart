import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mokrabela/components/snackbars/custom_snackbar.dart';
import 'package:mokrabela/screens/child/kids_main_scaffold.dart';
import 'package:mokrabela/screens/common/status_screens.dart';
import 'package:mokrabela/screens/onboarding/onboarding_flow.dart';
import 'package:mokrabela/screens/parent/parent_main_scaffold.dart';
import 'package:mokrabela/screens/teacher/teacher_dashboard.dart';

class AuthGate extends StatelessWidget {
  final Function(Locale) onLanguageChange;
  final Locale currentLocale;

  const AuthGate({
    super.key,
    required this.onLanguageChange,
    required this.currentLocale,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        }

        // Not authenticated - show onboarding flow
        if (!snapshot.hasData) {
          return OnboardingFlow(
            onLanguageChanged: onLanguageChange,
            currentLocale: currentLocale,
          );
        }

        // Authenticated - check role
        return RoleBasedRouter(
          userId: snapshot.data!.uid,
          onLanguageChange: onLanguageChange,
          currentLocale: currentLocale,
        );
      },
    );
  }
}

class RoleBasedRouter extends StatefulWidget {
  final String userId;
  final Function(Locale) onLanguageChange;
  final Locale currentLocale;

  const RoleBasedRouter({
    super.key,
    required this.userId,
    required this.onLanguageChange,
    required this.currentLocale,
  });

  @override
  State<RoleBasedRouter> createState() => _RoleBasedRouterState();
}

class _RoleBasedRouterState extends State<RoleBasedRouter> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId) // Access userId via widget
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoadingScreen();
        }

        if (snapshot.hasError) {
          // Show error in snackbar but return a safe screen to avoid crash
          // We use addPostFrameCallback to show snackbar after build
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CustomSnackbar.show(
              context,
              message: 'Error: ${snapshot.error}',
              isError: true,
            );
          });
          // Return loading screen or a simple scaffold as fallback
          return const LoadingScreen();
        }

        final data = snapshot.data!.data() as Map<String, dynamic>?;
        if (data == null) {
          return const LoadingScreen();
        }

        // Check for language sync
        if (data.containsKey('appSettings')) {
          final appSettings = data['appSettings'] as Map<String, dynamic>;
          if (appSettings.containsKey('languageCode')) {
            final savedLang = appSettings['languageCode'] as String;
            if (savedLang.isNotEmpty &&
                savedLang != widget.currentLocale.languageCode) {
              // Schedule update to avoid build conflicts
              WidgetsBinding.instance.addPostFrameCallback((_) {
                widget.onLanguageChange(Locale(savedLang));
              });
            }
          }
        }

        // Fix: Read role directly from root, not 'profile' map
        final role = data['role'] as String?;
        if (role == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CustomSnackbar.show(
              context,
              message: 'User role not assigned',
              isError: true,
            );
          });
          // Show loading screen while waiting or stuck
          return const LoadingScreen();
        }

        // Role-based navigation
        switch (role) {
          case 'child':
            return KidsMainScaffold(
              onLanguageChange: widget.onLanguageChange,
              currentLocale: widget.currentLocale,
            );
          case 'parent':
            return const ParentMainScaffold();
          case 'teacher':
            return const TeacherDashboard();
          default:
            WidgetsBinding.instance.addPostFrameCallback((_) {
              CustomSnackbar.show(
                context,
                message: 'Invalid role detected: $role',
                isError: true,
              );
            });
            return const LoadingScreen();
        }
      },
    );
  }
}
