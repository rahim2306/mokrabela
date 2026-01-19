import 'package:cloud_firestore/cloud_firestore.dart';

/// Run this script once to add a test story to Firestore
///
/// To run:
/// 1. Add a button in your app that calls addTestStory()
/// 2. Or run from main() temporarily
Future<void> addTestStory() async {
  final firestore = FirebaseFirestore.instance;

  try {
    await firestore.collection('stories').doc('magical_forest').set({
      'title': {
        'en': 'The Magical Forest',
        'ar': 'الغابة السحرية',
        'fr': 'La Forêt Magique',
      },
      'description': {
        'en': 'A story about a magical forest where trees talk',
        'ar': 'قصة عن غابة سحرية حيث تتحدث الأشجار',
        'fr': 'Une histoire sur une forêt magique où les arbres parlent',
      },
      'pages': [
        {
          'content': {
            'en':
                'Once upon a time, there was a magical forest where trees could talk and animals could sing.',
            'ar':
                'في قديم الزمان، كانت هناك غابة سحرية حيث يمكن للأشجار أن تتحدث والحيوانات أن تغني.',
            'fr':
                'Il était une fois, une forêt magique où les arbres pouvaient parler et les animaux chanter.',
          },
          'imageUrl': '',
        },
        {
          'content': {
            'en':
                'A young girl named Luna discovered this forest one sunny day.',
            'ar': 'اكتشفت فتاة صغيرة تدعى لونا هذه الغابة في يوم مشمس.',
            'fr':
                'Une jeune fille nommée Luna a découvert cette forêt un jour ensoleillé.',
          },
          'imageUrl': '',
        },
        {
          'content': {
            'en':
                'The trees welcomed her with open branches and the birds sang her a beautiful song.',
            'ar': 'رحبت بها الأشجار بأغصان مفتوحة وغنت لها الطيور أغنية جميلة.',
            'fr':
                'Les arbres l\'ont accueillie à bras ouverts et les oiseaux lui ont chanté une belle chanson.',
          },
          'imageUrl': '',
        },
      ],
      'gradientColors': ['#9C27B0', '#E91E63'],
      'icon': 'local_florist',
      'isActive': true,
      'order': 0,
    });

    print('✅ Test story added successfully!');
  } catch (e) {
    print('❌ Error adding story: $e');
  }
}
