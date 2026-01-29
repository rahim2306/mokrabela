import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/components/cards/sticky_info_card.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/screens/child/focus/memory_game_screen.dart';
import 'package:mokrabela/screens/child/focus/math_puzzle_game.dart';
import 'package:mokrabela/screens/child/focus/memory_sequence_game.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class FocusGamesMenuScreen extends StatelessWidget {
  final int? protocolSquare;
  const FocusGamesMenuScreen({super.key, this.protocolSquare});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          l10n.focusGamesTitle,
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
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // Game Cards List
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(6.w, 4.h, 6.w, 25.h),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          _buildGameCard(
                            context,
                            title: l10n.memoryFlipTitle,
                            description: l10n.memoryFlipDesc,
                            icon: Icons.flip,
                            gradient: const [
                              Color(0xFF667EEA),
                              Color(0xFF764BA2),
                            ],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MemoryGameScreen(
                                    protocolSquare: protocolSquare,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 3.h),
                          _buildGameCard(
                            context,
                            title: "Math Puzzle",
                            description: "Solve math problems against time!",
                            icon: Icons.calculate_rounded,
                            gradient: const [
                              Color(0xFFFF9A9E),
                              Color(0xFFFECFEF),
                            ],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MathPuzzleGame(
                                    protocolSquare: protocolSquare,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 3.h),
                          _buildGameCard(
                            context,
                            title: "Memory Sequence",
                            description: "Remember and repeat the sequence!",
                            icon: Icons.psychology_rounded,
                            gradient: const [
                              Color(0xFFA18CD1),
                              Color(0xFFFBC2EB),
                            ],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MemorySequenceGame(
                                    protocolSquare: protocolSquare,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Sticky info card at bottom
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: StickyInfoCard(
                  title: l10n.whyFocusGamesTitle,
                  description: l10n.whyFocusGamesDesc,
                  icon: Icons.psychology,
                  iconColor: const Color(0xFF00897B), // Teal
                  iconBackgroundColor: const Color(0xFF4DB6AC), // Light Teal
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 20.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: gradient.first.withValues(alpha: 0.4),
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
            onTap: onTap,
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
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                    child: Icon(icon, color: Colors.white, size: 8.w),
                  ),
                  SizedBox(width: 4.w),
                  // Text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          description,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
