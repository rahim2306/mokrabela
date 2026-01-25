import 'package:flutter/material.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

/// Floating top bar with progress, watch status, and settings
class FloatingTopBar extends StatelessWidget {
  final bool isWatchConnected;
  final VoidCallback onWatchTap;
  final VoidCallback onSettingsTap;
  final VoidCallback? onProgressTap;
  final int completedTasks;
  final int totalTasks;

  const FloatingTopBar({
    super.key,
    required this.isWatchConnected,
    required this.onWatchTap,
    required this.onSettingsTap,
    this.onProgressTap,
    this.completedTasks = 2,
    this.totalTasks = 5,
  });

  double get progress => totalTasks > 0 ? completedTasks / totalTasks : 0.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 226, 240, 243), // Soft teal
              Color.fromARGB(255, 187, 222, 230), // Soft teal
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
              spreadRadius: -2,
            ),
          ],
        ),
        child: Row(
          children: [
            // Progress bar (takes most space)
            Expanded(
              child: GestureDetector(
                onTap: onProgressTap,
                behavior: HitTestBehavior.opaque,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.todaysCalmTime,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.deepBlue,
                            letterSpacing: -0.3,
                          ),
                        ),
                        Text(
                          '$completedTasks/$totalTasks ${l10n.minutes}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.2.h),
                    Stack(
                      children: [
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: progress.clamp(0.0, 1.0),
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF4ECDC4,
                                  ).withValues(alpha: 0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 3.w),
            // Watch status button
            GestureDetector(
              onTap: onWatchTap,
              child: Container(
                padding: EdgeInsets.all(2.5.w),
                decoration: BoxDecoration(
                  color: isWatchConnected
                      ? AppTheme.primary.withValues(alpha: 0.15)
                      : AppTheme.textSecondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isWatchConnected
                        ? AppTheme.primary.withValues(alpha: 0.3)
                        : AppTheme.textSecondary.withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  Icons.watch,
                  size: 22.sp,
                  color: isWatchConnected
                      ? AppTheme.primary
                      : AppTheme.textSecondary,
                ),
              ),
            ),
            SizedBox(width: 2.w),
            // Settings button
            GestureDetector(
              onTap: onSettingsTap,
              child: Container(
                padding: EdgeInsets.all(2.5.w),
                decoration: BoxDecoration(
                  color: Colors.indigoAccent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.indigoAccent.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  Icons.settings_outlined,
                  size: 22.sp,
                  color: Colors.indigoAccent.withValues(alpha: 0.8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
