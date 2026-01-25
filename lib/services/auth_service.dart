import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mokrabela/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Stream of auth changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign Up
  Future<UserModel?> signUp({
    required String email,
    required String password,
    required String name,
    required UserRole role,
  }) async {
    try {
      // Create user in Firebase Auth
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        final profile = UserProfile(name: name);
        final watchSettings = WatchSettings(); // Default settings
        final appSettings = AppSettings(); // Default app settings

        // Create user doc in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'role': role.toString().split('.').last,
          'profile': profile.toMap(),
          'watchSettings': watchSettings.toMap(),
          'appSettings': appSettings.toMap(),
          'createdAt': FieldValue.serverTimestamp(),
        });

        return UserModel(
          uid: user.uid,
          role: role,
          profile: profile,
          watchSettings: watchSettings,
          appSettings: appSettings,
        );
      }
      return null;
    } on FirebaseAuthException catch (e) {
      debugPrint('SignUp FirebaseAuthException: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('SignUp Error: ${e.toString()}');
      rethrow;
    }
  }

  // Sign In
  Future<UserModel?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        return await getUserDetails(user.uid);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      debugPrint('SignIn FirebaseAuthException: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('SignIn Error: ${e.toString()}');
      rethrow;
    }
  }

  // Get User Details
  Future<UserModel?> getUserDetails(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(uid)
          .get();

      if (doc.exists) {
        return UserModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      debugPrint('GetUserDetails Error: ${e.toString()}');
      return null;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Update App Settings
  Future<void> updateAppSettings(String uid, AppSettings settings) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'appSettings': settings.toMap(),
      });
    } catch (e) {
      debugPrint('UpdateAppSettings Error: ${e.toString()}');
      rethrow;
    }
  }
}
