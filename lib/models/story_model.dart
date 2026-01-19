import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoryPage {
  final String contentKey;
  final String? imageAsset;
  final String? imageUrl; // For Firestore images
  final Map<String, String>?
  localizedContent; // {en: "...", ar: "...", fr: "..."}

  const StoryPage({
    required this.contentKey,
    this.imageAsset,
    this.imageUrl,
    this.localizedContent,
  });

  factory StoryPage.fromMap(Map<String, dynamic> map) {
    return StoryPage(
      contentKey: map['contentKey'] ?? '',
      imageAsset: map['imageAsset'],
      imageUrl: map['imageUrl'],
      localizedContent: map['content'] != null
          ? Map<String, String>.from(map['content'])
          : null,
    );
  }

  String getContent(String locale) {
    if (localizedContent != null && localizedContent!.containsKey(locale)) {
      return localizedContent![locale]!;
    }
    return contentKey; // Fallback to key
  }
}

class Story {
  final String id;
  final String titleKey;
  final String descriptionKey;
  final List<StoryPage> pages;
  final IconData icon;
  final List<Color> gradient;
  final Map<String, String>?
  localizedTitle; // {en: "...", ar: "...", fr: "..."}
  final Map<String, String>? localizedDescription;
  final bool isActive;
  final int order;

  const Story({
    required this.id,
    required this.titleKey,
    required this.descriptionKey,
    required this.pages,
    required this.icon,
    required this.gradient,
    this.localizedTitle,
    this.localizedDescription,
    this.isActive = true,
    this.order = 0,
  });

  /// Get localized title based on current locale
  String getTitle(String locale) {
    if (localizedTitle != null && localizedTitle!.containsKey(locale)) {
      return localizedTitle![locale]!;
    }
    return titleKey; // Fallback to key for hardcoded stories
  }

  /// Get localized description based on current locale
  String getDescription(String locale) {
    if (localizedDescription != null &&
        localizedDescription!.containsKey(locale)) {
      return localizedDescription![locale]!;
    }
    return descriptionKey; // Fallback to key
  }

  /// Create Story from Firestore document
  factory Story.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Parse gradient colors
    final gradientColors =
        (data['gradientColors'] as List<dynamic>?)
            ?.map(
              (hex) =>
                  Color(int.parse(hex.toString().replaceFirst('#', '0xFF'))),
            )
            .toList() ??
        [const Color(0xFF4ECDC4), const Color(0xFF44A08D)];

    // Parse icon
    final iconName = data['icon'] as String? ?? 'book';
    final icon = _getIconFromName(iconName);

    // Parse pages
    final pagesData = data['pages'] as List<dynamic>? ?? [];
    final pages = pagesData
        .map((pageData) => StoryPage.fromMap(pageData as Map<String, dynamic>))
        .toList();

    return Story(
      id: doc.id,
      titleKey: data['id'] ?? doc.id,
      descriptionKey: data['id'] ?? doc.id,
      pages: pages,
      icon: icon,
      gradient: gradientColors,
      localizedTitle: data['title'] != null
          ? Map<String, String>.from(data['title'])
          : null,
      localizedDescription: data['description'] != null
          ? Map<String, String>.from(data['description'])
          : null,
      isActive: data['isActive'] ?? true,
      order: data['order'] ?? 0,
    );
  }

  static IconData _getIconFromName(String name) {
    switch (name.toLowerCase()) {
      case 'star':
        return Icons.star;
      case 'castle':
        return Icons.castle;
      case 'local_florist':
      case 'flower':
        return Icons.local_florist;
      case 'pets':
      case 'dragon':
        return Icons.pets;
      default:
        return Icons.book;
    }
  }

  // Predefined stories
  static List<Story> getAllStories() {
    return [
      Story(
        id: 'brave_star',
        titleKey: 'braveStarTitle',
        descriptionKey: 'braveStarDesc',
        icon: Icons.star,
        gradient: [Color(0xFFFFE259), Color(0xFFFFA751)],
        pages: [
          StoryPage(contentKey: 'braveStarPage1'),
          StoryPage(contentKey: 'braveStarPage2'),
          StoryPage(contentKey: 'braveStarPage3'),
          StoryPage(contentKey: 'braveStarPage4'),
          StoryPage(contentKey: 'braveStarPage5'),
          StoryPage(contentKey: 'braveStarPage6'),
        ],
      ),
      Story(
        id: 'magic_garden',
        titleKey: 'magicGardenTitle',
        descriptionKey: 'magicGardenDesc',
        icon: Icons.local_florist,
        gradient: [Color(0xFF11998E), Color(0xFF38EF7D)],
        pages: [
          StoryPage(contentKey: 'magicGardenPage1'),
          StoryPage(contentKey: 'magicGardenPage2'),
          StoryPage(contentKey: 'magicGardenPage3'),
          StoryPage(contentKey: 'magicGardenPage4'),
          StoryPage(contentKey: 'magicGardenPage5'),
          StoryPage(contentKey: 'magicGardenPage6'),
        ],
      ),
      Story(
        id: 'friendly_dragon',
        titleKey: 'friendlyDragonTitle',
        descriptionKey: 'friendlyDragonDesc',
        icon: Icons.pets,
        gradient: [Color(0xFF667EEA), Color(0xFF764BA2)],
        pages: [
          StoryPage(contentKey: 'friendlyDragonPage1'),
          StoryPage(contentKey: 'friendlyDragonPage2'),
          StoryPage(contentKey: 'friendlyDragonPage3'),
          StoryPage(contentKey: 'friendlyDragonPage4'),
          StoryPage(contentKey: 'friendlyDragonPage5'),
          StoryPage(contentKey: 'friendlyDragonPage6'),
        ],
      ),
    ];
  }
}
