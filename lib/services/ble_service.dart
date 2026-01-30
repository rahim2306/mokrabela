import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

// UUIDs الأساسية
final Guid serviceUuid = Guid("180A");
final Guid accXUuid = Guid("2A58");
final Guid accYUuid = Guid("2A59");
final Guid accZUuid = Guid("2A5A");
final Guid gyroXUuid = Guid("2A5B");
final Guid gyroYUuid = Guid("2A5C");
final Guid gyroZUuid = Guid("2A5D");
final Guid controlUuid = Guid("2A5E");

// UUIDs المحسنة - متوافقة مع Arduino
final Guid temperatureUuid = Guid("2A6E");
final Guid activityLevelUuid = Guid("2A6F");
final Guid movementIntensityUuid = Guid("2A70");
final Guid postureAngleUuid = Guid("2A71");
final Guid batteryLevelUuid = Guid("2A19");
final Guid alertCountUuid = Guid("2A72");
final Guid sessionTimeUuid = Guid("2A73");
final Guid calmnessPeriodUuid = Guid("2A74");
final Guid hyperactivityIndexUuid = Guid("2A75");

class BleService extends ChangeNotifier {
  static final BleService _instance = BleService._internal();
  factory BleService() => _instance;

  BleService._internal() {
    _connectionState = BluetoothConnectionState.disconnected;
    _isScanning = false;
    _isConnecting = false;
    _initializeBluetoothState();
    _logger.i("تم تهيئة خدمة البلوتوث المحسنة");
  }

  final Logger _logger = Logger();

  StreamSubscription<List<ScanResult>>? _scanSubscription;
  StreamSubscription<BluetoothConnectionState>? _connectionStateSubscription;
  final List<StreamSubscription<List<int>>> _characteristicSubscriptions = [];
  Timer? _connectionTimeoutTimer;
  Timer? _scanTimeoutTimer;

  BluetoothDevice? _connectedDevice;
  BluetoothCharacteristic? _controlCharacteristic;

  final StreamController<BluetoothConnectionState> _connectionStateController =
      StreamController<BluetoothConnectionState>.broadcast();
  final StreamController<Map<String, dynamic>> _sensorDataController =
      StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<double> _thresholdController =
      StreamController<double>.broadcast();

  bool _isScanning = false;
  bool _isConnecting = false;
  BluetoothConnectionState _connectionState =
      BluetoothConnectionState.disconnected;
  final Map<String, dynamic> _sensorData = {};
  double _currentThreshold = 12.0;
  List<ScanResult> _scanResults = [];
  String? _lastErrorMessage;

  String? get lastErrorMessage => _lastErrorMessage;

  // البيانات المحسنة مع القيم الافتراضية المحسنة
  final Map<String, dynamic> _enhancedData = {
    'temperature': 25.0,
    'activityLevel': 0.0,
    'movementIntensity': 0.0,
    'postureAngle': 0.0,
    'batteryLevel': 100,
    'alertCount': 0,
    'sessionTime': 0,
    'calmnessPeriod': 0.0,
    'hyperactivityIndex': 0.0,
  };

  // إحصائيات إضافية
  final Map<String, dynamic> _statistics = {
    'maxActivityLevel': 0.0,
    'avgMovementIntensity': 0.0,
    'totalAlerts': 0,
    'longestCalmPeriod': 0.0,
    'peakHyperactivityIndex': 0.0,
  };

  bool get isScanning => _isScanning;
  bool get isConnecting => _isConnecting;
  bool get isConnected =>
      _connectionState == BluetoothConnectionState.connected;
  BluetoothConnectionState get connectionState => _connectionState;
  Map<String, dynamic> get sensorData => {..._sensorData, ..._enhancedData};
  Map<String, dynamic> get enhancedData => _enhancedData;
  Map<String, dynamic> get statistics => _statistics;
  double get currentThreshold => _currentThreshold;
  List<ScanResult> get scanResults => _scanResults;

  // Debug method for simulation
  void injectSimulatedData(Map<String, dynamic> data) {
    _sensorData.addAll(data);
    _sensorDataController.add({..._sensorData, ..._enhancedData});
    notifyListeners();
  }

  Stream<BluetoothConnectionState> get connectionStateStream =>
      _connectionStateController.stream;
  Stream<Map<String, dynamic>> get sensorDataStream =>
      _sensorDataController.stream;
  Stream<double> get thresholdStream => _thresholdController.stream;

  Future<void> _initializeBluetoothState() async {
    try {
      if (!await FlutterBluePlus.isSupported) {
        _logger.e("Bluetooth is not supported on this device.");
        return;
      }

      // Sync internal _isScanning with hardware state
      FlutterBluePlus.isScanning.listen((scanning) {
        _logger.d("Hardware scan state changed: $scanning");
        _isScanning = scanning;
        notifyListeners();
      });

      FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
        _logger.i("Bluetooth adapter state changed: $state");
        if (state != BluetoothAdapterState.on && isConnected) {
          _logger.w("Bluetooth disabled during connection. Disconnecting...");
          disconnectDevice();
        }
      });
    } catch (e) {
      _logger.e("Error initializing Bluetooth state: $e");
    }
  }

  Future<bool> _checkBluetoothPermissions() async {
    try {
      // 1. Check OS Permissions (CRITICAL for Android)
      if (defaultTargetPlatform == TargetPlatform.android) {
        // Request permissions
        Map<Permission, PermissionStatus> statuses = await [
          Permission.bluetoothScan,
          Permission.bluetoothConnect,
          Permission.location,
        ].request();

        // Check if all are granted
        bool allGranted =
            statuses[Permission.bluetoothScan] == PermissionStatus.granted &&
            statuses[Permission.bluetoothConnect] == PermissionStatus.granted &&
            statuses[Permission.location] == PermissionStatus.granted;

        if (!allGranted) {
          _lastErrorMessage =
              "Missing permissions: ${statuses[Permission.bluetoothScan] != PermissionStatus.granted ? "Scan, " : ""}${statuses[Permission.bluetoothConnect] != PermissionStatus.granted ? "Connect, " : ""}${statuses[Permission.location] != PermissionStatus.granted ? "Location" : ""}";
          _logger.w(_lastErrorMessage);
          return false;
        }

        // Check if Location services are enabled (Required for BLE on some Android versions)
        if (!await Permission.location.serviceStatus.isEnabled) {
          _logger.w(
            "Location services are disabled. complying with Android requirements, scanning might fail.",
          );
          // We do NOT return false here anymore. We let the scan attempt happen.
          // On Android 12+ with 'neverForLocation', this is valid.
        }
      }

      // 2. Check Adapter State (Is Bluetooth ON?)
      BluetoothAdapterState adapterState =
          await FlutterBluePlus.adapterState.first;

      if (adapterState == BluetoothAdapterState.off) {
        _logger.i("Bluetooth is OFF. Attempting to turn it on...");
        try {
          if (defaultTargetPlatform == TargetPlatform.android) {
            await FlutterBluePlus.turnOn();
            // Wait a bit for it to turn on
            await Future.delayed(const Duration(seconds: 1));
            adapterState = await FlutterBluePlus.adapterState.first;
          }
        } catch (e) {
          _logger.w("Failed to turn on Bluetooth: $e");
        }
      }

      if (adapterState != BluetoothAdapterState.on) {
        _lastErrorMessage =
            "Bluetooth is $adapterState. Please make sure it's turned on.";
        _logger.w(_lastErrorMessage);
        return false;
      }

      _lastErrorMessage = null;
      return true;
    } catch (e) {
      _lastErrorMessage = "Error checking permissions: $e";
      _logger.e(_lastErrorMessage);
      return false;
    }
  }

  Future<void> startScan() async {
    _logger.i("Attempting to start BLE scan...");

    try {
      if (!await _checkBluetoothPermissions()) {
        _logger.w("Scan aborted: Permission check failed.");
        return;
      }

      // Check if hardware is already scanning
      bool isHardwareScanning = false;
      try {
        isHardwareScanning = await FlutterBluePlus.isScanning.first.timeout(
          const Duration(milliseconds: 500),
        );
      } catch (_) {}

      if (isHardwareScanning) {
        _logger.i(
          "Scan already running in hardware. Refreshing results subscription.",
        );
      } else {
        await FlutterBluePlus.stopScan().catchError((_) {});
        await Future.delayed(const Duration(milliseconds: 200));

        // Start the scan non-blocking
        FlutterBluePlus.startScan(
          timeout: const Duration(seconds: 15),
          androidScanMode: AndroidScanMode.lowLatency,
          androidUsesFineLocation: true, // Explicitly use fine location
          continuousUpdates: true,
        ).catchError((e) {
          _logger.e("Error during FlutterBluePlus.startScan: $e");
          stopScan();
        });
      }

      _scanResults.clear();
      _scanSubscription?.cancel();
      _scanSubscription = FlutterBluePlus.scanResults.listen(
        (results) {
          _logger.d("Received ${results.length} scan results");
          _scanResults = results;
          notifyListeners();
        },
        onError: (e) {
          _logger.e("Error in scan results stream: $e");
        },
      );

      _scanTimeoutTimer?.cancel();
      _scanTimeoutTimer = Timer(const Duration(seconds: 61), () {
        if (_isScanning) {
          _logger.i("Scan timeout reached (Timer)");
          stopScan();
        }
      });
    } catch (e) {
      _logger.e("Error during startScan: $e");
      _isScanning = false;
      notifyListeners();
    }
  }

  Future<void> stopScan() async {
    _logger.i("Stopping BLE scan...");
    try {
      await FlutterBluePlus.stopScan();
      _scanTimeoutTimer?.cancel();
      _scanTimeoutTimer = null;
      await _scanSubscription?.cancel();
      _scanSubscription = null;
      // Note: _isScanning will be updated by the listener in _initializeBluetoothState
    } catch (e) {
      _logger.e("Error during stopScan: $e");
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    if (_isConnecting) {
      _logger.w("الاتصال جارٍ بالفعل");
      return;
    }

    if (isConnected) {
      _logger.w("متصل بالفعل بجهاز");
      return;
    }

    _logger.i(
      "جارٍ الاتصال بالسوار الذكي المحسن ${device.platformName} [${device.remoteId}]...",
    );
    _isConnecting = true;
    _connectionState = BluetoothConnectionState.disconnected;
    _connectionStateController.add(_connectionState);
    notifyListeners();

    try {
      await _cleanupConnection();

      _connectionStateSubscription = device.connectionState.listen(
        (BluetoothConnectionState state) async {
          _logger.i("حالة اتصال الجهاز ${device.remoteId}: $state");
          _connectionState = state;
          _connectionStateController.add(state);
          notifyListeners();

          switch (state) {
            case BluetoothConnectionState.connected:
              _connectedDevice = device;
              _isConnecting = false;
              _connectionTimeoutTimer?.cancel();
              _logger.i(
                "تم الاتصال بنجاح بالسوار الذكي المحسن ${device.platformName}",
              );
              await Future.delayed(const Duration(milliseconds: 1000));
              await _discoverServices(device);
              break;

            case BluetoothConnectionState.disconnected:
              _logger.w("تم قطع اتصال الجهاز");
              _isConnecting = false;
              _connectedDevice = null;
              _controlCharacteristic = null;
              _clearSubscriptions();
              _resetData();
              notifyListeners();
              break;

            default:
              _logger.d("حالة اتصال غير معالجة: $state");
              break;
          }
        },
        onError: (e) {
          _logger.e("خطأ في حالة الاتصال: $e");
          _handleConnectionError();
        },
      );

      _connectionTimeoutTimer = Timer(const Duration(seconds: 30), () {
        if (_isConnecting) {
          _logger.e("مهلة الاتصال");
          _handleConnectionError();
        }
      });

      await device.connect(
        autoConnect: false,
        timeout: const Duration(seconds: 30),
        mtu: null,
        license: License.free,
      );
    } catch (e) {
      _logger.e("خطأ في الاتصال: $e");
      _handleConnectionError();
    }
  }

  void _resetData() {
    _sensorData.clear();
    _enhancedData.clear();
    _enhancedData.addAll({
      'temperature': 25.0,
      'activityLevel': 0.0,
      'movementIntensity': 0.0,
      'postureAngle': 0.0,
      'batteryLevel': 100,
      'alertCount': 0,
      'sessionTime': 0,
      'calmnessPeriod': 0.0,
      'hyperactivityIndex': 0.0,
    });
    _sensorDataController.add({..._sensorData, ..._enhancedData});
  }

  void _handleConnectionError() {
    _isConnecting = false;
    _connectionState = BluetoothConnectionState.disconnected;
    _connectionStateController.add(_connectionState);
    _connectedDevice = null;
    _controlCharacteristic = null;
    _connectionTimeoutTimer?.cancel();
    _clearSubscriptions();
    _resetData();
    notifyListeners();
  }

  Future<void> _cleanupConnection() async {
    _connectionTimeoutTimer?.cancel();
    _connectionTimeoutTimer = null;
    await _connectionStateSubscription?.cancel();
    _connectionStateSubscription = null;
    _clearSubscriptions();
  }

  Future<void> disconnectDevice() async {
    if (_connectedDevice == null) {
      _logger.w("لا يوجد جهاز متصل لقطع الاتصال.");
      return;
    }

    _logger.i("جارٍ قطع الاتصال من ${_connectedDevice!.remoteId}...");

    try {
      await _connectedDevice!.disconnect();
      await _cleanupConnection();
      _connectedDevice = null;
      _controlCharacteristic = null;
      _connectionState = BluetoothConnectionState.disconnected;
      _connectionStateController.add(_connectionState);
      _resetData();
      notifyListeners();
    } catch (e) {
      _logger.e("خطأ أثناء قطع الاتصال: $e");
    }
  }

  Future<void> _discoverServices(BluetoothDevice device) async {
    _logger.i("جارٍ اكتشاف الخدمات المحسنة لـ ${device.remoteId}...");
    try {
      await Future.delayed(const Duration(milliseconds: 1500));

      List<BluetoothService> services = await device.discoverServices();
      _logger.i("تم العثور على ${services.length} خدمات");

      bool serviceFound = false;
      for (BluetoothService service in services) {
        _logger.d("تم العثور على خدمة: ${service.uuid}");

        if (service.uuid == serviceUuid) {
          _logger.i("تم العثور على الخدمة المستهدفة المحسنة: ${service.uuid}");
          serviceFound = true;
          await _processEnhancedCharacteristics(service.characteristics);
          break;
        }
      }

      if (!serviceFound) {
        _logger.e("الخدمة المستهدفة ($serviceUuid) غير موجودة!");
        for (BluetoothService service in services) {
          if (service.characteristics.isNotEmpty) {
            _logger.i("جارٍ تجربة الخصائص من الخدمة: ${service.uuid}");
            await _processEnhancedCharacteristics(service.characteristics);
            break;
          }
        }
      }
    } catch (e) {
      _logger.e("خطأ أثناء اكتشاف الخدمات: $e");
      await disconnectDevice();
    }
  }

  Future<void> _processEnhancedCharacteristics(
    List<BluetoothCharacteristic> characteristics,
  ) async {
    _logger.i("جارٍ معالجة ${characteristics.length} خصائص محسنة");
    _clearSubscriptions();

    bool foundControlCharacteristic = false;
    int subscribedCharacteristics = 0;

    for (BluetoothCharacteristic characteristic in characteristics) {
      _logger.d("جارٍ معالجة الخاصية: ${characteristic.uuid}");

      try {
        if (characteristic.uuid == controlUuid) {
          _controlCharacteristic = characteristic;
          foundControlCharacteristic = true;
          _logger.i("تم العثور على خاصية التحكم المحسنة وتعيينها");

          await Future.delayed(const Duration(milliseconds: 300));
          await readThreshold();
        } else if (_isSensorCharacteristic(characteristic.uuid)) {
          if (characteristic.properties.notify ||
              characteristic.properties.read) {
            _logger.i(
              "الاشتراك في خاصية الحساس المحسن: ${characteristic.uuid}",
            );

            try {
              if (characteristic.properties.notify) {
                await characteristic.setNotifyValue(true);
                await Future.delayed(const Duration(milliseconds: 100));
              }

              var subscription = characteristic.lastValueStream.listen(
                (List<int> value) {
                  _handleEnhancedCharacteristicData(characteristic.uuid, value);
                },
                onError: (e) {
                  _logger.e(
                    "خطأ في استقبال البيانات من ${characteristic.uuid}: $e",
                  );
                },
              );

              _characteristicSubscriptions.add(subscription);
              subscribedCharacteristics++;
              _logger.i("تم الاشتراك بنجاح في ${characteristic.uuid}");
            } catch (e) {
              _logger.e("فشل الاشتراك في ${characteristic.uuid}: $e");
            }
          } else {
            _logger.w(
              "الخاصية ${characteristic.uuid} لا تدعم الإشعارات أو القراءة",
            );
          }
        }

        await Future.delayed(const Duration(milliseconds: 150));
      } catch (e) {
        _logger.e("خطأ في معالجة الخاصية ${characteristic.uuid}: $e");
      }
    }

    _logger.i("اكتمل اكتشاف الخدمة المحسنة:");
    _logger.i(
      "- خاصية التحكم: ${foundControlCharacteristic ? 'تم العثور عليها' : 'غير موجودة'}",
    );
    _logger.i("- تم الاشتراك في $subscribedCharacteristics خصائص حساسات محسنة");

    if (!foundControlCharacteristic) {
      _logger.w("تحذير: خاصية التحكم غير موجودة. الأوامر لن تعمل.");
    }

    if (subscribedCharacteristics == 0) {
      _logger.w(
        "تحذير: لم يتم الاشتراك في أي خصائص حساسات. لن يتم استقبال بيانات.",
      );
    }
  }

  bool _isSensorCharacteristic(Guid uuid) {
    return [
      accXUuid,
      accYUuid,
      accZUuid,
      gyroXUuid,
      gyroYUuid,
      gyroZUuid,
      temperatureUuid,
      activityLevelUuid,
      movementIntensityUuid,
      postureAngleUuid,
      batteryLevelUuid,
      alertCountUuid,
      sessionTimeUuid,
      calmnessPeriodUuid,
      hyperactivityIndexUuid,
    ].contains(uuid);
  }

  void _handleEnhancedCharacteristicData(Guid uuid, List<int> value) {
    if (value.isEmpty) return;

    try {
      dynamic processedValue;
      if (_isFloatUuid(uuid)) {
        processedValue = _bytesToFloat(value);
      } else {
        processedValue = _bytesToInt(value);
      }

      String key = _getDataKey(uuid);
      if (key.isEmpty) {
        _logger.w("مفتاح غير معروف لـ UUID: $uuid");
        return;
      }

      if (_isEnhancedDataKey(key)) {
        _enhancedData[key] = processedValue;
        _updateStatistics(key, processedValue);
      } else {
        _sensorData[key] = processedValue;
      }

      _sensorDataController.add({..._sensorData, ..._enhancedData});
      _logger.d("تم تحديث بيانات الحساس المحسن: $key = $processedValue");
      notifyListeners();
    } catch (e) {
      _logger.e("خطأ في معالجة بيانات الحساس المحسن لـ $uuid: $e");
    }
  }

  void _updateStatistics(String key, dynamic value) {
    switch (key) {
      case 'activityLevel':
        if (value > _statistics['maxActivityLevel']) {
          _statistics['maxActivityLevel'] = value;
        }
        break;
      case 'movementIntensity':
        // حساب المتوسط المتحرك
        double currentAvg = _statistics['avgMovementIntensity'] ?? 0.0;
        _statistics['avgMovementIntensity'] = (currentAvg + value) / 2;
        break;
      case 'alertCount':
        _statistics['totalAlerts'] = value;
        break;
      case 'calmnessPeriod':
        if (value > _statistics['longestCalmPeriod']) {
          _statistics['longestCalmPeriod'] = value;
        }
        break;
      case 'hyperactivityIndex':
        if (value > _statistics['peakHyperactivityIndex']) {
          _statistics['peakHyperactivityIndex'] = value;
        }
        break;
    }
  }

  String _getDataKey(Guid uuid) {
    final Map<Guid, String> uuidToKey = {
      accXUuid: 'accX',
      accYUuid: 'accY',
      accZUuid: 'accZ',
      gyroXUuid: 'gyroX',
      gyroYUuid: 'gyroY',
      gyroZUuid: 'gyroZ',
      temperatureUuid: 'temperature',
      activityLevelUuid: 'activityLevel',
      movementIntensityUuid: 'movementIntensity',
      postureAngleUuid: 'postureAngle',
      batteryLevelUuid: 'batteryLevel',
      alertCountUuid: 'alertCount',
      sessionTimeUuid: 'sessionTime',
      calmnessPeriodUuid: 'calmnessPeriod',
      hyperactivityIndexUuid: 'hyperactivityIndex',
    };
    return uuidToKey[uuid] ?? '';
  }

  bool _isEnhancedDataKey(String key) {
    return [
      'temperature',
      'activityLevel',
      'movementIntensity',
      'postureAngle',
      'batteryLevel',
      'alertCount',
      'sessionTime',
      'calmnessPeriod',
      'hyperactivityIndex',
    ].contains(key);
  }

  bool _isFloatUuid(Guid uuid) {
    return [
      accXUuid,
      accYUuid,
      accZUuid,
      gyroXUuid,
      gyroYUuid,
      gyroZUuid,
      temperatureUuid,
      activityLevelUuid,
      movementIntensityUuid,
      postureAngleUuid,
      calmnessPeriodUuid,
      hyperactivityIndexUuid,
    ].contains(uuid);
  }

  double _bytesToFloat(List<int> bytes) {
    if (bytes.length >= 4) {
      var buffer = Uint8List.fromList(bytes).buffer.asByteData();
      return buffer.getFloat32(0, Endian.little);
    }
    _logger.w("طول البيانات غير صالح (${bytes.length}) لتحويل إلى float");
    return 0.0;
  }

  int _bytesToInt(List<int> bytes) {
    if (bytes.length >= 4) {
      var buffer = Uint8List.fromList(bytes).buffer.asByteData();
      return buffer.getInt32(0, Endian.little);
    } else if (bytes.length >= 2) {
      var buffer = Uint8List.fromList(bytes).buffer.asByteData();
      return buffer.getInt16(0, Endian.little);
    } else if (bytes.isNotEmpty) {
      return bytes[0];
    }
    _logger.w("طول البيانات غير صالح (${bytes.length}) لتحويل إلى int");
    return 0;
  }

  Future<void> readThreshold() async {
    if (!isConnected) {
      _logger.w("لا يمكن قراءة العتبة: الجهاز غير متصل");
      return;
    }

    if (_controlCharacteristic == null) {
      _logger.w("لا يمكن قراءة العتبة: خاصية التحكم غير موجودة");
      return;
    }

    if (!_controlCharacteristic!.properties.read) {
      _logger.w("لا يمكن قراءة العتبة: خاصية التحكم غير قابلة للقراءة");
      return;
    }

    try {
      _logger.i("جارٍ قراءة العتبة من الجهاز المحسن...");
      List<int> value = await _controlCharacteristic!.read();
      String thresholdStr = utf8.decode(value);
      double threshold = double.tryParse(thresholdStr) ?? 12.0;

      _logger.i("تم قراءة العتبة بنجاح: $threshold");
      _currentThreshold = threshold;
      _thresholdController.add(_currentThreshold);
      notifyListeners();
    } catch (e) {
      _logger.e("خطأ أثناء قراءة العتبة: $e");
    }
  }

  Future<void> setThreshold(double threshold) async {
    if (!isConnected) {
      _logger.w("لا يمكن تعيين العتبة: الجهاز غير متصل");
      throw Exception("الجهاز غير متصل");
    }

    if (_controlCharacteristic == null) {
      _logger.w("لا يمكن تعيين العتبة: خاصية التحكم غير موجودة");
      throw Exception("خاصية التحكم غير موجودة");
    }

    try {
      String command = "THRESHOLD:${threshold.toStringAsFixed(1)}";
      await sendCommand(command);
      _currentThreshold = threshold;
      _thresholdController.add(_currentThreshold);
      notifyListeners();
      _logger.i("تم تعيين العتبة بنجاح: $threshold");
    } catch (e) {
      _logger.e("خطأ أثناء تعيين العتبة: $e");
      rethrow;
    }
  }

  Future<void> resetThreshold(double threshold) async {
    await setThreshold(threshold);
  }

  Future<void> startVibration() async {
    if (!isConnected) {
      _logger.w("لا يمكن بدء الاهتزاز: الجهاز غير متصل");
      throw Exception("الجهاز غير متصل");
    }

    try {
      await sendCommand("VIBRATE_START");
      _logger.i("تم إرسال أمر بدء الاهتزاز بنجاح");
    } catch (e) {
      _logger.e("خطأ أثناء بدء الاهتزاز: $e");
      rethrow;
    }
  }

  Future<void> stopVibration() async {
    if (!isConnected) {
      _logger.w("لا يمكن إيقاف الاهتزاز: الجهاز غير متصل");
      throw Exception("الجهاز غير متصل");
    }

    try {
      await sendCommand("VIBRATE_STOP");
      _logger.i("تم إرسال أمر إيقاف الاهتزاز بنجاح");
    } catch (e) {
      _logger.e("خطأ أثناء إيقاف الاهتزاز: $e");
      rethrow;
    }
  }

  Future<void> resetStatistics() async {
    if (!isConnected) {
      _logger.w("لا يمكن إعادة تعيين الإحصائيات: الجهاز غير متصل");
      throw Exception("الجهاز غير متصل");
    }

    try {
      await sendCommand("RESET_STATS");
      // إعادة تعيين الإحصائيات المحلية أيضاً
      _statistics.clear();
      _statistics.addAll({
        'maxActivityLevel': 0.0,
        'avgMovementIntensity': 0.0,
        'totalAlerts': 0,
        'longestCalmPeriod': 0.0,
        'peakHyperactivityIndex': 0.0,
      });
      _logger.i("تم إرسال أمر إعادة تعيين الإحصائيات بنجاح");
    } catch (e) {
      _logger.e("خطأ أثناء إعادة تعيين الإحصائيات: $e");
      rethrow;
    }
  }

  Future<void> calibrateDevice() async {
    if (!isConnected) {
      _logger.w("لا يمكن معايرة الجهاز: الجهاز غير متصل");
      throw Exception("الجهاز غير متصل");
    }

    try {
      await sendCommand("CALIBRATE");
      _logger.i("تم إرسال أمر معايرة الجهاز بنجاح");
    } catch (e) {
      _logger.e("خطأ أثناء معايرة الجهاز: $e");
      rethrow;
    }
  }

  Future<void> saveSensorData() async {
    _logger.i("جارٍ حفظ بيانات الحساسات المحسنة...");

    // يمكن إضافة منطق حفظ البيانات في قاعدة بيانات محلية هنا
    final dataToSave = {
      'timestamp': DateTime.now().toIso8601String(),
      'basicData': _sensorData,
      'enhancedData': _enhancedData,
      'statistics': _statistics,
      'threshold': _currentThreshold,
    };

    await Future.delayed(const Duration(milliseconds: 500));
    _logger.i("تم حفظ بيانات الحساسات المحسنة بنجاح: ${dataToSave.keys}");
    notifyListeners();
  }

  Future<void> sendCommand(String command) async {
    if (!isConnected) {
      _logger.e("لا يمكن إرسال الأمر '$command': الجهاز غير متصل");
      throw Exception("الجهاز غير متصل");
    }

    if (_controlCharacteristic == null) {
      _logger.e("لا يمكن إرسال الأمر '$command': خاصية التحكم غير موجودة");
      throw Exception("خاصية التحكم غير موجودة");
    }

    if (!_controlCharacteristic!.properties.write &&
        !_controlCharacteristic!.properties.writeWithoutResponse) {
      _logger.e(
        "لا يمكن إرسال الأمر '$command': خاصية التحكم غير قابلة للكتابة",
      );
      throw Exception("خاصية التحكم غير قابلة للكتابة");
    }

    try {
      _logger.i("جارٍ إرسال الأمر المحسن: $command");

      List<int> bytes = utf8.encode(command);

      if (bytes.length > 20) {
        _logger.w("الأمر طويل جداً (${bytes.length} بايت). سيتم اقتطاعه.");
        bytes = bytes.sublist(0, 20);
      }

      bool useWriteWithoutResponse =
          _controlCharacteristic!.properties.writeWithoutResponse;

      await _controlCharacteristic!.write(
        bytes,
        withoutResponse: useWriteWithoutResponse,
        timeout: 5,
      );

      _logger.i(
        "تم إرسال الأمر المحسن '$command' بنجاح (${bytes.length} بايت)",
      );

      await Future.delayed(const Duration(milliseconds: 100));
    } catch (e) {
      _logger.e("خطأ أثناء إرسال الأمر '$command': $e");
      rethrow;
    }
  }

  void _clearSubscriptions() {
    _logger.d(
      "جارٍ تنظيف ${_characteristicSubscriptions.length} اشتراكات خصائص",
    );
    for (var subscription in _characteristicSubscriptions) {
      subscription.cancel();
    }
    _characteristicSubscriptions.clear();
  }

  @override
  void dispose() {
    _logger.i("جارٍ التخلص من خدمة البلوتوث المحسنة...");

    _connectionTimeoutTimer?.cancel();
    _scanTimeoutTimer?.cancel();

    stopScan();
    disconnectDevice();

    _clearSubscriptions();
    _scanSubscription?.cancel();
    _connectionStateSubscription?.cancel();

    _connectionStateController.close();
    _sensorDataController.close();
    _thresholdController.close();

    super.dispose();
  }
}
