import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mokrabela/models/story_model.dart';

/// Service for fetching stories from Firestore
class StoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get all active stories from Firestore, merged with hardcoded defaults
  Stream<List<Story>> getStories() {
    return _firestore
        .collection('stories')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
          // Get Firestore stories
          final firestoreStories = snapshot.docs
              .map((doc) => Story.fromFirestore(doc))
              .toList();

          // Get hardcoded stories
          final hardcodedStories = Story.getAllStories();

          // Merge: Firestore stories first, then hardcoded ones
          // Remove duplicates by ID (Firestore takes precedence)
          final allStories = <String, Story>{};

          // Add hardcoded first
          for (final story in hardcodedStories) {
            allStories[story.id] = story;
          }

          // Override with Firestore (takes precedence)
          for (final story in firestoreStories) {
            allStories[story.id] = story;
          }

          // Return as list, sorted by order
          final result = allStories.values.toList();
          result.sort((a, b) => a.order.compareTo(b.order));
          return result;
        });
  }

  /// Get a single story by ID
  Future<Story?> getStoryById(String id) async {
    try {
      final doc = await _firestore.collection('stories').doc(id).get();
      if (doc.exists) {
        return Story.fromFirestore(doc);
      }
      // Fallback to hardcoded
      return Story.getAllStories().firstWhere(
        (s) => s.id == id,
        orElse: () => Story.getAllStories().first,
      );
    } catch (e) {
      // Return hardcoded fallback
      return Story.getAllStories().firstWhere(
        (s) => s.id == id,
        orElse: () => Story.getAllStories().first,
      );
    }
  }
}
