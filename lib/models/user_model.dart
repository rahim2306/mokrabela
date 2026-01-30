import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { child, parent, teacher }

class UserProfile {
  final String? name;
  final int? age;
  final List<String> classroomIds;

  UserProfile({this.name, this.age, this.classroomIds = const []});

  factory UserProfile.fromMap(Map<String, dynamic> data) {
    return UserProfile(
      name: data['name'] as String?,
      age: data['age'] as int?,
      classroomIds: List<String>.from(data['classroomIds'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (name != null) 'name': name,
      if (age != null) 'age': age,
      'classroomIds': classroomIds,
    };
  }
}

class WatchSettings {
  final int stressThreshold;
  final String? deviceId;
  final String? deviceName;
  final bool isConnected;
  final DateTime? lastSync;

  WatchSettings({
    this.stressThreshold = 50,
    this.deviceId,
    this.deviceName,
    this.isConnected = false,
    this.lastSync,
  });

  factory WatchSettings.fromMap(Map<String, dynamic> data) {
    return WatchSettings(
      stressThreshold: data['stressThreshold'] as int? ?? 50,
      deviceId: data['deviceId'] as String?,
      deviceName: data['deviceName'] as String?,
      isConnected: data['isConnected'] as bool? ?? false,
      lastSync: data['lastSync'] is Timestamp
          ? (data['lastSync'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'stressThreshold': stressThreshold,
      if (deviceId != null) 'deviceId': deviceId,
      if (deviceName != null) 'deviceName': deviceName,
      'isConnected': isConnected,
      if (lastSync != null) 'lastSync': Timestamp.fromDate(lastSync!),
    };
  }
}

class AppSettings {
  final int dailyCalmGoalMinutes;
  final String languageCode;

  AppSettings({
    this.dailyCalmGoalMinutes = 30, // Default 30 minutes
    this.languageCode = 'en', // Default English
  });

  factory AppSettings.fromMap(Map<String, dynamic> data) {
    return AppSettings(
      dailyCalmGoalMinutes: data['dailyCalmGoalMinutes'] as int? ?? 30,
      languageCode: data['languageCode'] as String? ?? 'en',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dailyCalmGoalMinutes': dailyCalmGoalMinutes,
      'languageCode': languageCode,
    };
  }
}

class UserModel {
  final String uid;
  final String email; // Stored in Firestore for child accounts
  final UserRole role;
  final UserProfile profile;
  final WatchSettings watchSettings;
  final AppSettings appSettings;

  // Shortcuts for UI convenience
  String get name => profile.name ?? '';

  UserModel({
    required this.uid,
    this.email = '',
    required this.role,
    required this.profile,
    required this.watchSettings,
    required this.appSettings,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return UserModel(
      uid: data['uid'] ?? doc.id,
      email: data['email'] as String? ?? '',
      role: UserRole.values.firstWhere(
        (e) => e.toString().split('.').last == (data['role'] as String?),
        orElse: () => UserRole.child,
      ),
      profile: UserProfile.fromMap(
        data['profile'] as Map<String, dynamic>? ?? {},
      ),
      watchSettings: WatchSettings.fromMap(
        data['watchSettings'] as Map<String, dynamic>? ?? {},
      ),
      appSettings: AppSettings.fromMap(
        data['appSettings'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}
