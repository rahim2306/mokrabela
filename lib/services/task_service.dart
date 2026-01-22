import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/daily_task.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Stream of tasks for a specific child for the current day
  Stream<List<DailyTask>> getTasks(String childId) {
    // Get start and end of current day
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return _firestore
        .collection('tasks')
        .where('childId', isEqualTo: childId)
        .where(
          'createdAt',
          isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
        )
        .where('createdAt', isLessThan: Timestamp.fromDate(endOfDay))
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => DailyTask.fromMap(doc.data(), doc.id))
              .toList();
        });
  }

  /// Add a new task
  Future<void> addTask(DailyTask task) async {
    await _firestore.collection('tasks').doc(task.id).set(task.toMap());
  }

  /// Update an existing task (e.g., toggle completion)
  Future<void> updateTask(DailyTask task) async {
    await _firestore.collection('tasks').doc(task.id).update(task.toMap());
  }

  /// Delete a task
  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
  }
}
