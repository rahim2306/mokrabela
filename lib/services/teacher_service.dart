import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mokrabela/models/classroom_model.dart';
import 'package:mokrabela/models/user_model.dart';
import 'package:mokrabela/services/auth_service.dart';

class TeacherService {
  final FirebaseFirestore _firestore;
  final FirebaseDatabase _database;
  final AuthService _authService;

  TeacherService({
    FirebaseFirestore? firestore,
    FirebaseDatabase? database,
    AuthService? authService,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _database = database ?? FirebaseDatabase.instance,
       _authService = authService ?? AuthService();

  /// Fetch all classrooms assigned to the current teacher
  Stream<List<ClassroomModel>> getMyClassrooms() {
    final user = _authService.currentUser;
    if (user == null) return Stream.value([]);

    return _firestore
        .collection('classrooms')
        .where('teacherId', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ClassroomModel.fromFirestore(doc))
              .toList();
        });
  }

  /// Fetch students belonging to a specific classroom
  Stream<List<UserModel>> getStudentsByClassroom(String classroomId) {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'child')
        .where('profile.classroomIds', arrayContains: classroomId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => UserModel.fromFirestore(doc))
              .toList();
        });
  }

  /// Get aggregation helper
  Future<Map<String, dynamic>> getStudentQuickStats(String childId) async {
    // This could fetch week progress or recent session count
    // For MVP, we might just rely on real-time streams in the UI
    return {};
  }

  /// REALTIME: Stream live state from Watch/App (Realtime DB)
  Stream<Map<String, dynamic>?> getStudentLiveState(String childId) {
    return _database.ref('liveState/$childId').onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return null;
      try {
        return Map<String, dynamic>.from(data as Map);
      } catch (e) {
        return null;
      }
    });
  }

  /// DEBUG: Create a classroom with all existing children
  Future<void> createDebugClassroom() async {
    final user = _authService.currentUser;
    if (user == null) return;

    // 1. Fetch all children
    final childrenSnapshot = await _firestore
        .collection('users')
        .where('role', isEqualTo: 'child')
        .get();

    final allChildIds = childrenSnapshot.docs.map((d) => d.id).toList();

    if (allChildIds.isEmpty) return;

    // 2. Create Classroom
    final classroomRef = _firestore.collection('classrooms').doc();
    final debugClassroom = ClassroomModel(
      id: classroomRef.id,
      name: 'Debug Class (${DateTime.now().minute})', // Unique-ish name
      teacherId: user.uid,
      studentIds: allChildIds,
      grade: 'Debug-Grade',
      createdAt: DateTime.now(),
    );

    await classroomRef.set(debugClassroom.toMap());

    // 3. Update each child to be in this classroom
    final batch = _firestore.batch();
    for (final doc in childrenSnapshot.docs) {
      final currentClassrooms = List<String>.from(
        doc.data()['profile']?['classroomIds'] ?? [],
      );
      if (!currentClassrooms.contains(classroomRef.id)) {
        currentClassrooms.add(classroomRef.id);
        batch.update(doc.reference, {
          'profile.classroomIds': currentClassrooms,
        });
      }
    }
    await batch.commit();
  }
}
