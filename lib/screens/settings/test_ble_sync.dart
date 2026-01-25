// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mokrabela/services/realtime_sync_service.dart';
import 'package:mokrabela/services/ble_service.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:mokrabela/services/protocol_service.dart';

class TestBleSyncScreen extends StatefulWidget {
  const TestBleSyncScreen({super.key});

  @override
  State<TestBleSyncScreen> createState() => _TestBleSyncScreenState();
}

class _TestBleSyncScreenState extends State<TestBleSyncScreen> {
  final _bleService = BleService();
  final _syncService = RealtimeSyncService();
  final _authService = AuthService();
  final _protocolService = ProtocolService();

  double _simulatedActivity = 0.0;
  int _simulatedAlerts = 0;
  int _simulatedProtocolWeek = 1;
  bool _isSyncRunning = false;
  String _currentUid = "Detecting...";
  final List<String> _logs = [];

  // Throttle timer to prevent UI flooding
  Timer? _injectionThrottle;

  @override
  void initState() {
    super.initState();
    _currentUid = _authService.currentUser?.uid ?? "NOT LOGGED IN";
    _addLog("Simulator initialized. UID: $_currentUid");
  }

  void _addLog(String msg) {
    if (mounted) {
      setState(() {
        _logs.insert(
          0,
          "${DateTime.now().toString().split('.').first.split(' ').last}: $msg",
        );
        if (_logs.length > 50) _logs.removeLast();
      });
    }
  }

  @override
  void dispose() {
    _syncService.stopSync();
    _injectionThrottle?.cancel();
    super.dispose();
  }

  void _updateSimulation() {
    // Only update BleService every 150ms to avoid flooding CPU/Emulator
    _injectionThrottle?.cancel();
    _injectionThrottle = Timer(const Duration(milliseconds: 150), () {
      _bleService.injectSimulatedData({
        'activityLevel': _simulatedActivity,
        'alertCount': _simulatedAlerts,
        'watchConnected': _bleService.isConnected,
      });
      _addLog(
        "Sent: Act=${_simulatedActivity.toStringAsFixed(1)}%, Alerts=$_simulatedAlerts",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BLE Sync Simulator",
          style: GoogleFonts.spaceGrotesk(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppTheme.deepBlue,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusCard(),
            SizedBox(height: 3.h),
            Text(
              "Simulation Controls",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            _buildSlider("Activity Level", _simulatedActivity, (val) {
              setState(() => _simulatedActivity = val);
              _updateSimulation();
            }),
            SizedBox(height: 2.h),
            _buildCounter("Alert Count", _simulatedAlerts, (val) {
              setState(() => _simulatedAlerts = val);
              _updateSimulation();
            }),
            _buildSlider(
              "Force Protocol Week",
              _simulatedProtocolWeek.toDouble(),
              (val) {
                setState(() => _simulatedProtocolWeek = val.toInt());
                final user = _authService.currentUser;
                if (user != null) {
                  _protocolService.debugForceWeek(
                    user.uid,
                    _simulatedProtocolWeek,
                  );
                  _addLog("Force set Protocol to Week $_simulatedProtocolWeek");
                }
              },
              min: 1,
              max: 5,
              divisions: 4,
            ),
            SizedBox(height: 3.h),
            Text(
              "Live Data Logs",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 1.h),
            Expanded(child: _buildLogList()),
            SizedBox(height: 3.h),
            _buildSyncToggle(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogList() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black.withOpacity(0.1)),
      ),
      child: ListView.builder(
        itemCount: _logs.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            _logs[index],
            style: GoogleFonts.robotoMono(
              fontSize: 12.sp,
              color: Colors.blueGrey[900],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSyncToggle() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _isSyncRunning ? Colors.red : AppTheme.primary,
          padding: EdgeInsets.symmetric(vertical: 2.5.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          setState(() {
            _isSyncRunning = !_isSyncRunning;
            if (_isSyncRunning) {
              _syncService.startSync();
              _addLog("▶ SYNC STARTED");
            } else {
              _syncService.stopSync();
              _addLog("⏹ SYNC STOPPED");
            }
          });
        },
        child: Text(
          _isSyncRunning ? "STOP REAL-TIME SYNC" : "START REAL-TIME SYNC",
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primary.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          _buildInfoRow("Child ID", _currentUid),
          _buildInfoRow(
            "Watch Status",
            _bleService.isConnected ? "CONNECTED" : "DISCONNECTED",
            color: _bleService.isConnected
                ? Colors.green[700]
                : Colors.red[700],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.grey[800],
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Flexible(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.spaceGrotesk(
                fontWeight: FontWeight.bold,
                color: color ?? AppTheme.deepBlue,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    ValueChanged<double> onChanged, {
    double min = 0,
    double max = 100,
    int? divisions,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              max == 100 ? "${value.toStringAsFixed(1)}%" : "W${value.toInt()}",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppTheme.primary,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions ?? 100,
          activeColor: AppTheme.primary,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildCounter(String label, int value, ValueChanged<int> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.remove_circle_outline,
                size: 24.sp,
                color: AppTheme.primary,
              ),
              onPressed: () => onChanged(value > 0 ? value - 1 : 0),
            ),
            SizedBox(width: 4.w),
            Text(
              "$value",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 20.sp,
                fontWeight: FontWeight.w900,
                color: AppTheme.deepBlue,
              ),
            ),
            SizedBox(width: 4.w),
            IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                size: 24.sp,
                color: AppTheme.primary,
              ),
              onPressed: () => onChanged(value + 1),
            ),
          ],
        ),
      ],
    );
  }
}
