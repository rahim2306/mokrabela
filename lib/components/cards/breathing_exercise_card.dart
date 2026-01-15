import 'package:flutter/material.dart';
import 'package:mokrabela/models/breathing_exercise_model.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class BreathingExerciseCard extends StatelessWidget {
  final BreathingExercise exercise;
  final VoidCallback onTap;

  const BreathingExerciseCard({
    super.key,
    required this.exercise,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine background color: Desaturated light version of the primary gradient color
    final backgroundColor = exercise.gradient.first.withValues(alpha: 0.15);
    final borderColor = exercise.gradient.first.withValues(alpha: 0.3);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: exercise.gradient.first.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(2.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon Container
                Container(
                  width: 18.w,
                  height: 18.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: exercise.gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: exercise.gradient.first.withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Icon(exercise.icon, color: Colors.white, size: 9.w),
                ),
                SizedBox(height: 2.h),
                // Title - Larger & Darker
                Text(
                  exercise.title,
                  style: TextStyle(
                    fontSize: 20.sp, // Made significantly larger
                    fontWeight: FontWeight.w900,
                    color: AppTheme.deepBlue,
                    letterSpacing: -0.5,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 1.h),
                // Brief Description - Larger & Readable
                Expanded(
                  child: Text(
                    exercise.description,
                    style: TextStyle(
                      fontSize: 14.sp, // Increased size
                      fontWeight: FontWeight.w600,
                      color: AppTheme.deepBlue.withValues(
                        alpha: 0.8,
                      ), // Darker for better contrast on colored bg
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
