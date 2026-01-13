import 'package:flutter/material.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

/// Kids Protocol Screen - The Missing Square journey/steps
class KidsProtocolScreen extends StatelessWidget {
  const KidsProtocolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      child: Column(
        children: [
          SizedBox(height: 4.h),
          // Protocol content
          _buildProtocolContent(l10n),
          SizedBox(height: 10.h), // Space for bottom nav
        ],
      ),
    );
  }

  Widget _buildProtocolContent(AppLocalizations l10n) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to Missing Square Dashboard
      },
      child: Container(
        padding: EdgeInsets.all(3.5.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF667EEA).withValues(alpha: 0.3),
              blurRadius: 24,
              offset: const Offset(0, 10),
              spreadRadius: -4,
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              padding: EdgeInsets.all(2.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(Icons.grid_4x4, size: 32.sp, color: Colors.white),
            ),
            SizedBox(width: 4.w),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${l10n.missingSquare}TODO!',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    l10n.protocol,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.85),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            // Arrow
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white.withValues(alpha: 0.9),
              size: 18.sp,
            ),
          ],
        ),
      ),
    );
  }
}
