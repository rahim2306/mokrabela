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
        // Create user doc in Firestore
        UserModel newUser = UserModel(
          uid: user.uid,
          email: email,
          name: name,
          role: role,
        );

        await _firestore.collection('users').doc(user.uid).set({
          'uid': newUser.uid,
          'email': newUser.email,
          'name': newUser.name,
          'role': newUser.role.toString().split('.').last, // Store as string
          'createdAt': FieldValue.serverTimestamp(),
        });

        return newUser;
      }
      return null;
    } catch (e) {
      print(e.toString());
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
    } catch (e) {
      print(e.toString());
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
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return UserModel(
          uid: data['uid'] ?? '',
          email: data['email'] ?? '',
          name: data['name'] ?? '',
          role: UserRole.values.firstWhere(
            (e) => e.toString() == 'UserRole.${data['role']}',
            orElse: () => UserRole.child,
          ),
        );
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
