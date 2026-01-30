import 'package:flutter/material.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class QuickActionsCard extends StatelessWidget {
  final VoidCallback onSendMessage;
  final VoidCallback onSendSticker;

  const QuickActionsCard({
    super.key,
    required this.onSendMessage,
    required this.onSendSticker,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.deepBlue.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              icon: Icons.message_rounded,
              label: l10n.sendMessage,
              color: AppTheme.primary,
              onTap: onSendMessage,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: _buildActionButton(
              icon: Icons.emoji_emotions_rounded,
              label: l10n.sendSticker,
              color: const Color(0xFF8B7FEA),
              onTap: onSendSticker,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.2), width: 1.5),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24.sp),
              SizedBox(height: 1.h),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
