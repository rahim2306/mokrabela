import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui';

class ProtocolStatusPopup extends StatelessWidget {
  final List<int> completedSquares;
  final int totalSquares;

  const ProtocolStatusPopup({
    super.key,
    required this.completedSquares,
    this.totalSquares = 4,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final progress = totalSquares > 0
        ? completedSquares.length / totalSquares
        : 0.0;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.dailyProgress,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.deepBlue,
                            letterSpacing: -0.5,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppTheme.deepBlue.withValues(alpha: 0.05),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close_rounded,
                              size: 18.sp,
                              color: AppTheme.deepBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),

                    // Progress Visualization
                    _buildCircularProgress(
                      progress,
                      completedSquares.length,
                      totalSquares,
                    ),
                    SizedBox(height: 4.h),

                    // Protocol Steps List
                    _buildProtocolStep(
                      context,
                      l10n.square1Title,
                      1,
                      completedSquares.contains(1),
                      const Color(0xFF4ECDC4),
                    ),
                    _buildProtocolStep(
                      context,
                      l10n.square2Title,
                      2,
                      completedSquares.contains(2),
                      const Color(0xFF667EEA),
                    ),
                    _buildProtocolStep(
                      context,
                      l10n.square3Title,
                      3,
                      completedSquares.contains(3),
                      const Color(0xFFFFE259),
                    ),
                    _buildProtocolStep(
                      context,
                      l10n.square4Title,
                      4,
                      completedSquares.contains(4),
                      const Color(0xFFF093FB),
                    ),

                    SizedBox(height: 4.h),
                    // Motivation
                    Text(
                      _getMotivation(completedSquares.length),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.deepBlue.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircularProgress(double progress, int completed, int total) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 25.w,
          height: 25.w,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 10,
            backgroundColor: AppTheme.primary.withValues(alpha: 0.1),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4ECDC4)),
            strokeCap: StrokeCap.round,
          ),
        ),
        Column(
          children: [
            Text(
              '$completed/$total',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 22.sp,
                fontWeight: FontWeight.w800,
                color: AppTheme.deepBlue,
              ),
            ),
            Text(
              'DONE',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                color: AppTheme.deepBlue.withValues(alpha: 0.5),
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProtocolStep(
    BuildContext context,
    String title,
    int stepNum,
    bool isComplete,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5.h),
      child: Row(
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: isComplete ? color : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: color.withValues(alpha: 0.4), width: 2),
              boxShadow: isComplete
                  ? [
                      BoxShadow(
                        color: color.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : [],
            ),
            child: isComplete
                ? Icon(Icons.check_rounded, color: Colors.white, size: 14.sp)
                : Center(
                    child: Text(
                      '$stepNum',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: color.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
          ),
          SizedBox(width: 4.w),
          Text(
            title,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 14.sp,
              fontWeight: isComplete ? FontWeight.w700 : FontWeight.w600,
              color: isComplete
                  ? AppTheme.deepBlue
                  : AppTheme.deepBlue.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  String _getMotivation(int completed) {
    switch (completed) {
      case 0:
        return "Let's start your journey today! ✨";
      case 1:
        return "Great start! One step closer to calm. 🌟";
      case 2:
        return "Halfway there! Keep going, you got this! 💪";
      case 3:
        return "Almost done! You're doing amazing! 🌈";
      case 4:
        return "Amazing! You completed your protocol! 🎉";
      default:
        return "Keep taking care of yourself! 💖";
    }
  }
}
