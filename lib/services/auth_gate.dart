import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mokrabela/components/snackbars/custom_snackbar.dart';
import 'package:mokrabela/screens/child/child_dashboard.dart';
import 'package:mokrabela/screens/common/status_screens.dart';
import 'package:mokrabela/screens/onboarding/onboarding_flow.dart';
import 'package:mokrabela/screens/parent/parent_dashboard.dart';
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
        return RoleBasedRouter(userId: snapshot.data!.uid);
      },
    );
  }
}

class RoleBasedRouter extends StatefulWidget {
  final String userId;

  const RoleBasedRouter({super.key, required this.userId});

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
          // Ideally we should offer a way out if it persists, but for now LoadingScreen satisfies requirement
          // + the snackbar.
          return const LoadingScreen();
        }

        // Role-based navigation
        switch (role) {
          case 'child':
            return const ChildDashboard();
          case 'parent':
            return const ParentDashboard();
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
