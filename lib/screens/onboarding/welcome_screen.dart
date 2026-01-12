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
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
            child: Column(
              children: [
                // Language switcher
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: LanguageSwitcher(
                      currentLocale: currentLocale,
                      onLanguageChanged: onLanguageChanged,
                    ),
                  ),
                ),
                // Logo
                Image.asset(
                  'assets/images/logos/Logo.png',
                  height: 14.h,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 40),
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
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900, // Extra bold for emphasis
                    color: Color(0xFF1E4D5C), // Dark blue-teal mix
                    letterSpacing: -0.5, // Tighter for impact
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                // Subtitle - Secondary text with medium blue-teal
                Text(
                  l10n.welcomeSubtitle,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(
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
                const SizedBox(height: 16),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: Text(
                      l10n.logIn,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(
                          0xFF4ECDC4,
                        ), // Primary teal to match button above
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
