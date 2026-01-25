import 'package:flutter/material.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/components/selectors/emotion_selector.dart';
import 'package:mokrabela/components/cards/live_sensor_card.dart';
import 'package:mokrabela/screens/protocol/body_scan_screen.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:mokrabela/services/protocol_service.dart';
import 'package:mokrabela/services/session_service.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sizer/sizer.dart';

class SelfAwarenessScreen extends StatefulWidget {
  const SelfAwarenessScreen({super.key});

  @override
  State<SelfAwarenessScreen> createState() => _SelfAwarenessScreenState();
}

class _SelfAwarenessScreenState extends State<SelfAwarenessScreen> {
  final AuthService _authService = AuthService();
  final ProtocolService _protocolService = ProtocolService();
  final SessionService _sessionService = SessionService();
  String? _selectedEmotion;
  double _activityScale = 5.0;
  bool _isSaving = false;
  late DateTime _screenStartTime;

  List<Map<String, dynamic>> _getEmotions(AppLocalizations l10n) => [
    {'label': l10n.emotionHappy, 'emoji': '😊', 'key': 'Happy'},
    {'label': l10n.emotionSad, 'emoji': '😢', 'key': 'Sad'},
    {'label': l10n.emotionAngry, 'emoji': '😡', 'key': 'Angry'},
    {'label': l10n.emotionAnxious, 'emoji': '😰', 'key': 'Anxious'},
    {'label': l10n.emotionCalm, 'emoji': '😌', 'key': 'Calm'},
    {'label': l10n.emotionTired, 'emoji': '😴', 'key': 'Tired'},
  ];

  @override
  void initState() {
    super.initState();
    _screenStartTime = DateTime.now();
  }

  Future<void> _saveReport() async {
    if (_selectedEmotion == null) return;

    setState(() => _isSaving = true);
    try {
      final user = _authService.currentUser;
      if (user != null) {
        // Record as a formal session (automatically captures watch biometrics)
        await _sessionService.saveSession(
          childId: user.uid,
          type: 'focus',
          exerciseName: 'Self Awareness',
          exerciseType: 'body_check_log',
          protocolSquare: 1,
          startTime: _screenStartTime,
          endTime: DateTime.now(),
          completed: true,
          exerciseData: {
            'selectedEmotion': _selectedEmotion,
            'userReportedActivityScale': _activityScale,
          },
          context: context,
        );

        // Also ensure protocol state is updated
        await _protocolService.updateProtocolProgress(user.uid, 1);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.reportSaved)),
          );
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.errorOccurred(e.toString()),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.kidsBackgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Navigation Row
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppTheme.deepBlue,
                        size: 20.sp,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      l10n.square1Title,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.deepBlue,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                // Section 1: Guided Body Scan (Hero target)
                Hero(
                  tag: 'awareness_card',
                  child: Material(
                    color: Colors.transparent,
                    child: _buildSpecialToolCard(
                      l10n.guidedBodyScan,
                      l10n.bodyScanDesc,
                      Icons.accessibility_new_rounded,
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BodyScanScreen(),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),

                // Section 2: Live Sensors
                Container(
                  padding: EdgeInsets.all(1.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primary.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const LiveSensorCard(),
                ),
                SizedBox(height: 4.h),

                // Section 3: Emotional Log
                Text(
                  l10n.howAreYouFeeling,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.deepBlue,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 2.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 3.w,
                    mainAxisSpacing: 3.w,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: _getEmotions(l10n).length,
                  itemBuilder: (context, index) {
                    final emotions = _getEmotions(l10n);
                    final emotion = emotions[index];
                    return EmotionSelector(
                      label: emotion['label']!,
                      emoji: emotion['emoji']!,
                      isSelected: _selectedEmotion == emotion['key'],
                      onTap: () =>
                          setState(() => _selectedEmotion = emotion['key']),
                    );
                  },
                ),
                SizedBox(height: 4.h),

                // Section 4: Activity Scale
                _buildActivityScale(l10n),
                SizedBox(height: 4.h),

                // Save Button
                _buildSaveButton(l10n),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton(AppLocalizations l10n) {
    final bool canSave = _selectedEmotion != null && !_isSaving;
    return Container(
      width: double.infinity,
      height: 7.5.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: canSave
            ? const LinearGradient(
                colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
              )
            : null,
        color: canSave ? null : Colors.grey[300],
        boxShadow: canSave
            ? [
                BoxShadow(
                  color: const Color(0xFF4ECDC4).withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ]
            : [],
      ),
      child: ElevatedButton(
        onPressed: canSave ? _saveReport : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: _isSaving
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                l10n.saveSession,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Widget _buildSpecialToolCard(
    String title,
    String desc,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 2.h),
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4ECDC4).withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            width: 80.w, // Calculated as (100.w - 2*6.w) - 2*4.w
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 24.sp),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.spaceGrotesk(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        desc,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 10.sp,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 4.w),
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: const Color(0xFF44A08D),
                    size: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityScale(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.activityLevel,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 16.sp,
            fontWeight: FontWeight.w800,
            color: AppTheme.deepBlue,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 2.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: _getActivityColor(_activityScale),
                  inactiveTrackColor: Colors.grey[200],
                  thumbColor: Colors.white,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 12.0,
                    elevation: 4,
                  ),
                  overlayColor: _getActivityColor(
                    _activityScale,
                  ).withValues(alpha: 0.2),
                  trackHeight: 8.0,
                  trackShape: const RoundedRectSliderTrackShape(),
                ),
                child: Slider(
                  value: _activityScale,
                  min: 1.0,
                  max: 10.0,
                  divisions: 9,
                  label: _activityScale.toInt().toString(),
                  onChanged: (val) => setState(() => _activityScale = val),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '🧘 ${l10n.quiet}',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      '⚡ ${l10n.hyper}',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getActivityColor(double value) {
    if (value <= 3) return Colors.green;
    if (value <= 7) return Colors.orange;
    return Colors.red;
  }
}
