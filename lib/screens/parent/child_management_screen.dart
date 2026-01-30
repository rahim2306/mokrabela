import 'package:flutter/material.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/user_model.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:mokrabela/services/parent_service.dart';
import 'package:sizer/sizer.dart';

class ChildManagementScreen extends StatelessWidget {
  final UserModel child;

  const ChildManagementScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          l10n.manageChild,
          style: TextStyle(
            color: AppTheme.deepBlue,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.deepBlue,
        iconTheme: IconThemeData(color: AppTheme.deepBlue),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF5F3FF), // Very pale lavender
              Color(0xFFEEF2FF), // Soft periwinkle
              Color(0xFFF8FAFF), // Almost white with blue hint
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Background Decorations
            Positioned(
              top: -10.h,
              right: -10.w,
              child: Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primary.withValues(alpha: 0.05),
                ),
              ),
            ),
            Positioned(
              top: 20.h,
              left: -15.w,
              child: Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF8B7FEA).withValues(alpha: 0.05),
                ),
              ),
            ),

            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                child: Column(
                  children: [
                    // Hero Profile Header (Premium Styling)
                    Hero(
                      tag: 'child_profile_${child.uid}',
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 100.w - 12.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(35),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.deepBlue.withValues(
                                      alpha: 0.08,
                                    ),
                                    blurRadius: 30,
                                    offset: const Offset(0, 15),
                                  ),
                                ],
                              ),
                              child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(2.w),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: [
                                            AppTheme.primary.withValues(
                                              alpha: 0.2,
                                            ),
                                            const Color(
                                              0xFF8B7FEA,
                                            ).withValues(alpha: 0.2),
                                          ],
                                        ),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(5.w),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.person_rounded,
                                          size: 50.sp,
                                          color: AppTheme.primary,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      child.name,
                                      style: TextStyle(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w900,
                                        color: AppTheme.deepBlue,
                                        letterSpacing: -0.5,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 0.5.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                        vertical: 0.8.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppTheme.backgroundLight,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        l10n.ageYearsOld(
                                          child.profile.age.toString(),
                                        ),
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.textSecondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 5.h),

                    // Account Management Section
                    _buildSectionHeader(l10n.accountSafety),
                    SizedBox(height: 2.h),
                    _buildActionCard(
                      Icons.lock_reset_rounded,
                      l10n.resetPassword,
                      l10n.resetPasswordDesc,
                      AppTheme.deepBlue,
                      () {
                        _showResetPasswordDialog(context, l10n);
                      },
                    ),
                    SizedBox(height: 2.h),
                    _buildActionCard(
                      Icons.delete_forever_rounded,
                      l10n.removeChild,
                      l10n.removeChildDesc,
                      const Color(0xFFFF9B9B),
                      () {
                        _showDeleteConfirmation(context, l10n);
                      },
                      isDanger: true,
                    ),

                    SizedBox(height: 6.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: AppTheme.textSecondary,
        ),
      ),
    );
  }

  Widget _buildActionCard(
    IconData icon,
    String title,
    String subtitle,
    Color color,
    VoidCallback onTap, {
    bool isDanger = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: isDanger
                ? color.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: EdgeInsets.all(5.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(icon, size: 22.sp, color: color),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          color: isDanger ? color : AppTheme.deepBlue,
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 18.sp,
                  color: AppTheme.textSecondary.withValues(alpha: 0.3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showResetPasswordDialog(
    BuildContext parentContext,
    AppLocalizations l10n,
  ) {
    // If we know the email, don't pre-fill it to force manual verification
    // Otherwise leave it empty for user to type
    final emailController = TextEditingController();
    String? errorText;

    showDialog(
      context: parentContext,
      builder: (dialogContext) => StatefulBuilder(
        // Renamed to dialogContext
        builder: (context, setState) {
          // 'context' here is the StatefulBuilder's context (can affect UI within dialog)
          // But we need parentContext for SnackBar after dialog closes

          return AlertDialog(
            title: Text(l10n.resetPassword),
            scrollable: true, // Handle scrolling natively
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.resetPasswordDesc),
                SizedBox(height: 2.h),
                TextField(
                  controller: emailController,
                  onChanged: (value) {
                    if (errorText != null) {
                      setState(() {
                        errorText = null;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: l10n.enterChildEmail,
                    errorText: errorText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(l10n.cancel),
              ),
              ElevatedButton(
                onPressed: () async {
                  final email = emailController.text.trim();
                  if (email.isEmpty) return;

                  // Verification Logic
                  if (child.email.isNotEmpty && email != child.email) {
                    setState(() {
                      errorText = l10n.invalidEmail;
                    });
                    return;
                  }

                  Navigator.pop(
                    dialogContext,
                  ); // Close dialog using dialogContext

                  try {
                    await ParentService().resetChildPassword(email);

                    // Use parentContext for SnackBar since dialog is closed
                    if (parentContext.mounted) {
                      ScaffoldMessenger.of(parentContext).showSnackBar(
                        SnackBar(content: Text(l10n.emailSentSuccess)),
                      );
                    }
                  } catch (e) {
                    if (parentContext.mounted) {
                      ScaffoldMessenger.of(
                        parentContext,
                      ).showSnackBar(SnackBar(content: Text('Error: $e')));
                    }
                  }
                },
                child: Text(l10n.sendResetLink),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.areYouSureDelete),
        content: Text(l10n.deleteChildWarning),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              try {
                await ParentService().deleteChildAccount(child.uid);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.childRemovedSuccess)),
                  );
                  Navigator.pop(context); // Go back to management list
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              }
            },
            child: Text(
              l10n.delete,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
