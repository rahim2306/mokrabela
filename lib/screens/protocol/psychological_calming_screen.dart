import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/screens/child/music/music_menu_screen.dart';
import 'package:mokrabela/screens/child/stories/story_menu_screen.dart';
import 'package:mokrabela/screens/protocol/drawing_canvas_screen.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:mokrabela/services/protocol_service.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class PsychologicalCalmingScreen extends StatefulWidget {
  const PsychologicalCalmingScreen({super.key});

  @override
  State<PsychologicalCalmingScreen> createState() =>
      _PsychologicalCalmingScreenState();
}

class _PsychologicalCalmingScreenState
    extends State<PsychologicalCalmingScreen> {
  final ProtocolService _protocolService = ProtocolService();
  final AuthService _authService = AuthService();
  bool _isSaving = false;

  Future<void> _completeSession() async {
    setState(() => _isSaving = true);
    try {
      final user = _authService.currentUser;
      if (user != null) {
        await _protocolService.updateProtocolProgress(user.uid, 4);

        if (mounted) {
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
      body: Stack(
        children: [
          // Background Gradient
          Container(
            width: double.infinity,
            height: 100.h,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF093FB), Color(0xFFF5576C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Header (Hero target)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                      const Spacer(),
                      Hero(
                        tag: 'calming_card',
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            l10n.square4Title,
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 48,
                        height: 48,
                      ), // Placeholder for balance
                    ],
                  ),
                ),

                // Content Area
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(6.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.square4Desc,
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.deepBlue,
                              letterSpacing: -0.5,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            l10n.protocolExplanation,
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 11.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 4.h),

                          // Tools Grid/List
                          _buildPremiumToolCard(
                            l10n.expressYourself,
                            l10n.drawingCanvas,
                            Icons.palette_rounded,
                            const Color(0xFFF093FB),
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DrawingCanvasScreen(),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          _buildPremiumToolCard(
                            l10n.calmingSounds,
                            l10n.calmMusicTrackDesc,
                            Icons.headset_rounded,
                            const Color(0xFF667EEA),
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MusicMenuScreen(),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          _buildPremiumToolCard(
                            l10n.bedtimeStories,
                            l10n.braveStarDesc,
                            Icons.auto_stories_rounded,
                            const Color(0xFFFFA751),
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const StoryMenuScreen(),
                              ),
                            ),
                          ),

                          SizedBox(height: 6.h),

                          // Finish Button
                          Center(
                            child: ElevatedButton(
                              onPressed: _isSaving ? null : _completeSession,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF5576C),
                                foregroundColor: Colors.white,
                                minimumSize: Size(double.infinity, 8.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                elevation: 0,
                              ),
                              child: _isSaving
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      l10n.feelingCooler,
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumToolCard(
    String title,
    String desc,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            width: 80.w, // Stabilized width for Hero transition
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 24.sp),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.spaceGrotesk(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          color: AppTheme.deepBlue,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        desc,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 10.sp,
                          color: Colors.grey[600],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
