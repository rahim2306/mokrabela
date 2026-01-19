import 'package:cloud_firestore/cloud_firestore.dart';

/// Run this script once to add a test breathing exercise to Firestore
///
/// To run:
/// 1. Add a button in your app that calls addTestBreathingExercise()
/// 2. Or run from main() temporarily
Future<void> addTestBreathingExercise() async {
  final firestore = FirebaseFirestore.instance;

  try {
    await firestore.collection('breathingExercises').doc('zen_breath').set({
      'title': {
        'en': 'Zen Breathing',
        'ar': 'تنفس الزن',
        'fr': 'Respiration Zen',
      },
      'description': {
        'en': 'A calming breathing exercise for deep relaxation',
        'ar': 'تمرين تنفس مهدئ للاسترخاء العميق',
        'fr':
            'Un exercice de respiration apaisant pour une relaxation profonde',
      },
      'inhaleSeconds': 5,
      'holdSeconds': 5,
      'exhaleSeconds': 5,
      'cycles': 5,
      'gradientColors': ['#667EEA', '#764BA2'],
      'icon': 'air',
      'isActive': true,
      'order': 0,
    });

    print('✅ Test breathing exercise added successfully!');
  } catch (e) {
    print('❌ Error adding breathing exercise: $e');
  }
}
