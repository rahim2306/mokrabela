import 'package:flutter/material.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/services/ble_service.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:mokrabela/screens/settings/test_ble_sync.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class WatchConnectionScreen extends StatefulWidget {
  const WatchConnectionScreen({super.key});

  @override
  State<WatchConnectionScreen> createState() => _WatchConnectionScreenState();
}

class _WatchConnectionScreenState extends State<WatchConnectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _radarController;
  final BleService _bleService = BleService();

  @override
  void initState() {
    super.initState();
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Start scanning when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bleService.startScan();
    });
  }

  @override
  void dispose() {
    _radarController.dispose();
    _bleService.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.kidsBackgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, l10n),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 5.h),
                      _buildRadarSection(l10n),
                      SizedBox(height: 5.h),
                      _buildDeviceList(l10n),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppTheme.deepBlue,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            l10n.connectWatch,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.deepBlue,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.bug_report, color: AppTheme.primary),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TestBleSyncScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadarSection(AppLocalizations l10n) {
    return ListenableBuilder(
      listenable: _bleService,
      builder: (context, child) {
        return Column(
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Pulsing circles
                  ...List.generate(3, (index) {
                    return AnimatedBuilder(
                      animation: _radarController,
                      builder: (context, child) {
                        double progress =
                            (_radarController.value + index / 3) % 1;
                        return Container(
                          width: (150 + progress * 150),
                          height: (150 + progress * 150),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppTheme.primary.withValues(
                                alpha: (1 - progress) * 0.5,
                              ),
                              width: 2,
                            ),
                          ),
                        );
                      },
                    );
                  }),
                  // Center Watch Icon
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primary.withValues(alpha: 0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      _bleService.isConnected
                          ? Icons.watch
                          : Icons.bluetooth_searching,
                      size: 40.sp,
                      color: AppTheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              _bleService.isConnected
                  ? l10n.watchConnected
                  : (_bleService.isScanning
                        ? l10n.watchScanning
                        : (_bleService.lastErrorMessage ??
                              (_bleService.scanResults.isNotEmpty
                                  ? l10n.watchFound
                                  : l10n.noDevicesFound))),
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: _bleService.lastErrorMessage != null
                    ? Colors.redAccent
                    : (_bleService.scanResults.isEmpty &&
                              !_bleService.isScanning
                          ? Colors.grey
                          : AppTheme.deepBlue),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDeviceList(AppLocalizations l10n) {
    return ListenableBuilder(
      listenable: _bleService,
      builder: (context, child) {
        final results = _bleService.scanResults;

        if (results.isEmpty && !_bleService.isScanning) {
          return Column(
            children: [
              Text(l10n.noDevicesFound),
              TextButton(
                onPressed: () => _bleService.startScan(),
                child: Text(l10n.retryScan),
              ),
            ],
          );
        }

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 6.w),
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.availableDevices,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.deepBlue.withValues(alpha: 0.6),
                ),
              ),
              SizedBox(height: 2.h),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: results.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final result = results[index];
                  final deviceName = result.device.platformName.isNotEmpty
                      ? result.device.platformName
                      : "Unknown Device";

                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: AppTheme.backgroundLight,
                      child: Icon(Icons.watch, color: AppTheme.primary),
                    ),
                    title: Text(
                      deviceName,
                      style: GoogleFonts.spaceGrotesk(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.deepBlue,
                      ),
                    ),
                    subtitle: Text(result.device.remoteId.toString()),
                    trailing: _bleService.isConnecting
                        ? const CircularProgressIndicator(strokeWidth: 2)
                        : ElevatedButton(
                            onPressed: () =>
                                _bleService.connectToDevice(result.device),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(l10n.pairNow),
                          ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
