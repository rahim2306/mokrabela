import 'package:cloud_firestore/cloud_firestore.dart';

enum ProtocolStatus { active, completed, stopped }

class ProtocolEnrollment {
  final String childId;
  final DateTime startDate;
  final DateTime endDate;
  final int currentWeek;
  final ProtocolStatus status;
  final DateTime? completedAt;

  ProtocolEnrollment({
    required this.childId,
    required this.startDate,
    required this.endDate,
    this.currentWeek = 1,
    this.status = ProtocolStatus.active,
    this.completedAt,
  });

  factory ProtocolEnrollment.fromMap(Map<String, dynamic> data) {
    return ProtocolEnrollment(
      childId: data['childId'] ?? '',
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: (data['endDate'] as Timestamp).toDate(),
      currentWeek: data['currentWeek'] ?? 1,
      status: ProtocolStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => ProtocolStatus.active,
      ),
      completedAt: data['completedAt'] != null
          ? (data['completedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'childId': childId,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'currentWeek': currentWeek,
      'status': status.name,
      if (completedAt != null) 'completedAt': Timestamp.fromDate(completedAt!),
    };
  }

  /// Derives current week index based on [now] comparison with [startDate].
  int calculateCurrentWeek(DateTime now) {
    final difference = now.difference(startDate).inDays;
    final week = (difference / 7).floor() + 1;
    if (week < 1) return 1;
    if (week > 5) return 5;
    return week;
  }
}
