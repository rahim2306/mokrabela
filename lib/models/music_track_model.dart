import 'package:flutter/material.dart';

class MusicTrack {
  final String id;
  final String titleKey;
  final String descriptionKey;
  final String assetPath;
  final IconData icon;
  final List<Color> gradient;

  const MusicTrack({
    required this.id,
    required this.titleKey,
    required this.descriptionKey,
    required this.assetPath,
    required this.icon,
    required this.gradient,
  });

  // Predefined calm music tracks
  static List<MusicTrack> getAllTracks() {
    return [
      MusicTrack(
        id: 'rain',
        titleKey: 'rainSounds',
        descriptionKey: 'rainSoundsDesc',
        assetPath: 'audio/rain.mp3',
        icon: Icons.water_drop,
        gradient: [Color(0xFF6DD5ED), Color(0xFF2193B0)],
      ),
      MusicTrack(
        id: 'nature',
        titleKey: 'natureAmbience',
        descriptionKey: 'natureAmbienceDesc',
        assetPath: 'audio/nature.mp3',
        icon: Icons.forest,
        gradient: [Color(0xFF11998E), Color(0xFF38EF7D)],
      ),
      MusicTrack(
        id: 'ocean',
        titleKey: 'oceanWaves',
        descriptionKey: 'oceanWavesDesc',
        assetPath: 'audio/ocean.mp3',
        icon: Icons.waves,
        gradient: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
      ),
      MusicTrack(
        id: 'calm',
        titleKey: 'calmMusicTrack',
        descriptionKey: 'calmMusicTrackDesc',
        assetPath: 'audio/calm_music.mp3',
        icon: Icons.music_note,
        gradient: [Color(0xFF667EEA), Color(0xFF764BA2)],
      ),
    ];
  }
}
