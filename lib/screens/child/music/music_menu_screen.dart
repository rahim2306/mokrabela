import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/components/cards/sticky_info_card.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/music_track_model.dart';
import 'package:mokrabela/screens/child/music/calm_music_screen.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class MusicMenuScreen extends StatelessWidget {
  const MusicMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tracks = MusicTrack.getAllTracks();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          l10n.calmMusicTitle,
          style: GoogleFonts.spaceGrotesk(
            color: AppTheme.deepBlue,
            fontWeight: FontWeight.w900,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppTheme.deepBlue),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFAFAFA), Color(0xFFE1F5FE), Color(0xFFFAFAFA)],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              ListView.builder(
                padding: EdgeInsets.fromLTRB(6.w, 2.h, 6.w, 25.h),
                itemCount: tracks.length,
                itemBuilder: (context, index) {
                  final track = tracks[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 3.h),
                    height: 20.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: track.gradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: track.gradient.first.withValues(alpha: 0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CalmMusicScreen(initialTrackIndex: index),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(3.h),
                            child: Row(
                              children: [
                                // Icon
                                Container(
                                  width: 15.w,
                                  height: 15.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.25),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.3,
                                      ),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Icon(
                                    track.icon,
                                    color: Colors.white,
                                    size: 8.w,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                // Text
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _getTrackTitle(l10n, track),
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Text(
                                        _getTrackDescription(l10n, track),
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white.withValues(
                                            alpha: 0.9,
                                          ),
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.play_circle_filled,
                                  color: Colors.white,
                                  size: 12.w,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Sticky info card at bottom
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: StickyInfoCard(
                  title: l10n.whyMusicTitle,
                  description: l10n.whyMusicDesc,
                  icon: Icons.music_note,
                  iconColor: const Color(0xFF7C4DFF), // Purple
                  iconBackgroundColor: const Color(0xFFB39DDB), // Light Purple
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTrackTitle(AppLocalizations l10n, MusicTrack track) {
    switch (track.titleKey) {
      case 'rainSounds':
        return l10n.rainSounds;
      case 'natureAmbience':
        return l10n.natureAmbience;
      case 'oceanWaves':
        return l10n.oceanWaves;
      case 'calmMusicTrack':
        return l10n.calmMusicTrack;
      default:
        return track.titleKey;
    }
  }

  String _getTrackDescription(AppLocalizations l10n, MusicTrack track) {
    switch (track.descriptionKey) {
      case 'rainSoundsDesc':
        return l10n.rainSoundsDesc;
      case 'natureAmbienceDesc':
        return l10n.natureAmbienceDesc;
      case 'oceanWavesDesc':
        return l10n.oceanWavesDesc;
      case 'calmMusicTrackDesc':
        return l10n.calmMusicTrackDesc;
      default:
        return track.descriptionKey;
    }
  }
}
