import 'package:cloud_firestore/cloud_firestore.dart';

class DailyTask {
  final String id;
  final String childId;
  final String title;
  final bool isCompleted;
  final DateTime? completedAt;
  final DateTime createdAt;

  DailyTask({
    required this.id,
    required this.childId,
    required this.title,
    this.isCompleted = false,
    this.completedAt,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'childId': childId,
      'title': title,
      'isCompleted': isCompleted,
      'completedAt': completedAt != null
          ? Timestamp.fromDate(completedAt!)
          : null,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory DailyTask.fromMap(Map<String, dynamic> map, String id) {
    return DailyTask(
      id: id,
      childId: map['childId'] ?? '',
      title: map['title'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      completedAt: map['completedAt'] != null
          ? (map['completedAt'] as Timestamp).toDate()
          : null,
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  DailyTask copyWith({
    String? childId,
    String? title,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return DailyTask(
      id: id,
      childId: childId ?? this.childId,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt,
    );
  }
}
