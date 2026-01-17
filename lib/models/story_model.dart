import 'package:flutter/material.dart';

class StoryPage {
  final String contentKey;
  final String? imageAsset;

  const StoryPage({required this.contentKey, this.imageAsset});
}

class Story {
  final String id;
  final String titleKey;
  final String descriptionKey;
  final List<StoryPage> pages;
  final IconData icon;
  final List<Color> gradient;

  const Story({
    required this.id,
    required this.titleKey,
    required this.descriptionKey,
    required this.pages,
    required this.icon,
    required this.gradient,
  });

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
