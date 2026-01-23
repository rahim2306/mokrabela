import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mokrabela/services/ble_service.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:logger/logger.dart';

/// Service to synchronize BLE sensor data to Firebase Realtime Database
/// implements optimized syncing to balance latency vs database costs.
class RealtimeSyncService {
  static final RealtimeSyncService _instance = RealtimeSyncService._internal();
  factory RealtimeSyncService() => _instance;

  RealtimeSyncService._internal();

  final FirebaseDatabase _database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
        'https://mokrabela-31058-default-rtdb.europe-west1.firebasedatabase.app',
  );
  final BleService _bleService = BleService();
  final AuthService _authService = AuthService();
  final Logger _logger = Logger();

  StreamSubscription? _sensorSubscription;
  Timer? _heartbeatTimer;
  Map<String, dynamic> _lastPushedData = {};
  DateTime _lastPushTime = DateTime.fromMillisecondsSinceEpoch(0);

  // Optimization Constants
  static const Duration _heartbeatInterval = Duration(seconds: 15);
  static const Duration _minReactiveInterval = Duration(seconds: 3);
  static const double _activityChangeThreshold = 10.0; // 10% change

  /// Start the synchronization process
  void startSync() {
    final userId = _authService.currentUser?.uid;
    if (userId == null) {
      _logger.w("Cannot start sync: No user logged in.");
      return;
    }

    if (_sensorSubscription != null) {
      _logger.d("Sync already running.");
      return;
    }

    _logger.i("Starting Optimized Real-time Sync for child: $userId");

    // 1. Initial Push: Perform a push immediately upon starting sync
    _performPush(userId, _bleService.sensorData, isHeartbeat: false);

    // 2. Reactive Sync: Listen for significant changes
    _sensorSubscription = _bleService.sensorDataStream.listen((data) {
      _logger.d("Stream update received: $data");
      _handleDataUpdate(userId, data);
    });

    // 2. Heartbeat Sync: Ensure periodic updates even if no significant change
    _heartbeatTimer = Timer.periodic(_heartbeatInterval, (_) {
      _performPush(userId, _bleService.sensorData, isHeartbeat: true);
    });
  }

  /// Stop the synchronization process
  void stopSync() {
    _logger.i("Stopping Real-time Sync.");
    _sensorSubscription?.cancel();
    _sensorSubscription = null;
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
    _lastPushedData = {};
  }

  void _handleDataUpdate(String userId, Map<String, dynamic> currentData) {
    final now = DateTime.now();
    final timeSinceLastPush = now.difference(_lastPushTime);

    if (timeSinceLastPush < _minReactiveInterval) {
      return; // Respect minimum interval for reactive pushes
    }

    if (_isSignificantChange(currentData)) {
      _performPush(userId, currentData, isHeartbeat: false);
    }
  }

  bool _isSignificantChange(Map<String, dynamic> currentData) {
    // 1. Connection status changed
    if (currentData['watchConnected'] != _lastPushedData['watchConnected']) {
      return true;
    }

    // 2. Alert count increased
    if ((currentData['alertCount'] ?? 0) >
        (_lastPushedData['alertCount'] ?? 0)) {
      return true;
    }

    // 3. Significant activity level change
    final currentActivity = (currentData['activityLevel'] ?? 0.0) as double;
    final lastActivity = (_lastPushedData['activityLevel'] ?? 0.0) as double;
    if ((currentActivity - lastActivity).abs() >= _activityChangeThreshold) {
      return true;
    }

    // 4. Initial push
    if (_lastPushedData.isEmpty) {
      return true;
    }

    return false;
  }

  Future<void> _performPush(
    String userId,
    Map<String, dynamic> data, {
    required bool isHeartbeat,
  }) async {
    try {
      final syncData = {
        'activityLevel': data['activityLevel'] ?? 0.0,
        'hyperactivityIndex': data['hyperactivityIndex'] ?? 0.0,
        'movementIntensity': data['movementIntensity'] ?? 0.0,
        'temperature': data['temperature'] ?? 0.0,
        'postureAngle': data['postureAngle'] ?? 0.0,
        'batteryLevel': data['batteryLevel'] ?? 100,
        'alertCount': data['alertCount'] ?? 0,
        'sessionTime': data['sessionTime'] ?? 0,
        'calmnessPeriod': data['calmnessPeriod'] ?? 0.0,
        'watchConnected': _bleService.isConnected,
        'lastUpdate': ServerValue.timestamp,
      };

      await _database.ref('liveState/$userId').set(syncData);

      _lastPushedData = Map.from(data);
      _lastPushedData['watchConnected'] = _bleService.isConnected;
      _lastPushTime = DateTime.now();

      _logger.i(
        "✅ Push SUCCESS to liveState/$userId (${isHeartbeat ? 'Heartbeat' : 'Reactive'})",
      );
    } catch (e) {
      _logger.e("❌ Push FAILURE to RTDB: $e");
    }
  }
}
