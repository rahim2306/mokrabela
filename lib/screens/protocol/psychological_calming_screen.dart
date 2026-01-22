import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:mokrabela/services/session_service.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class PsychologicalCalmingScreen extends StatefulWidget {
  const PsychologicalCalmingScreen({super.key});

  @override
  State<PsychologicalCalmingScreen> createState() =>
      _PsychologicalCalmingScreenState();
}

class _PsychologicalCalmingScreenState
    extends State<PsychologicalCalmingScreen> {
  final SessionService _sessionService = SessionService();
  final AuthService _authService = AuthService();
  final DateTime _startTime = DateTime.now();
  bool _isSaving = false;

  Future<void> _completeSession() async {
    setState(() => _isSaving = true);
    try {
      final user = _authService.currentUser;
      if (user != null) {
        await _sessionService.saveSession(
          childId: user.uid,
          type: 'focus',
          exerciseName: 'Psychological Calming',
          exerciseType: 'visualization_affirmation',
          protocolSquare: 4,
          startTime: _startTime,
          endTime: DateTime.now(),
          completed: true,
          context: context,
        );

        if (mounted) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Psychological Calming',
          style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF093FB),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(6.w),
        child: Column(
          children: [
            Container(
              height: 30.h,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFF093FB), Color(0xFFF5576C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.self_improvement,
                size: 80.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Find Your Peace',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                color: AppTheme.deepBlue,
              ),
            ),
            SizedBox(height: 2.h),
            _buildCalmCard(
              'Visualization',
              'Close your eyes and imagine a place where you feel safe and happy.',
              Icons.visibility_off,
            ),
            SizedBox(height: 3.h),
            _buildCalmCard(
              'Positive Affirmations',
              'Repeat to yourself: "I am calm, I am safe, and I am in control."',
              Icons.favorite,
            ),
            SizedBox(height: 4.h),
            ElevatedButton(
              onPressed: _isSaving ? null : _completeSession,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF5576C),
                minimumSize: Size(double.infinity, 7.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: _isSaving
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Finish My Peace Session'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalmCard(String title, String description, IconData icon) {
    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFF5576C), size: 25.sp),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.deepBlue,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  description,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 11.sp,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
