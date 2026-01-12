import 'package:flutter/material.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/user_model.dart';
import 'package:mokrabela/screens/onboarding/auth/login.dart';
import 'package:mokrabela/components/inputfields/custom_text_form_field.dart';
import 'package:mokrabela/components/buttons/custom_auth_button.dart';
import 'package:sizer/sizer.dart';

/// Registration form screen - Third screen in onboarding flow
class RegistrationScreen extends StatefulWidget {
  final VoidCallback onBack;
  final Function({
    required String firstName,
    required String familyName,
    required String email,
    required String password,
    required UserRole role,
  })
  onSubmit;
  final Function(Locale) onLanguageChanged;
  final Locale currentLocale;
  final bool isLoading;
  final UserRole selectedRole;

  const RegistrationScreen({
    super.key,
    required this.onBack,
    required this.onSubmit,
    required this.onLanguageChanged,
    required this.currentLocale,
    required this.selectedRole,
    this.isLoading = false,
  });

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _familyNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late UserRole _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.selectedRole;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _familyNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(
        firstName: _firstNameController.text.trim(),
        familyName: _familyNameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        role: _selectedRole,
      );
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
                    onPressed: widget.onBack,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    children: [
                      SizedBox(height: 1.h),
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
                                l10n.tellUsMoreTitle,
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF1A1A1A),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                l10n.tellUsMoreSubtitle,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: const Color(0xFF4A4A4A),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              // First Name
                              CustomTextFormField(
                                controller: _firstNameController,
                                labelText: l10n.firstName,
                                prefixIcon: Icons.person,
                                keyboardType: TextInputType.name,
                                textCapitalization: TextCapitalization.words,
                                regexPattern: ValidationPatterns.name,
                                errorMessage: l10n.fieldRequired,
                              ),
                              SizedBox(height: 2.h),
                              // Family Name
                              CustomTextFormField(
                                controller: _familyNameController,
                                labelText: l10n.familyName,
                                prefixIcon: Icons.people,
                                keyboardType: TextInputType.name,
                                textCapitalization: TextCapitalization.words,
                                regexPattern: ValidationPatterns.name,
                                errorMessage: l10n.fieldRequired,
                              ),
                              SizedBox(height: 2.h),
                              // Email
                              CustomTextFormField(
                                controller: _emailController,
                                labelText: l10n.email,
                                prefixIcon: Icons.email,
                                keyboardType: TextInputType.emailAddress,
                                regexPattern: ValidationPatterns.email,
                                errorMessage: l10n.invalidEmail,
                              ),
                              SizedBox(height: 2.h),
                              // Password
                              CustomTextFormField(
                                controller: _passwordController,
                                labelText: l10n.password,
                                prefixIcon: Icons.lock,
                                obscureText: true,
                                regexPattern: ValidationPatterns.passwordMin6,
                                errorMessage: l10n.passwordTooShort,
                              ),
                              SizedBox(height: 3.h),
                              // Submit Button
                              CustomAuthButton(
                                text: l10n.signUp,
                                onPressed: widget.isLoading
                                    ? () {}
                                    : _handleSubmit,
                                isLoading: widget.isLoading,
                                horizontalPadding: 10.w,
                              ),
                              SizedBox(height: 2.h),
                              // Login link
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    l10n.alreadyHaveAccount,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: const Color(0xFF4A4A4A),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Navigate to login screen as a modal
                                      // Use push (not pushAndRemoveUntil) to preserve navigation stack
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      l10n.logIn,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF2C5F7C),
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
                      const SizedBox(height: 40),
                    ],
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
