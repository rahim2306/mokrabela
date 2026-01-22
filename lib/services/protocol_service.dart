import 'package:cloud_firestore/cloud_firestore.dart';

/// Service for managing protocol progress in Firestore
class ProtocolService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Update protocol progress for a child
  Future<void> updateProtocolProgress(String childId, int squareNumber) async {
    final progressRef = _firestore.collection('protocolProgress').doc(childId);

    await _firestore.runTransaction((transaction) async {
      final doc = await transaction.get(progressRef);
      final timestamp = FieldValue.serverTimestamp();

      if (doc.exists) {
        final data = doc.data()!;
        final List<int> completed = List<int>.from(
          data['completedSquares'] ?? [],
        );
        if (!completed.contains(squareNumber)) {
          completed.add(squareNumber);
        }

        transaction.update(progressRef, {
          'completedSquares': completed,
          'square${squareNumber}Complete': true,
          'lastUpdated': timestamp,
          'currentSquare': squareNumber,
        });
      } else {
        transaction.set(progressRef, {
          'childId': childId,
          'currentSquare': squareNumber,
          'completedSquares': [squareNumber],
          'square${squareNumber}Complete': true,
          'lastUpdated': timestamp,
          'startedAt': timestamp,
        });
      }
    });
  }

  /// Get protocol progress stream for a child
  Stream<DocumentSnapshot<Map<String, dynamic>>> getProgressStream(
    String childId,
  ) {
    return _firestore.collection('protocolProgress').doc(childId).snapshots();
  }

  /// Reset protocol progress (optional but useful for testing)
  Future<void> resetProgress(String childId) async {
    await _firestore.collection('protocolProgress').doc(childId).delete();
  }
}
