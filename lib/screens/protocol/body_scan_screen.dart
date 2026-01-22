import 'package:flutter/material.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class BodyScanScreen extends StatefulWidget {
  const BodyScanScreen({super.key});

  @override
  State<BodyScanScreen> createState() => _BodyScanScreenState();
}

class _BodyScanScreenState extends State<BodyScanScreen> {
  int _currentStep = 0;
  final List<Map<String, String>> _steps = [
    {
      'title': 'Start with Feet',
      'instruction':
          'Wiggle your toes. Feel them touching the floor. Relax them now.',
      'icon': '🦶',
    },
    {
      'title': 'Moving to Legs',
      'instruction':
          'Tense your leg muscles for a second... and let them go loose.',
      'icon': '🦵',
    },
    {
      'title': 'Relax Your Tummy',
      'instruction':
          'Place your hand on your belly. Feel it rise and fall as you breathe.',
      'icon': '🧘',
    },
    {
      'title': 'Soft Shoulders',
      'instruction':
          'Bring your shoulders up to your ears... then drop them down heavy.',
      'icon': '🤷',
    },
    {
      'title': 'Peaceful Face',
      'instruction':
          'Smile big... then relax your face completely. You are doing great!',
      'icon': '😊',
    },
  ];

  void _next() {
    if (_currentStep < _steps.length - 1) {
      setState(() => _currentStep++);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = _steps[_currentStep];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Guided Body Scan'),
        backgroundColor: AppTheme.primary,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Step ${_currentStep + 1} of 5',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10.h),
            Text(step['icon']!, style: TextStyle(fontSize: 60.sp)),
            SizedBox(height: 4.h),
            Text(
              step['title']!,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 22.sp,
                fontWeight: FontWeight.w900,
                color: AppTheme.deepBlue,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            Text(
              step['instruction']!,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 15.sp,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 7.h,
              child: ElevatedButton(
                onPressed: _next,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  _currentStep == 4 ? 'Finish' : 'Next',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
