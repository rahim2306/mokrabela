// ignore_for_file: unused_local_variable, subtype_of_sealed_class, deprecated_member_use

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:mokrabela/models/story_model.dart';
import 'package:mokrabela/services/story_service.dart';

void main() {
  group('Story Model Tests', () {
    test('Story.fromFirestore should parse correctly', () {
      // Arrange
      final fakeFirestore = FakeFirebaseFirestore();
      final docRef = fakeFirestore.collection('stories').doc('test_story');

      final data = {
        'id': 'test_story',
        'title': {
          'en': 'Test Story',
          'ar': 'قصة تجريبية',
          'fr': 'Histoire de test',
        },
        'description': {
          'en': 'A test story',
          'ar': 'قصة اختبار',
          'fr': 'Une histoire de test',
        },
        'pages': [
          {
            'content': {
              'en': 'Page 1 content',
              'ar': 'محتوى الصفحة 1',
              'fr': 'Contenu de la page 1',
            },
            'imageUrl': 'https://example.com/image1.jpg',
          },
        ],
        'gradientColors': ['#FF6B6B', '#4ECDC4'],
        'icon': 'star',
        'isActive': true,
        'order': 1,
      };

      // Act
      final story = Story.fromFirestore(FakeDocumentSnapshot(docRef.id, data));

      // Assert
      expect(story.id, equals('test_story'));
      expect(story.localizedTitle?['en'], equals('Test Story'));
      expect(story.localizedTitle?['ar'], equals('قصة تجريبية'));
      expect(story.pages.length, equals(1));
      expect(story.isActive, isTrue);
      expect(story.order, equals(1));
    });

    test('Story.getTitle should return localized title', () {
      // Arrange
      final story = Story(
        id: 'test',
        titleKey: 'testKey',
        descriptionKey: 'descKey',
        pages: [],
        icon: Icons.star,
        gradient: [],
        localizedTitle: {'en': 'English Title', 'ar': 'عنوان عربي'},
      );

      // Act & Assert
      expect(story.getTitle('en'), equals('English Title'));
      expect(story.getTitle('ar'), equals('عنوان عربي'));
      expect(story.getTitle('fr'), equals('testKey')); // Fallback
    });

    test('StoryPage.getContent should return localized content', () {
      // Arrange
      final page = StoryPage(
        contentKey: 'contentKey',
        localizedContent: {'en': 'English content', 'ar': 'محتوى عربي'},
      );

      // Act & Assert
      expect(page.getContent('en'), equals('English content'));
      expect(page.getContent('ar'), equals('محتوى عربي'));
      expect(page.getContent('fr'), equals('contentKey')); // Fallback
    });
  });

  group('StoryService Tests', () {
    late FakeFirebaseFirestore fakeFirestore;
    late StoryService storyService;

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      // Note: You'll need to inject the firestore instance
      // For now, this is a structure example
    });

    test(
      'getStories should return hardcoded stories when Firestore is empty',
      () async {
        // Arrange
        final service = StoryService();

        // Act
        final stories = await service.getStories().first;

        // Assert
        expect(
          stories.length,
          greaterThanOrEqualTo(3),
        ); // At least hardcoded ones
        expect(stories.any((s) => s.id == 'brave_star'), isTrue);
      },
    );

    test('getStories should merge Firestore and hardcoded stories', () async {
      // This test would require dependency injection to work properly
      // For now, it's a placeholder showing the test structure

      // Arrange - Add a story to fake Firestore
      // Act - Get stories
      // Assert - Check both Firestore and hardcoded stories are present
    });

    test('getStoryById should return story from Firestore if exists', () async {
      // Arrange
      final service = StoryService();

      // Act
      final story = await service.getStoryById('brave_star');

      // Assert
      expect(story, isNotNull);
      expect(story?.id, equals('brave_star'));
    });
  });

  group('Localization Tests', () {
    test('should handle missing translations gracefully', () {
      // Arrange
      final story = Story(
        id: 'test',
        titleKey: 'fallbackKey',
        descriptionKey: 'descKey',
        pages: [],
        icon: Icons.book,
        gradient: [],
        localizedTitle: {'en': 'English Only'},
      );

      // Act & Assert
      expect(story.getTitle('en'), equals('English Only'));
      expect(story.getTitle('ar'), equals('fallbackKey')); // Falls back to key
      expect(story.getTitle('fr'), equals('fallbackKey'));
    });

    test('should parse gradient colors correctly', () {
      // Arrange
      final fakeFirestore = FakeFirebaseFirestore();
      final docRef = fakeFirestore.collection('stories').doc('test');

      final data = {
        'gradientColors': ['#FF6B6B', '#4ECDC4'],
        'icon': 'star',
        'pages': [],
        'isActive': true,
        'order': 0,
      };

      // Act
      final story = Story.fromFirestore(FakeDocumentSnapshot(docRef.id, data));

      // Assert
      expect(story.gradient.length, equals(2));
      expect(story.gradient[0].value, equals(0xFFFF6B6B));
      expect(story.gradient[1].value, equals(0xFF4ECDC4));
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
