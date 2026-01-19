// ignore_for_file: unused_local_variable, subtype_of_sealed_class, deprecated_member_use

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:mokrabela/models/breathing_exercise_model.dart';
import 'package:mokrabela/services/breathing_service.dart';
import 'package:mokrabela/l10n/app_localizations.dart';

void main() {
  group('BreathingExercise Model Tests', () {
    test('BreathingExercise.fromFirestore should parse correctly', () {
      // Arrange
      final fakeFirestore = FakeFirebaseFirestore();
      final docRef = fakeFirestore
          .collection('breathingExercises')
          .doc('test_exercise');

      final data = {
        'id': 'test_exercise',
        'title': {
          'en': 'Test Exercise',
          'ar': 'تمرين تجريبي',
          'fr': 'Exercice de test',
        },
        'description': {
          'en': 'A test breathing exercise',
          'ar': 'تمرين تنفس تجريبي',
          'fr': 'Un exercice de respiration de test',
        },
        'inhaleSeconds': 4,
        'holdSeconds': 4,
        'exhaleSeconds': 4,
        'cycles': 5,
        'gradientColors': ['#667EEA', '#764BA2'],
        'icon': 'air',
        'isActive': true,
        'order': 1,
      };

      // Act
      final exercise = BreathingExercise.fromFirestore(
        FakeDocumentSnapshot(docRef.id, data),
      );

      // Assert
      expect(exercise.id, equals('test_exercise'));
      expect(exercise.localizedTitle?['en'], equals('Test Exercise'));
      expect(exercise.localizedTitle?['ar'], equals('تمرين تجريبي'));
      expect(exercise.inhaleSeconds, equals(4));
      expect(exercise.holdSeconds, equals(4));
      expect(exercise.exhaleSeconds, equals(4));
      expect(exercise.defaultCycles, equals(5));
      expect(exercise.durationSeconds, equals(12)); // 4+4+4
      expect(exercise.isActive, isTrue);
      expect(exercise.order, equals(1));
      expect(exercise.type, equals(BreathingExerciseType.custom));
    });

    test('BreathingExercise.getTitle should return localized title', () {
      // Arrange
      final exercise = BreathingExercise(
        type: BreathingExerciseType.custom,
        title: 'Default Title',
        description: 'Default Desc',
        id: 'test',
        durationSeconds: 12,
        defaultCycles: 4,
        gradient: [],
        icon: Icons.air,
        localizedTitle: {'en': 'English Title', 'ar': 'عنوان عربي'},
      );

      // Act & Assert
      expect(exercise.getTitle('en'), equals('English Title'));
      expect(exercise.getTitle('ar'), equals('عنوان عربي'));
      expect(exercise.getTitle('fr'), equals('Default Title')); // Fallback
    });

    test(
      'BreathingExercise.getDescription should return localized description',
      () {
        // Arrange
        final exercise = BreathingExercise(
          type: BreathingExerciseType.custom,
          title: 'Title',
          description: 'Default Description',
          id: 'test',
          durationSeconds: 12,
          defaultCycles: 4,
          gradient: [],
          icon: Icons.air,
          localizedDescription: {'en': 'English Description', 'ar': 'وصف عربي'},
        );

        // Act & Assert
        expect(exercise.getDescription('en'), equals('English Description'));
        expect(exercise.getDescription('ar'), equals('وصف عربي'));
        expect(
          exercise.getDescription('fr'),
          equals('Default Description'),
        ); // Fallback
      },
    );

    test('should parse gradient colors correctly', () {
      // Arrange
      final fakeFirestore = FakeFirebaseFirestore();
      final docRef = fakeFirestore.collection('breathingExercises').doc('test');

      final data = {
        'gradientColors': ['#667EEA', '#764BA2'],
        'icon': 'air',
        'inhaleSeconds': 4,
        'holdSeconds': 4,
        'exhaleSeconds': 4,
        'cycles': 4,
        'isActive': true,
        'order': 0,
      };

      // Act
      final exercise = BreathingExercise.fromFirestore(
        FakeDocumentSnapshot(docRef.id, data),
      );

      // Assert
      expect(exercise.gradient.length, equals(2));
      expect(exercise.gradient[0].value, equals(0xFF667EEA));
      expect(exercise.gradient[1].value, equals(0xFF764BA2));
    });

    test('should parse icon names correctly', () {
      final testCases = {
        'wb_sunny': Icons.wb_sunny,
        'sunny': Icons.wb_sunny,
        'butterfly': Icons.flutter_dash,
        'waves': Icons.waves,
        'ocean': Icons.waves,
        'forest': Icons.park,
        'park': Icons.park,
        'air': Icons.air,
        'unknown': Icons.air, // Default
      };

      for (final entry in testCases.entries) {
        final fakeFirestore = FakeFirebaseFirestore();
        final docRef = fakeFirestore
            .collection('breathingExercises')
            .doc('test');

        final data = {
          'icon': entry.key,
          'inhaleSeconds': 4,
          'holdSeconds': 4,
          'exhaleSeconds': 4,
          'cycles': 4,
          'gradientColors': ['#667EEA', '#764BA2'],
          'isActive': true,
          'order': 0,
        };

        final exercise = BreathingExercise.fromFirestore(
          FakeDocumentSnapshot(docRef.id, data),
        );

        expect(
          exercise.icon,
          equals(entry.value),
          reason: 'Icon ${entry.key} should map to ${entry.value}',
        );
      }
    });

    test('should calculate duration correctly from timing fields', () {
      // Arrange
      final fakeFirestore = FakeFirebaseFirestore();
      final docRef = fakeFirestore.collection('breathingExercises').doc('test');

      final data = {
        'inhaleSeconds': 5,
        'holdSeconds': 3,
        'exhaleSeconds': 7,
        'cycles': 4,
        'gradientColors': ['#667EEA', '#764BA2'],
        'icon': 'air',
        'isActive': true,
        'order': 0,
      };

      // Act
      final exercise = BreathingExercise.fromFirestore(
        FakeDocumentSnapshot(docRef.id, data),
      );

      // Assert
      expect(exercise.durationSeconds, equals(15)); // 5+3+7
      expect(exercise.inhaleSeconds, equals(5));
      expect(exercise.holdSeconds, equals(3));
      expect(exercise.exhaleSeconds, equals(7));
    });
  });

  group('Localization Tests', () {
    test('should handle missing translations gracefully', () {
      // Arrange
      final exercise = BreathingExercise(
        type: BreathingExerciseType.custom,
        title: 'Fallback Title',
        description: 'Fallback Desc',
        id: 'test',
        durationSeconds: 12,
        defaultCycles: 4,
        gradient: [],
        icon: Icons.air,
        localizedTitle: {'en': 'English Only'},
      );

      // Act & Assert
      expect(exercise.getTitle('en'), equals('English Only'));
      expect(exercise.getTitle('ar'), equals('Fallback Title')); // Falls back
      expect(exercise.getTitle('fr'), equals('Fallback Title'));
    });

    test('should use default values when fields are missing', () {
      // Arrange
      final fakeFirestore = FakeFirebaseFirestore();
      final docRef = fakeFirestore.collection('breathingExercises').doc('test');

      final data = {
        // Minimal data - most fields missing
        'isActive': true,
      };

      // Act
      final exercise = BreathingExercise.fromFirestore(
        FakeDocumentSnapshot(docRef.id, data),
      );

      // Assert
      expect(exercise.inhaleSeconds, equals(4)); // Default
      expect(exercise.holdSeconds, equals(4)); // Default
      expect(exercise.exhaleSeconds, equals(4)); // Default
      expect(exercise.defaultCycles, equals(4)); // Default
      expect(exercise.gradient.length, equals(2)); // Default gradient
      expect(exercise.icon, equals(Icons.air)); // Default icon
    });
  });
}

// Helper class for testing
class FakeDocumentSnapshot implements DocumentSnapshot<Map<String, dynamic>> {
  @override
  final String id;
  final Map<String, dynamic> _data;

  FakeDocumentSnapshot(this.id, this._data);

  @override
  Map<String, dynamic>? data() => _data;

  @override
  bool get exists => true;

  @override
  dynamic get(Object field) => _data[field];

  @override
  dynamic operator [](Object field) => _data[field];

  @override
  DocumentReference<Map<String, dynamic>> get reference =>
      throw UnimplementedError();

  @override
  SnapshotMetadata get metadata => throw UnimplementedError();
}
