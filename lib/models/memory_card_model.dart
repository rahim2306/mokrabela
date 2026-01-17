import 'package:flutter/material.dart';

class MemoryCard {
  final String id;
  final IconData icon;
  final List<Color> gradient;
  bool isFlipped;
  bool isMatched;

  MemoryCard({
    required this.id,
    required this.icon,
    required this.gradient,
    this.isFlipped = false,
    this.isMatched = false,
  });

  MemoryCard copyWith({bool? isFlipped, bool? isMatched}) {
    return MemoryCard(
      id: id,
      icon: icon,
      gradient: gradient,
      isFlipped: isFlipped ?? this.isFlipped,
      isMatched: isMatched ?? this.isMatched,
    );
  }

  // Generate pairs of cards for the game
  static List<MemoryCard> generateCardPairs() {
    final cardTemplates = [
      {
        'icon': Icons.favorite,
        'gradient': [Color(0xFFFF6B9D), Color(0xFFC06C84)],
      },
      {
        'icon': Icons.star,
        'gradient': [Color(0xFFFFC837), Color(0xFFFF8008)],
      },
      {
        'icon': Icons.pets,
        'gradient': [Color(0xFF00C9FF), Color(0xFF92FE9D)],
      },
      {
        'icon': Icons.music_note,
        'gradient': [Color(0xFFB06AB3), Color(0xFF4568DC)],
      },
      {
        'icon': Icons.rocket_launch,
        'gradient': [Color(0xFFFF512F), Color(0xFFDD2476)],
      },
      {
        'icon': Icons.sports_soccer,
        'gradient': [Color(0xFF11998E), Color(0xFF38EF7D)],
      },
      {
        'icon': Icons.cake,
        'gradient': [Color(0xFFFA709A), Color(0xFFFEE140)],
      },
      {
        'icon': Icons.emoji_emotions,
        'gradient': [Color(0xFF667EEA), Color(0xFF764BA2)],
      },
    ];

    final List<MemoryCard> cards = [];

    // Create pairs
    for (int i = 0; i < cardTemplates.length; i++) {
      final template = cardTemplates[i];
      // First card of pair
      cards.add(
        MemoryCard(
          id: 'card_${i}_a',
          icon: template['icon'] as IconData,
          gradient: template['gradient'] as List<Color>,
        ),
      );
      // Second card of pair
      cards.add(
        MemoryCard(
          id: 'card_${i}_b',
          icon: template['icon'] as IconData,
          gradient: template['gradient'] as List<Color>,
        ),
      );
    }

    // Shuffle cards
    cards.shuffle();

    return cards;
  }
}
