import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:mokrabela/firebase_options.dart';
import 'package:mokrabela/models/user_model.dart';
import 'package:mokrabela/services/protocol_service.dart';

/// Service for parent-specific operations
class ParentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ProtocolService _protocolService = ProtocolService();

  // Secondary Firebase app for creating child accounts without auto-login
  FirebaseApp? _secondaryApp;
  FirebaseAuth? _secondaryAuth;

  /// Initialize secondary Firebase app for child account creation
  Future<void> _initSecondaryApp() async {
    if (_secondaryApp == null) {
      _secondaryApp = await Firebase.initializeApp(
        name: 'ChildCreation',
        options: DefaultFirebaseOptions.currentPlatform,
      );
      _secondaryAuth = FirebaseAuth.instanceFor(app: _secondaryApp!);
    }
  }

  /// Get list of children for a parent
  Future<List<String>> getChildrenIds(String parentId) async {
    try {
      final snapshot = await _firestore
          .collection('parentChildren')
          .where('parentId', isEqualTo: parentId)
          .get();

      return snapshot.docs
          .map((doc) => doc.data()['childId'] as String)
          .toList();
    } catch (e) {
      debugPrint('Error getting children: $e');
      return [];
    }
  }

  /// Get list of children with their details
  Stream<List<UserModel>> getChildrenStream(String parentId) {
    return _firestore
        .collection('parentChildren')
        .where('parentId', isEqualTo: parentId)
        .snapshots()
        .asyncMap((snapshot) async {
          final childIds = snapshot.docs
              .map((doc) => doc.data()['childId'] as String)
              .toList();

          if (childIds.isEmpty) return <UserModel>[];

          final children = <UserModel>[];
          for (final childId in childIds) {
            final userDoc = await _firestore
                .collection('users')
                .doc(childId)
                .get();
            if (userDoc.exists) {
              children.add(UserModel.fromFirestore(userDoc));
            }
          }

          return children;
        });
  }

  /// Get child details
  Future<UserModel?> getChildDetails(String childId) async {
    try {
      final doc = await _firestore.collection('users').doc(childId).get();
      if (doc.exists) {
        return UserModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      debugPrint('Error getting child details: $e');
      return null;
    }
  }

  /// Create a new child account
  /// Uses secondary FirebaseApp to prevent auto-login
  Future<String?> createChildAccount({
    required String email,
    required String password,
    required String name,
    required int age,
    required String parentId,
  }) async {
    try {
      // Initialize secondary app if needed
      await _initSecondaryApp();

      // Create user in Firebase Auth using secondary app
      final UserCredential result = await _secondaryAuth!
          .createUserWithEmailAndPassword(email: email, password: password);

      final User? user = result.user;
      if (user == null) return null;

      // Create user document in Firestore
      final profile = UserProfile(name: name, age: age);
      final watchSettings = WatchSettings();
      final appSettings = AppSettings();

      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'role': 'child',
        'profile': profile.toMap(),
        'watchSettings': watchSettings.toMap(),
        'appSettings': appSettings.toMap(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Link child to parent
      await linkChildToParent(parentId, user.uid);

      // Initialize protocol enrollment for child
      await _protocolService.ensureEnrollment(user.uid);

      // Sign out from secondary auth (important!)
      await _secondaryAuth!.signOut();

      return user.uid;
    } catch (e) {
      debugPrint('Error creating child account: $e');
      // Make sure to sign out even if error occurs
      try {
        await _secondaryAuth?.signOut();
      } catch (_) {}
      rethrow;
    }
  }

  /// Link a child to a parent
  Future<void> linkChildToParent(String parentId, String childId) async {
    try {
      final docId = '${parentId}_$childId';
      await _firestore.collection('parentChildren').doc(docId).set({
        'parentId': parentId,
        'childId': childId,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Error linking child to parent: $e');
      rethrow;
    }
  }

  /// Unlink a child from a parent
  Future<void> unlinkChildFromParent(String parentId, String childId) async {
    try {
      final docId = '${parentId}_$childId';
      await _firestore.collection('parentChildren').doc(docId).delete();
    } catch (e) {
      debugPrint('Error unlinking child from parent: $e');
      rethrow;
    }
  }

  /// Delete child account (optional - use with caution)
  Future<void> deleteChildAccount(String childId) async {
    try {
      // Delete user document
      await _firestore.collection('users').doc(childId).delete();

      // Delete all parent-child links
      final links = await _firestore
          .collection('parentChildren')
          .where('childId', isEqualTo: childId)
          .get();

      for (final doc in links.docs) {
        await doc.reference.delete();
      }

      // Note: Firebase Auth user deletion requires re-authentication
      // This should be done separately with proper security
    } catch (e) {
      debugPrint('Error deleting child account: $e');
      rethrow;
    }
  }

  /// Update child profile
  Future<void> updateChildProfile(
    String childId,
    Map<String, dynamic> updates,
  ) async {
    try {
      await _firestore.collection('users').doc(childId).update({
        'profile': updates,
      });
    } catch (e) {
      debugPrint('Error updating child profile: $e');
      rethrow;
    }
  }

  /// Check if user is a parent
  Future<bool> isParent(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        final role = doc.data()?['role'] as String?;
        return role == 'parent';
      }
      return false;
    } catch (e) {
      debugPrint('Error checking parent role: $e');
      return false;
    }
  }

  /// Dispose secondary app resources
  Future<void> dispose() async {
    if (_secondaryApp != null) {
      await _secondaryApp!.delete();
      _secondaryApp = null;
      _secondaryAuth = null;
    }
  }
}
