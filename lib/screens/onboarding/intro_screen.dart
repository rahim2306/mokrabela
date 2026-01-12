import 'package:flutter/material.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:mokrabela/components/buttons/primary_button.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Combined introduction screen with slidable content
class IntroScreen extends StatefulWidget {
  final VoidCallback onComplete;
  final VoidCallback onSkip;
  final VoidCallback onBack;

  const IntroScreen({
    super.key,
    required this.onComplete,
    required this.onSkip,
    required this.onBack,
  });

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_currentPage < 1) {
      // Go to next slide
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Last slide, complete intro
      widget.onComplete();
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Column(
              children: [
                // Top bar with back and skip buttons (FIXED)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button
                    IconButton(
                      onPressed: widget.onBack,
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppTheme.deepBlue,
                        size: 24.sp,
                      ),
                    ),
                    // Skip button
                    TextButton(
                      onPressed: widget.onSkip,
                      child: Text(
                        l10n.skip,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppTheme.deepBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 2.h),

                // Slidable content area
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      // Slide 1
                      _buildSlide(
                        svgPath: 'assets/SVGs/undraw_true-friends_1h3v.svg',
                        title: l10n.intro1Title,
                        description: l10n.intro1Description,
                      ),
                      // Slide 2
                      _buildSlide(
                        svgPath: 'assets/SVGs/kids_snowman.svg',
                        title: l10n.intro2Title,
                        description: l10n.intro2Description,
                      ),
                    ],
                  ),
                ),

                // Page indicators (FIXED)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPageIndicator(0),
                    SizedBox(width: 2.w),
                    _buildPageIndicator(1),
                  ],
                ),

                SizedBox(height: 3.h),

                // Next button (FIXED)
                PrimaryButton(text: l10n.next, onPressed: _onNextPressed),

                SizedBox(height: 3.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSlide({
    required String svgPath,
    required String title,
    required String description,
  }) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // SVG Illustration
          Container(
            height: 35.h,
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
              child: SvgPicture.asset(svgPath, fit: BoxFit.contain),
            ),
          ),

          SizedBox(height: 6.h),

          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF1E4D5C),
              letterSpacing: -0.5,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 4.h),

          // Description
          Text(
            description,
            style: TextStyle(
              fontSize: 16.sp,
              color: const Color(0xFF2C5F7C),
              height: 1.6,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int index) {
    final isActive = _currentPage == index;
    return Container(
      width: isActive ? 8.w : 2.w,
      height: 1.h,
      decoration: BoxDecoration(
        color: isActive
            ? AppTheme.primary
            : AppTheme.primary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
