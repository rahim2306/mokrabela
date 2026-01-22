import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/daily_task.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Stream of tasks for a specific child for the current day
  Stream<List<DailyTask>> getTasks(String childId) {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);

    return _firestore
        .collection('tasks')
        .where('childId', isEqualTo: childId)
        .snapshots()
        .map((snapshot) {
          final allTasks = snapshot.docs
              .map((doc) => DailyTask.fromMap(doc.data(), doc.id))
              .toList();

          final now = DateTime.now();
          final startOfToday = DateTime(now.year, now.month, now.day);

          // Filter locally for today's tasks to be 100% robust against Firestore indexing/query issues
          final todayTasks = allTasks
              .where(
                (task) =>
                    task.createdAt.isAfter(startOfToday) ||
                    task.createdAt.isAtSameMomentAs(startOfToday),
              )
              .toList();

          // Sort locally
          todayTasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return todayTasks;
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
