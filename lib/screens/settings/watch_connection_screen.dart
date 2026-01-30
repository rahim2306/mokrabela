import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/services/ble_service.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:mokrabela/screens/settings/test_ble_sync.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:geolocator/geolocator.dart'; // Add import

class WatchConnectionScreen extends StatefulWidget {
  const WatchConnectionScreen({super.key});

  @override
  State<WatchConnectionScreen> createState() => _WatchConnectionScreenState();
}

class _WatchConnectionScreenState extends State<WatchConnectionScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  // Added WidgetsBindingObserver
  late AnimationController _radarController;
  final BleService _bleService = BleService();
  bool _permissionsGranted = false;
  bool _isLoadingPermissions = true;
  bool _isPermanentlyDenied = false; // Track permanent denial
  bool _isLocationServiceEnabled = true; // Add state

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _checkPermissions();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _radarController.dispose();
    _bleService.stopScan();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermissions();
    }
  }

  Future<void> _checkPermissions() async {
    // Only show loading on initial load or manual retry, not when resuming
    if (!_isPermanentlyDenied) {
      // If we already know it's permanent, don't flicker loading
    }

    // Check status WITHOUT requesting first
    final scanStatus = await Permission.bluetoothScan.status;
    final connectStatus = await Permission.bluetoothConnect.status;
    final locationStatus = await Permission.location.status;

    // Check Location Service Status
    bool serviceEnabled = true;
    if (defaultTargetPlatform == TargetPlatform.android) {
      try {
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
      } catch (e) {
        debugPrint("Geolocator check failed: $e");
        // Fallback to true so we don't block the UI if the plugin fails (e.g. hot reload issue)
        serviceEnabled = true;
      }
    }

    bool granted = true;
    bool permanentlyDenied = false;

    if (defaultTargetPlatform == TargetPlatform.android) {
      // Check if ANY are denied
      if (scanStatus.isDenied ||
          connectStatus.isDenied ||
          locationStatus.isDenied ||
          scanStatus.isPermanentlyDenied ||
          connectStatus.isPermanentlyDenied ||
          locationStatus.isPermanentlyDenied) {
        granted = false;

        if (scanStatus.isPermanentlyDenied ||
            connectStatus.isPermanentlyDenied ||
            locationStatus.isPermanentlyDenied) {
          permanentlyDenied = true;
        }
      }
    } else {
      // iOS
      granted = scanStatus.isGranted || scanStatus.isLimited;
    }

    if (mounted) {
      setState(() {
        _permissionsGranted = granted;
        _isPermanentlyDenied = permanentlyDenied;
        _isLocationServiceEnabled = serviceEnabled;
        _isLoadingPermissions = false;
      });

      if (granted &&
          serviceEnabled &&
          !_bleService.isScanning &&
          !_bleService.isConnected) {
        _bleService.startScan();
      }
    }
  }

  Future<void> _requestPermissions() async {
    // We do NOT set _isLoadingPermissions = true here.
    // This allows the "Permissions Required" UI to stay visible while the system dialog shows.
    // This prevents the "black screen" effect.

    if (defaultTargetPlatform == TargetPlatform.android) {
      try {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.bluetoothScan,
          Permission.bluetoothConnect,
          Permission.location,
        ].request();

        bool granted = statuses.values.every((status) => status.isGranted);
        bool permanentlyDenied = statuses.values.any(
          (status) => status.isPermanentlyDenied,
        );

        if (mounted) {
          setState(() {
            _permissionsGranted = granted;
            _isPermanentlyDenied = permanentlyDenied;
            // If granted, we should also re-check location service status effectively?
            // The lifecycle observer will trigger _checkPermissions on resume anyway.
          });

          if (granted) {
            // Re-check everything properly
            _checkPermissions();
          }
        }
      } catch (e) {
        debugPrint("Error requesting permissions: $e");
      }
    }
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
                child: _isLoadingPermissions
                    ? const Center(child: CircularProgressIndicator())
                    : (!_permissionsGranted
                          ? _buildPermissionRequiredState(l10n)
                          : (!_isLocationServiceEnabled
                                ? _buildLocationServiceDisabledState(
                                    l10n,
                                  ) // New State
                                : StreamBuilder<BluetoothAdapterState>(
                                    stream: FlutterBluePlus.adapterState,
                                    initialData: BluetoothAdapterState.unknown,
                                    builder: (context, snapshot) {
                                      final state = snapshot.data;
                                      if (state == BluetoothAdapterState.on) {
                                        return SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              SizedBox(height: 5.h),
                                              _buildRadarSection(l10n),
                                              SizedBox(height: 5.h),
                                              _buildDeviceList(l10n),
                                            ],
                                          ),
                                        );
                                      } else if (state ==
                                          BluetoothAdapterState.off) {
                                        return _buildBluetoothOffState(
                                          l10n,
                                        ); // Existing State
                                      } else {
                                        return Center(
                                          child: Text(
                                            'Bluetooth Unavailable',
                                            style: GoogleFonts.spaceGrotesk(
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // New Widget
  Widget _buildLocationServiceDisabledState(AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_disabled, size: 50.sp, color: Colors.orange),
            SizedBox(height: 3.h),
            Text(
              "Location Required",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppTheme.deepBlue,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              "Please enable Location/GPS to scan for nearby devices.",
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 12.sp,
                color: AppTheme.textSecondary,
              ),
            ),
            SizedBox(height: 4.h),
            ElevatedButton(
              onPressed: () async {
                await Geolocator.openLocationSettings();
                // Check again after coming back? LifeCycle observer handles this usually,
                // but we can also wait a bit or just rely on observer.
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "Enable Location",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionRequiredState(AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.security_rounded, size: 50.sp, color: AppTheme.primary),
            SizedBox(height: 3.h),
            Text(
              "Permissions Required",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppTheme.deepBlue,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              _isPermanentlyDenied
                  ? "You have permanently denied Bluetooth permissions. Please open settings to enable them."
                  : "We need Bluetooth and Location permissions to find your child's watch.",
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 12.sp,
                color: AppTheme.textSecondary,
              ),
            ),
            SizedBox(height: 4.h),
            ElevatedButton(
              onPressed: () => _isPermanentlyDenied
                  ? openAppSettings()
                  : _requestPermissions(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                _isPermanentlyDenied
                    ? l10n.openSettings
                    : "Grant Permissions", // Add l10n key for "Grant" later if needed
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBluetoothOffState(AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bluetooth_disabled_rounded,
              size: 50.sp,
              color: Colors.redAccent.withOpacity(
                0.7,
              ), // Changed withValues to withOpacity
            ),
            SizedBox(height: 3.h),
            Text(
              l10n.bluetoothOff,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppTheme.deepBlue,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              l10n.bluetoothOffDesc,
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 12.sp,
                color: AppTheme.textSecondary,
              ),
            ),
            SizedBox(height: 4.h),
            ElevatedButton(
              onPressed: () async {
                if (defaultTargetPlatform == TargetPlatform.android) {
                  try {
                    await FlutterBluePlus.turnOn();
                  } catch (e) {
                    // Fallback if programmatic turn on fails
                    openAppSettings(); // Open settings if turning on fails
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                l10n.turnOnBluetooth,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
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
    // ... (Keep existing implementation but verify null safety)
    return ListenableBuilder(
      listenable: _bleService,
      builder: (context, child) {
        // ... (Keep existing implementation)
        return Column(
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
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
                              color: AppTheme.primary.withOpacity(
                                // Changed withValues to withOpacity
                                (1 - progress) * 0.5,
                              ),
                              width: 2,
                            ),
                          ),
                        );
                      },
                    );
                  }),
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primary.withOpacity(
                            0.2,
                          ), // Changed withValues to withOpacity
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
              Text(
                l10n.noDevicesFound,
                style: GoogleFonts.spaceGrotesk(
                  color: AppTheme.textSecondary,
                ), // Added style
              ),
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
            color: Colors.white.withOpacity(
              0.8,
            ), // Changed withValues to withOpacity
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
                  color: AppTheme.deepBlue.withOpacity(
                    0.6,
                  ), // Changed withValues to withOpacity
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
                  // Prefer advertisement name first, then platform name, then fallback
                  String deviceName = "Unknown Device";
                  if (result.advertisementData.localName.isNotEmpty) {
                    deviceName = result.advertisementData.localName;
                  } else if (result.device.platformName.isNotEmpty) {
                    deviceName = result.device.platformName;
                  }

                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 0.5.h,
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundLight,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.watch,
                        color: AppTheme.primary,
                        size: 20.sp,
                      ),
                    ),
                    title: Text(
                      deviceName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.spaceGrotesk(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.deepBlue,
                        fontSize: 12.sp,
                      ),
                    ),
                    subtitle: Text(
                      result.device.remoteId.toString(),
                      style: GoogleFonts.spaceGrotesk(fontSize: 10.sp),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // RSSI Indicator
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.signal_cellular_alt,
                              size: 14.sp,
                              color: result.rssi > -60
                                  ? Colors.green
                                  : (result.rssi > -80
                                        ? Colors.orange
                                        : Colors.grey),
                            ),
                            Text(
                              "${result.rssi} dBm",
                              style: TextStyle(
                                fontSize: 8.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 3.w),

                        _bleService.isConnecting &&
                                _bleService.connectionState !=
                                    BluetoothConnectionState.connected
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : InkWell(
                                onTap: () =>
                                    _bleService.connectToDevice(result.device),
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: AppTheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                    size: 16.sp,
                                  ),
                                ),
                              ),
                      ],
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
