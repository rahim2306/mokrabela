import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mokrabela/models/user_model.dart';
import 'package:mokrabela/screens/onboarding/auth/login.dart';
import 'package:mokrabela/screens/onboarding/auth/registration_screen.dart';
import 'package:mokrabela/screens/onboarding/role_selection_screen.dart';
import 'package:mokrabela/screens/onboarding/welcome_screen.dart';
import 'package:mokrabela/screens/onboarding/intro_screen.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:mokrabela/l10n/app_localizations.dart';

/// Onboarding flow controller managing all 3 screens
class OnboardingFlow extends StatefulWidget {
  final Function(Locale) onLanguageChanged;
  final Locale currentLocale;

  const OnboardingFlow({
    super.key,
    required this.onLanguageChanged,
    required this.currentLocale,
  });

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  final AuthService _authService = AuthService();

  UserRole? _selectedRole;
  bool _isLoading = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToLogin() async {
    // Use push (not pushReplacement) so LoginPage is modal
    // When login succeeds and user is authenticated,
    // LoginPage should pop itself, allowing AuthGate's StreamBuilder to react
    final result = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const LoginPage()));

    // If user clicked "Sign Up" from login, navigate to registration
    if (result == 'signup' && mounted) {
      _goToPage(3); // Navigate to registration screen (page 3 now)
    }
  }

  Future<void> _handleRegistration({
    required String firstName,
    required String familyName,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    setState(() {
      _isLoading = true;
    });

    try {
      String fullName = '$firstName $familyName';

      // Register user
      final user = await _authService.signUp(
        email: email,
        password: password,
        name: fullName.trim(),
        role: role,
      );

      if (user != null && mounted) {
        // Success - AuthGate will handle navigation
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.registrationSuccess),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        String message;
        switch (e.code) {
          case 'email-already-in-use':
            message = l10n.emailAlreadyInUse;
            break;
          case 'weak-password':
            message = l10n.weakPassword;
            break;
          case 'invalid-email':
            message = l10n.invalidEmail;
            break;
          default:
            message = l10n.registrationFailed;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.networkError),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        // Screen 0: Welcome
        WelcomeScreen(
          onGetStarted: () => _goToPage(1), // Go to intro 1
          onLogin: _goToLogin,
          onLanguageChanged: widget.onLanguageChanged,
          currentLocale: widget.currentLocale,
        ),
        // Screen 1: Combined Introduction (with internal slides)
        IntroScreen(
          onComplete: () => _goToPage(2), // Go to role selection
          onSkip: () => _goToPage(2), // Skip to role selection
          onBack: () => _goToPage(0), // Back to welcome
        ),
        // Screen 2: Role Selection
        RoleSelectionScreen(
          onBack: () => _goToPage(1), // Back to intro
          onNext: (role) {
            setState(() {
              _selectedRole = role;
            });
            _goToPage(3); // Go to registration
          },
          onLanguageChanged: widget.onLanguageChanged,
          currentLocale: widget.currentLocale,
          initialSelection: _selectedRole,
        ),
        // Screen 3: Registration
        RegistrationScreen(
          onBack: () => _goToPage(2), // Back to role selection
          onSubmit: _handleRegistration,
          onLanguageChanged: widget.onLanguageChanged,
          currentLocale: widget.currentLocale,
          selectedRole: _selectedRole ?? UserRole.parent,
          isLoading: _isLoading,
        ),
      ],
    );
  }
}
