import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:mokrabela/services/session_service.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class GroundingExerciseScreen extends StatefulWidget {
  const GroundingExerciseScreen({super.key});

  @override
  State<GroundingExerciseScreen> createState() =>
      _GroundingExerciseScreenState();
}

class _GroundingExerciseScreenState extends State<GroundingExerciseScreen> {
  final SessionService _sessionService = SessionService();
  final AuthService _authService = AuthService();
  final DateTime _startTime = DateTime.now();
  int _currentStep = 0;
  final List<Map<String, dynamic>> _steps = [
    {
      'count': 5,
      'text': 'Things you can SEE',
      'instruction': 'Look around and name 5 items in your room.',
      'icon': Icons.visibility,
      'color': Colors.blue,
    },
    {
      'count': 4,
      'text': 'Things you can TOUCH',
      'instruction': 'Touch 4 different textures near you.',
      'icon': Icons.touch_app,
      'color': Colors.green,
    },
    {
      'count': 3,
      'text': 'Things you can HEAR',
      'instruction': 'Listen closely for 3 different sounds.',
      'icon': Icons.hearing,
      'color': Colors.purple,
    },
    {
      'count': 2,
      'text': 'Things you can SMELL',
      'instruction': 'Find 2 things with a distinct scent.',
      'icon': Icons.air,
      'color': Colors.orange,
    },
    {
      'count': 1,
      'text': 'Thing you can TASTE',
      'instruction': 'What is 1 thing you can taste right now?',
      'icon': Icons.restaurant,
      'color': Colors.red,
    },
  ];

  Future<void> _saveSession() async {
    final user = _authService.currentUser;
    if (user != null) {
      await _sessionService.saveSession(
        childId: user.uid,
        type: 'focus',
        exerciseName: '5-4-3-2-1 Grounding',
        exerciseType: 'grounding',
        protocolSquare: 2,
        startTime: _startTime,
        endTime: DateTime.now(),
        completed: true,
        context: context,
      );
    }
  }

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() => _currentStep++);
    } else {
      _saveSession();
      // Completed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Well Done!'),
          content: const Text('You are now more grounded and present.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Back to regulation menu
              },
              child: const Text('Finish'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = _steps[_currentStep];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Grounding Exercise'),
        backgroundColor: step['color'],
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
            SizedBox(height: 4.h),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Column(
                key: ValueKey(_currentStep),
                children: [
                  Icon(step['icon'], size: 80.sp, color: step['color']),
                  SizedBox(height: 4.h),
                  Text(
                    '${step['count']} ${step['text']}',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.deepBlue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    step['instruction'],
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14.sp,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 7.h,
              child: ElevatedButton(
                onPressed: _nextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: step['color'],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  _currentStep == 4 ? 'Complete' : 'Next Step',
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
