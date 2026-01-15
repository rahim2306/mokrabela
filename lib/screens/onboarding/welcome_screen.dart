import 'package:flutter/material.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:mokrabela/components/buttons/primary_button.dart';
import 'package:mokrabela/components/language/language_switcher.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Welcome/Splash screen - First screen in onboarding flow
class WelcomeScreen extends StatelessWidget {
  final VoidCallback onGetStarted;
  final VoidCallback onLogin;
  final Function(Locale) onLanguageChanged;
  final Locale currentLocale;

  const WelcomeScreen({
    super.key,
    required this.onGetStarted,
    required this.onLogin,
    required this.onLanguageChanged,
    required this.currentLocale,
  });

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
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 6.w),
            child: Column(
              children: [
                // Language switcher
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Padding(
                    padding: EdgeInsets.only(top: 1.h),
                    child: LanguageSwitcher(
                      currentLocale: currentLocale,
                      onLanguageChanged: onLanguageChanged,
                    ),
                  ),
                ),
                //! Logo
                // Image.asset(
                //   'assets/images/logos/Logo.png',
                //   height: 14.h,
                //   fit: BoxFit.contain,
                // ),
                SizedBox(height: 5.h),
                // Illustration with SVG
                Container(
                  height: 30.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppTheme.primary.withValues(alpha: 0.15),
                        AppTheme.secondary.withValues(alpha: 0.15),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3.h),
                    child: SvgPicture.asset(
                      'assets/SVGs/undraw_fatherhood_eldm.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const Spacer(flex: 1),
                // Welcome text - Primary heading with dark blue-teal
                Text(
                  l10n.welcomeToMokrabela,
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w900, // Extra bold for emphasis
                    color: const Color(0xFF1E4D5C), // Dark blue-teal mix
                    letterSpacing: -0.5, // Tighter for impact
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                // Subtitle - Secondary text with medium blue-teal
                Text(
                  l10n.welcomeSubtitle,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(
                      0xFF2C5F7C,
                    ), // Medium blue-teal (matches deepBlue)
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(flex: 2),
                // Get Started button
                PrimaryButton(text: l10n.getStarted, onPressed: onGetStarted),
                SizedBox(height: 2.h),
                // Log in link - Accent teal color with subtle background
                Container(
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFF4ECDC4,
                    ).withValues(alpha: 0.1), // 10% opacity of primary teal
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: onLogin,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 1.5.h,
                      ),
                      minimumSize: Size(double.infinity, 6.h),
                    ),
                    child: Text(
                      l10n.logIn,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(
                          0xFF4ECDC4,
                        ), // Primary teal to match button above
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
