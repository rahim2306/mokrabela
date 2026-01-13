import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

/// Daily progress card component with gradient and images
class DailyProgressCard extends StatelessWidget {
  const DailyProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      height: 16.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6DD5ED).withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0.0, 4.0),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF6DD5ED), // Sky blue
            Color(0xFF2193B0), // Ocean blue
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: Text(
                l10n.manageYourTimeWell,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
            ),
            SizedBox(width: 2.w),
            Image.asset(
              'assets/images/drawings/Vector2.png',
              width: 22.w,
              height: 10.h,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 1.w),
            Image.asset(
              'assets/images/drawings/file.png',
              height: 10.h,
              width: 18.w,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
