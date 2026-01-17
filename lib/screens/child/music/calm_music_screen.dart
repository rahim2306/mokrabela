import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/components/music/rotating_disc_widget.dart';
import 'package:mokrabela/components/music/sound_wave_widget.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/music_track_model.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class CalmMusicScreen extends StatefulWidget {
  final int initialTrackIndex;

  const CalmMusicScreen({super.key, this.initialTrackIndex = 0});

  @override
  State<CalmMusicScreen> createState() => _CalmMusicScreenState();
}

class _CalmMusicScreenState extends State<CalmMusicScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  List<MusicTrack> tracks = [];
  int _currentTrackIndex = 0;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    tracks = MusicTrack.getAllTracks();
    _currentTrackIndex = widget.initialTrackIndex;
    _setupAudioPlayer();
  }

  void _setupAudioPlayer() {
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() => _position = position);
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      _playNext();
    });
  }

  Future<void> _playPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      setState(() => _isPlaying = false);
    } else {
      await _audioPlayer.play(
        AssetSource(tracks[_currentTrackIndex].assetPath),
      );
      setState(() => _isPlaying = true);
    }
  }

  Future<void> _playNext() async {
    setState(() {
      _currentTrackIndex = (_currentTrackIndex + 1) % tracks.length;
      _position = Duration.zero;
    });
    if (_isPlaying) {
      await _audioPlayer.stop();
      await _audioPlayer.play(
        AssetSource(tracks[_currentTrackIndex].assetPath),
      );
    }
  }

  Future<void> _playPrevious() async {
    setState(() {
      _currentTrackIndex =
          (_currentTrackIndex - 1 + tracks.length) % tracks.length;
      _position = Duration.zero;
    });
    if (_isPlaying) {
      await _audioPlayer.stop();
      await _audioPlayer.play(
        AssetSource(tracks[_currentTrackIndex].assetPath),
      );
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFAFAFA), Color(0xFFE8F5E9), Color(0xFFFAFAFA)],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(2.h),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.deepBlue.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.close, color: AppTheme.deepBlue),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        l10n.calmMusic,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.deepBlue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 48),
                  ],
                ),
              ),

              Spacer(flex: 1),

              // Rotating Disc
              RotatingDiscWidget(
                isPlaying: _isPlaying,
                gradient: tracks[_currentTrackIndex].gradient,
                icon: tracks[_currentTrackIndex].icon,
              ),

              const Spacer(flex: 1),

              // Sound Waves
              SoundWaveWidget(
                isPlaying: _isPlaying,
                gradient: tracks[_currentTrackIndex].gradient,
              ),

              SizedBox(height: 2.h),

              // Track Info
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Column(
                  children: [
                    Text(
                      tracks[_currentTrackIndex].titleKey,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.deepBlue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 1),

              // Progress Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Column(
                  children: [
                    SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 4,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 6,
                        ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 12,
                        ),
                      ),
                      child: Slider(
                        value: _position.inSeconds.toDouble(),
                        max: _duration.inSeconds.toDouble() > 0
                            ? _duration.inSeconds.toDouble()
                            : 1,
                        onChanged: (value) async {
                          await _audioPlayer.seek(
                            Duration(seconds: value.toInt()),
                          );
                        },
                        activeColor: AppTheme.primary,
                        inactiveColor: AppTheme.deepBlue.withValues(alpha: 0.2),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(_position),
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 12.sp,
                            color: AppTheme.deepBlue.withValues(alpha: 0.7),
                          ),
                        ),
                        Text(
                          _formatDuration(_duration),
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 12.sp,
                            color: AppTheme.deepBlue.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 3.h),

              // Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _playPrevious,
                    icon: const Icon(Icons.skip_previous),
                    color: AppTheme.deepBlue,
                    iconSize: 28.sp,
                  ),
                  SizedBox(width: 3.w),
                  Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4ECDC4).withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: _playPause,
                      child: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 32.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  IconButton(
                    onPressed: _playNext,
                    icon: const Icon(Icons.skip_next),
                    color: AppTheme.deepBlue,
                    iconSize: 28.sp,
                  ),
                ],
              ),

              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }
}
