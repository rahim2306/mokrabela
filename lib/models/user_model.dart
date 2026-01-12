import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { child, parent, teacher }

class UserModel {
  final String uid;
  final String email;
  final String name;
  final UserRole role;

  // Real-time biometric data (LiveState)
  final int? bpm;
  final int? currentSquare;
  final String stressLevel;
  final bool isInSession;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
    this.bpm,
    this.currentSquare,
    this.stressLevel = 'calm',
    this.isInSession = false,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    Map<String, dynamic> profile = data['profile'] ?? {};
    Map<String, dynamic> liveState = data['liveState'] ?? {};

    return UserModel(
      uid: doc.id,
      email: data['email'] ?? '',
      name: profile['name'] ?? data['name'] ?? '',
      role: UserRole.values.firstWhere(
        (e) => e.toString() == 'UserRole.${profile['role'] ?? data['role']}',
        orElse: () => UserRole.child,
      ),
      bpm: liveState['bpm'],
      currentSquare: liveState['currentSquare'],
      stressLevel: liveState['stressLevel'] ?? 'calm',
      isInSession: liveState['isInSession'] ?? false,
    );
  }
}
