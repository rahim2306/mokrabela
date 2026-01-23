import 'package:flutter/material.dart';
import 'package:mokrabela/services/ble_service.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:mokrabela/l10n/app_localizations.dart';

class LiveSensorCard extends StatelessWidget {
  const LiveSensorCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Using the Singleton instance directly
    final bleService = BleService();
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.sensors, color: AppTheme.primary),
              SizedBox(width: 2.w),
              Text(
                l10n.liveHeartbeatMotion,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.deepBlue,
                ),
              ),
              const Spacer(),
              if (bleService.isConnected)
                _LiveTag()
              else
                Icon(Icons.bluetooth_disabled, color: Colors.grey, size: 16.sp),
            ],
          ),
          SizedBox(height: 2.h),
          StreamBuilder<Map<String, dynamic>>(
            stream: bleService.sensorDataStream,
            builder: (context, snapshot) {
              final data = snapshot.data ?? bleService.sensorData;
              final accZ = data['accZ']?.toStringAsFixed(2) ?? '0.00';
              final activity =
                  data['activityLevel']?.toStringAsFixed(1) ?? '0.0';

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _SensorItem(
                    label: l10n.motionZ,
                    value: accZ,
                    unit: 'm/s²',
                    icon: Icons.unfold_more,
                  ),
                  _SensorItem(
                    label: l10n.energy,
                    value: activity,
                    unit: '%',
                    icon: Icons.bolt,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LiveTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 1.w),
          Text(
            AppLocalizations.of(context)!.liveTag,
            style: TextStyle(
              fontSize: 8.sp,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class _SensorItem extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final IconData icon;

  const _SensorItem({
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppTheme.deepBlue.withValues(alpha: 0.5),
          size: 18.sp,
        ),
        SizedBox(height: 0.5.h),
        Text(
          value,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 18.sp,
            fontWeight: FontWeight.w900,
            color: AppTheme.deepBlue,
          ),
        ),
        Text(
          '$label ($unit)',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 9.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
