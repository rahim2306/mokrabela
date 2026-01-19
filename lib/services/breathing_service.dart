import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mokrabela/models/breathing_exercise_model.dart';
import 'package:mokrabela/l10n/app_localizations.dart';

/// Service for fetching breathing exercises from Firestore
class BreathingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get all active breathing exercises from Firestore, merged with hardcoded defaults
  Stream<List<BreathingExercise>> getExercises(AppLocalizations l10n) {
    return _firestore
        .collection('breathingExercises')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
          // Get Firestore exercises
          final firestoreExercises = snapshot.docs
              .map((doc) => BreathingExercise.fromFirestore(doc))
              .toList();

          // Get hardcoded exercises
          final hardcodedExercises = BreathingExercise.getAllExercises(l10n);

          // Merge: Firestore exercises first, then hardcoded ones
          // Remove duplicates by ID (Firestore takes precedence)
          final allExercises = <String, BreathingExercise>{};

          // Add hardcoded first
          for (final exercise in hardcodedExercises) {
            allExercises[exercise.id] = exercise;
          }

          // Override with Firestore (takes precedence)
          for (final exercise in firestoreExercises) {
            allExercises[exercise.id] = exercise;
          }

          // Return as list, sorted by order
          final result = allExercises.values.toList();
          result.sort((a, b) => a.order.compareTo(b.order));
          return result;
        });
  }

  /// Get a single exercise by ID
  Future<BreathingExercise?> getExerciseById(
    String id,
    AppLocalizations l10n,
  ) async {
    try {
      final doc = await _firestore
          .collection('breathingExercises')
          .doc(id)
          .get();
      if (doc.exists) {
        return BreathingExercise.fromFirestore(doc);
      }
      // Fallback to hardcoded
      return BreathingExercise.getAllExercises(l10n).firstWhere(
        (e) => e.id == id,
        orElse: () => BreathingExercise.getAllExercises(l10n).first,
      );
    } catch (e) {
      // Return hardcoded fallback
      return BreathingExercise.getAllExercises(l10n).firstWhere(
        (e) => e.id == id,
        orElse: () => BreathingExercise.getAllExercises(l10n).first,
      );
    }
  }
}
