import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

import 'package:mokrabela/l10n/app_localizations.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.message,
    this.icon,
    this.actionLabel,
    this.onAction,
  });

  factory EmptyStateWidget.noSessions(
    BuildContext context, {
    VoidCallback? onRefresh,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return EmptyStateWidget(
      title: l10n.noActivityYet,
      message: l10n.noActivityYetDesc,
      icon: Icons.history_edu_rounded,
    );
  }

  factory EmptyStateWidget.noChildSelected(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return EmptyStateWidget(
      title: l10n.noChildSelectedTitle,
      message: l10n.noChildSelectedMessage,
      icon: Icons.child_care_rounded,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(4.h),
            decoration: BoxDecoration(
              color: AppTheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon ?? Icons.inbox_rounded,
              size: 40.sp,
              color: AppTheme.primary.withValues(alpha: 0.5),
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.deepBlue,
            ),
          ),
          SizedBox(height: 1.5.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 12.sp,
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
          ),
          if (actionLabel != null && onAction != null) ...[
            SizedBox(height: 3.h),
            ElevatedButton(
              onPressed: onAction,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(actionLabel!),
            ),
          ],
        ],
      ),
    );
  }
}
