import 'package:flutter/material.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/user_model.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class WatchStatusCard extends StatelessWidget {
  final WatchSettings settings;

  const WatchStatusCard({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isConnected = settings.isConnected;
    final statusColor = isConnected ? const Color(0xFF4AC29A) : Colors.grey;
    final statusText = isConnected ? l10n.online : l10n.offline;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.watchStatus,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.deepBlue,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              _buildMetric(
                Icons.watch,
                l10n.device,
                settings.deviceName ?? 'None Paired',
              ),
              Container(
                width: 1,
                height: 4.h,
                color: Colors.grey.withValues(alpha: 0.2),
              ),
              _buildMetric(
                _getBatteryIcon(85), // Mock battery for now
                l10n.battery,
                '85%', // Mock battery for now
              ),
            ],
          ),
          if (settings.lastSync != null) ...[
            SizedBox(height: 2.h),
            Divider(color: Colors.grey.withValues(alpha: 0.1)),
            SizedBox(height: 1.h),
            Row(
              children: [
                Icon(Icons.sync, size: 14.sp, color: AppTheme.textSecondary),
                SizedBox(width: 2.w),
                Text(
                  l10n.lastSyncedAt(
                    DateFormat('MMM d, HH:mm').format(settings.lastSync!),
                  ),
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMetric(IconData icon, String label, String value) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 22.sp, color: AppTheme.primary),
          SizedBox(width: 3.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.deepBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getBatteryIcon(int level) {
    if (level > 80) return Icons.battery_full;
    if (level > 50) return Icons.battery_6_bar;
    if (level > 20) return Icons.battery_3_bar;
    return Icons.battery_alert;
  }
}
