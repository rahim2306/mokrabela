import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/user_model.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:mokrabela/components/inputfields/custom_text_form_field.dart';
import 'package:mokrabela/components/buttons/custom_auth_button.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        UserModel? user = await _authService.signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (user != null && mounted) {
          // Login successful! Pop this screen
          // AuthGate's StreamBuilder will detect auth state change
          // and automatically show the authenticated dashboard
          Navigator.of(context).pop();
        } else if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login failed. User not found.')),
          );
        }
      } catch (e) {
        if (mounted) {
          String errorMessage = 'Login failed. Please try again.';

          if (e is FirebaseAuthException) {
            switch (e.code) {
              case 'user-not-found':
                errorMessage = 'No account found with this email.';
                break;
              case 'wrong-password':
                errorMessage = 'Incorrect password. Please try again.';
                break;
              case 'invalid-email':
                errorMessage = 'Invalid email address.';
                break;
              case 'user-disabled':
                errorMessage = 'This account has been disabled.';
                break;
              case 'too-many-requests':
                errorMessage = 'Too many attempts. Please try again later.';
                break;
              default:
                errorMessage = 'Login error: ${e.message}';
            }
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE8F5F3), // Soft teal/mint
              Color(0xFFF5F0FF), // Soft lavender
              Color(0xFFFFE8F5), // Soft pink
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Back button
              Padding(
                padding: EdgeInsets.all(1.h),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: const Color(0xFF2C5F7C),
                      size: 24.sp,
                    ),
                    onPressed: () {
                      // Simple pop since LoginPage is now a modal route
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight:
                          MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).padding.bottom -
                          60, // Approximate back button height
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Form card
                          Container(
                            padding: EdgeInsets.all(3.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    l10n.welcomeBack,
                                    style: TextStyle(
                                      fontSize: 26.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF1E4D5C),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 1.h),
                                  Text(
                                    l10n.loginSubtitle,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: const Color(0xFF1E4D5C),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 4.h),
                                  // Email
                                  CustomTextFormField(
                                    controller: _emailController,
                                    labelText: l10n.email,
                                    prefixIcon: Icons.email,
                                    keyboardType: TextInputType.emailAddress,
                                    regexPattern: ValidationPatterns.email,
                                    errorMessage: l10n.invalidEmail,
                                  ),
                                  SizedBox(height: 2.5.h),
                                  // Password
                                  CustomTextFormField(
                                    controller: _passwordController,
                                    labelText: l10n.password,
                                    prefixIcon: Icons.lock,
                                    obscureText: true,
                                    regexPattern:
                                        ValidationPatterns.passwordMin6,
                                    errorMessage: l10n.passwordTooShort,
                                  ),
                                  SizedBox(height: 4.h),
                                  // Login Button
                                  CustomAuthButton(
                                    text: l10n.logIn,
                                    onPressed: _login,
                                    isLoading: _isLoading,
                                    horizontalPadding: 10.w,
                                  ),
                                  SizedBox(height: 2.h),
                                  // Sign up link
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        l10n.dontHaveAccount,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: const Color(0xFF4A4A4A),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Pop with 'signup' result to trigger registration flow
                                          Navigator.of(context).pop('signup');
                                        },
                                        child: Text(
                                          l10n.signUp,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: const Color(0xFF2C5F7C),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
