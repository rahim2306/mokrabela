import 'package:cloud_firestore/cloud_firestore.dart';

class ClassroomModel {
  final String id;
  final String name;
  final String teacherId;
  final List<String> studentIds;
  final String grade;
  final DateTime createdAt;

  ClassroomModel({
    required this.id,
    required this.name,
    required this.teacherId,
    this.studentIds = const [],
    required this.grade,
    required this.createdAt,
  });

  factory ClassroomModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ClassroomModel(
      id: doc.id,
      name: data['name'] as String? ?? 'Untitled Class',
      teacherId: data['teacherId'] as String? ?? '',
      studentIds: List<String>.from(data['studentIds'] ?? []),
      grade: data['grade'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'teacherId': teacherId,
      'studentIds': studentIds,
      'grade': grade,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
