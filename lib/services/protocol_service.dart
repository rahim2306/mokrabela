import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mokrabela/models/protocol_enrollment_model.dart';
import 'package:mokrabela/models/protocol_week_model.dart';

/// Service for managing protocol progress in Firestore
class ProtocolService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Update protocol progress for a child

  /// Checks if the progress was last updated on a different day and resets if so.
  /// This is useful to call when the user first enters the protocol hub.
  // Method checkAndResetDailyProgress removed as protocolProgress is deprecated

  /// Get protocol progress stream for a child
  // Methods getProgressStream and resetProgress removed as protocolProgress is deprecated

  // --- 6-Week Protocol Extensions ---

  /// Ensures a child is enrolled in the protocol. Initialized if not found.
  Future<ProtocolEnrollment> ensureEnrollment(String childId) async {
    final enrollmentRef = _firestore
        .collection('protocolEnrollments')
        .doc(childId);
    final doc = await enrollmentRef.get();

    if (doc.exists) {
      return ProtocolEnrollment.fromMap(doc.data()!);
    } else {
      final now = DateTime.now();
      final enrollment = ProtocolEnrollment(
        childId: childId,
        startDate: now,
        endDate: now.add(const Duration(days: 35)), // 5 weeks
        currentWeek: 1,
        status: ProtocolStatus.active,
      );

      await enrollmentRef.set(enrollment.toMap());
      return enrollment;
    }
  }

  /// Get enrollment stream for real-time week tracking
  Stream<ProtocolEnrollment?> getEnrollmentStream(String childId) {
    return _firestore
        .collection('protocolEnrollments')
        .doc(childId)
        .snapshots()
        .map(
          (doc) => doc.exists ? ProtocolEnrollment.fromMap(doc.data()!) : null,
        );
  }

  /// Update the cached current week in enrollment
  Future<void> updateCachedWeek(String childId, int weekIndex) async {
    await _firestore.collection('protocolEnrollments').doc(childId).update({
      'currentWeek': weekIndex,
    });
  }

  /// Fetch snapshots for all 6 weeks
  Stream<List<ProtocolWeek>> getWeeklySnapshotsStream(String childId) {
    return _firestore
        .collection('protocolWeeks')
        .where('childId', isEqualTo: childId)
        .orderBy('weekIndex')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ProtocolWeek.fromMap(doc.data()))
              .toList(),
        );
  }

  /// FOR TESTING ONLY: Force set start date to simulate week progression
  Future<void> debugForceWeek(String childId, int weekIndex) async {
    final now = DateTime.now();
    final daysBack = (weekIndex - 1) * 7;
    final newStartDate = now.subtract(Duration(days: daysBack));

    await _firestore.collection('protocolEnrollments').doc(childId).update({
      'startDate': Timestamp.fromDate(newStartDate),
      'currentWeek': weekIndex,
    });
  }
}
