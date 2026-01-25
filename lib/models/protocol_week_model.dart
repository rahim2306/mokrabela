import 'package:cloud_firestore/cloud_firestore.dart';

class ProtocolWeek {
  final String childId;
  final int weekIndex;
  final DateTime startDate;
  final DateTime endDate;
  final bool isUnlocked;
  final bool isCompleted;
  final int activitiesCompleted;
  final int totalDuration; // in seconds
  final Map<String, dynamic> biometrics;
  final String reportStatus; // pending, generated

  ProtocolWeek({
    required this.childId,
    required this.weekIndex,
    required this.startDate,
    required this.endDate,
    this.isUnlocked = false,
    this.isCompleted = false,
    this.activitiesCompleted = 0,
    this.totalDuration = 0,
    this.biometrics = const {},
    this.reportStatus = 'pending',
  });

  factory ProtocolWeek.fromMap(Map<String, dynamic> data) {
    return ProtocolWeek(
      childId: data['childId'] ?? '',
      weekIndex: data['weekIndex'] ?? 1,
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: (data['endDate'] as Timestamp).toDate(),
      isUnlocked: data['isUnlocked'] ?? false,
      isCompleted: data['isCompleted'] ?? false,
      activitiesCompleted: data['totals']?['activitiesCompleted'] ?? 0,
      totalDuration: data['totals']?['totalDuration'] ?? 0,
      biometrics: Map<String, dynamic>.from(data['biometrics'] ?? {}),
      reportStatus: data['reportStatus'] ?? 'pending',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'childId': childId,
      'weekIndex': weekIndex,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'isUnlocked': isUnlocked,
      'isCompleted': isCompleted,
      'totals': {
        'activitiesCompleted': activitiesCompleted,
        'totalDuration': totalDuration,
      },
      'biometrics': biometrics,
      'reportStatus': reportStatus,
    };
  }
}
