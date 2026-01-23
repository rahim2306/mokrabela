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
      final now = DateTime.now();

      if (doc.exists) {
        final data = doc.data()!;
        final Timestamp? lastUpdated = data['lastUpdated'] as Timestamp?;

        bool isNewDay = false;
        if (lastUpdated != null) {
          final lastDate = lastUpdated.toDate();
          isNewDay =
              lastDate.year != now.year ||
              lastDate.month != now.month ||
              lastDate.day != now.day;
        }

        if (isNewDay) {
          // Reset for the new day and add the current square
          transaction.update(progressRef, {
            'completedSquares': [squareNumber],
            'square1Complete': squareNumber == 1,
            'square2Complete': squareNumber == 2,
            'square3Complete': squareNumber == 3,
            'square4Complete': squareNumber == 4,
            'lastUpdated': timestamp,
            'currentSquare': squareNumber,
          });
        } else {
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
        }
      } else {
        transaction.set(progressRef, {
          'childId': childId,
          'currentSquare': squareNumber,
          'completedSquares': [squareNumber],
          'square1Complete': squareNumber == 1,
          'square2Complete': squareNumber == 2,
          'square3Complete': squareNumber == 3,
          'square4Complete': squareNumber == 4,
          'lastUpdated': timestamp,
          'startedAt': timestamp,
        });
      }
    });
  }

  /// Checks if the progress was last updated on a different day and resets if so.
  /// This is useful to call when the user first enters the protocol hub.
  Future<void> checkAndResetDailyProgress(String childId) async {
    final progressRef = _firestore.collection('protocolProgress').doc(childId);
    final doc = await progressRef.get();

    if (doc.exists) {
      final data = doc.data()!;
      final Timestamp? lastUpdated = data['lastUpdated'] as Timestamp?;
      final now = DateTime.now();

      if (lastUpdated != null) {
        final lastDate = lastUpdated.toDate();
        bool isNewDay =
            lastDate.year != now.year ||
            lastDate.month != now.month ||
            lastDate.day != now.day;

        if (isNewDay) {
          await progressRef.update({
            'completedSquares': [],
            'square1Complete': false,
            'square2Complete': false,
            'square3Complete': false,
            'square4Complete': false,
            'lastUpdated': FieldValue.serverTimestamp(),
          });
        }
      }
    }
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
