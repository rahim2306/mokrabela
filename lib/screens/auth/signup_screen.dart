import 'package:flutter/material.dart';
import 'package:mokrabela/models/user_model.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:mokrabela/components/inputfields/custom_text_form_field.dart';
import 'package:mokrabela/components/buttons/custom_auth_button.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _familyNameController = TextEditingController(); // Added Family Name
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserRole _selectedRole = UserRole.child; // Default role
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        String fullName =
            '${_nameController.text} ${_familyNameController.text}';

        UserModel? user = await _authService.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          name: fullName.trim(),
          role: _selectedRole,
        );

        if (user != null && mounted) {
          // Navigation handled by AuthGate
          // But we need to pop the sign up screen off the stack
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFF5DADE2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom AppBar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF2C5F7C),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        color: const Color(0xFF2C5F7C),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 2.h),
                        // Logo
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(2.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              'assets/images/logos/Logo.png',
                              width: 35.w,
                              height: 35.w,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Join MokraBela',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2C5F7C),
                            shadows: [
                              Shadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                offset: const Offset(0, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4.h),

                        // Name Field
                        CustomTextFormField(
                          controller: _nameController,
                          labelText: 'First Name',
                          prefixIcon: Icons.person,
                          textCapitalization: TextCapitalization.words,
                          regexPattern: ValidationPatterns.name,
                          errorMessage: 'Please enter a valid name',
                        ),
                        SizedBox(height: 2.h),

                        // Family Name Field
                        CustomTextFormField(
                          controller: _familyNameController,
                          labelText: 'Family Name',
                          prefixIcon: Icons.people,
                          textCapitalization: TextCapitalization.words,
                          regexPattern: ValidationPatterns.name,
                          errorMessage: 'Please enter a valid family name',
                        ),
                        SizedBox(height: 2.h),

                        // Email Field
                        CustomTextFormField(
                          controller: _emailController,
                          labelText: 'Email',
                          prefixIcon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          regexPattern: ValidationPatterns.email,
                          errorMessage: 'Enter a valid email address',
                        ),
                        SizedBox(height: 2.h),

                        // Password Field
                        CustomTextFormField(
                          controller: _passwordController,
                          labelText: 'Password',
                          prefixIcon: Icons.lock,
                          obscureText: true,
                          regexPattern: ValidationPatterns.passwordMin6,
                          errorMessage:
                              'Password must be at least 6 characters',
                        ),
                        SizedBox(height: 3.h),

                        // Role Dropdown
                        DropdownButtonFormField<UserRole>(
                          initialValue: _selectedRole,
                          decoration: const InputDecoration(
                            labelText: 'I am a...',
                            prefixIcon: Icon(Icons.badge),
                          ),
                          items: UserRole.values.map((Role) {
                            return DropdownMenuItem(
                              value: Role,
                              child: Text(
                                Role.toString().split('.').last.toUpperCase(),
                              ),
                            );
                          }).toList(),
                          onChanged: (UserRole? newValue) {
                            setState(() {
                              _selectedRole = newValue!;
                            });
                          },
                        ),
                        const SizedBox(height: 32),

                        // Sign Up Button
                        CustomAuthButton(
                          text: 'Sign Up',
                          onPressed: _signUp,
                          isLoading: _isLoading,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Color(0xFF2C5F7C),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                      ],
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
