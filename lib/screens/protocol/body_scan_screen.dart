import 'package:flutter/material.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui';

class BodyScanScreen extends StatefulWidget {
  const BodyScanScreen({super.key});

  @override
  State<BodyScanScreen> createState() => _BodyScanScreenState();
}

class _BodyScanScreenState extends State<BodyScanScreen> {
  int _currentStep = 0;
  final PageController _pageController = PageController();
  final List<Map<String, String>> _steps = [
    {
      'title': 'Start with Feet',
      'instruction':
          'Wiggle your toes. Feel them touching the floor. Relax them now.',
      'icon': '🦶',
      'accent': '#4ECDC4',
    },
    {
      'title': 'Moving to Legs',
      'instruction':
          'Tense your leg muscles for a second... and let them go loose.',
      'icon': '🦵',
      'accent': '#667EEA',
    },
    {
      'title': 'Relax Your Tummy',
      'instruction':
          'Place your hand on your belly. Feel it rise and fall as you breathe.',
      'icon': '🧘',
      'accent': '#FFA751',
    },
    {
      'title': 'Soft Shoulders',
      'instruction':
          'Bring your shoulders up to your ears... then drop them down heavy.',
      'icon': '🤷',
      'accent': '#764BA2',
    },
    {
      'title': 'Peaceful Face',
      'instruction':
          'Smile big... then relax your face completely. You are doing great!',
      'icon': '😊',
      'accent': '#F5576C',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentStep < _steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStepData = _steps[_currentStep];
    final currentAccent = Color(
      int.parse(currentStepData['accent']!.replaceAll('#', '0xFF')),
    );

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              currentAccent.withValues(alpha: 0.8),
              currentAccent.withValues(alpha: 1.0),
              AppTheme.deepBlue,
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // Custom Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                    Text(
                      'Body Scan',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${_currentStep + 1}/5',
                        style: GoogleFonts.spaceGrotesk(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Steps Area
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) =>
                      setState(() => _currentStep = index),
                  itemCount: _steps.length,
                  itemBuilder: (context, index) {
                    final step = _steps[index];
                    final accentColor = Color(
                      int.parse(step['accent']!.replaceAll('#', '0xFF')),
                    );

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 2.h),
                            // Animation Container
                            Container(
                              width: 55.w,
                              height: 55.w,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: accentColor.withValues(alpha: 0.2),
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.w),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    step['icon']!,
                                    style: const TextStyle(height: 1.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 6.h),

                            // Glassmorphic Instruction Card
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 15,
                                  sigmaY: 15,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.2,
                                      ),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        step['title']!,
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                          letterSpacing: -0.5,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        step['instruction']!,
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 14.sp,
                                          color: Colors.white.withValues(
                                            alpha: 0.9,
                                          ),
                                          height: 1.4,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 2.h),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Bottom Button
              Padding(
                padding: EdgeInsets.all(6.w),
                child: Container(
                  height: 8.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _next,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppTheme.deepBlue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text(
                      _currentStep == _steps.length - 1
                          ? 'I feel peaceful'
                          : 'Next',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
