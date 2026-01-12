import 'package:flutter/material.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/components/buttons/primary_button.dart';
import 'package:mokrabela/components/inputfields/radio_option.dart';
import 'package:mokrabela/models/user_model.dart';
import 'package:sizer/sizer.dart';

/// Role selection screen - Second screen in onboarding flow
class RoleSelectionScreen extends StatefulWidget {
  final VoidCallback onBack;
  final Function(UserRole) onNext;
  final Function(Locale) onLanguageChanged;
  final Locale currentLocale;
  final UserRole? initialSelection;

  const RoleSelectionScreen({
    super.key,
    required this.onBack,
    required this.onNext,
    required this.onLanguageChanged,
    required this.currentLocale,
    this.initialSelection,
  });

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  UserRole? selectedRole;

  @override
  void initState() {
    super.initState();
    selectedRole = widget.initialSelection;
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
                      // Content card
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Question
                            Text(
                              l10n.onboardingQuestion1,
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1A1A1A),
                              ),
                            ),
                            SizedBox(height: 3.h),
                            // Option 1: Parent
                            RadioOption<UserRole>(
                              value: UserRole.parent,
                              groupValue: selectedRole ?? UserRole.parent,
                              text: l10n.optionParent,
                              icon: Icons.family_restroom,
                              onChanged: (value) {
                                setState(() {
                                  selectedRole = value!;
                                });
                              },
                            ),
                            SizedBox(height: 2.h),
                            // Option 2: Teacher
                            RadioOption<UserRole>(
                              value: UserRole.teacher,
                              groupValue: selectedRole ?? UserRole.teacher,
                              text: l10n.optionTeacher,
                              icon: Icons.school,
                              onChanged: (value) {
                                setState(() {
                                  selectedRole = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                      // Bottom button
                      PrimaryButton(
                        text: l10n.next,
                        onPressed: selectedRole != null
                            ? () => widget.onNext(selectedRole!)
                            : null,
                      ),
                      SizedBox(height: 5.h),
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
