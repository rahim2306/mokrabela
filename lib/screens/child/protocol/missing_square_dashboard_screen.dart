import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

/// Missing Square Protocol Dashboard - 4 therapeutic squares
class MissingSquareDashboardScreen extends StatelessWidget {
  const MissingSquareDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          l10n.missingSquareProtocol,
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
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: AppTheme.deepBlue),
            onPressed: () => _showProtocolExplanation(context, l10n),
          ),
        ],
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
          child: Column(
            children: [
              SizedBox(height: 2.h),
              // Subtitle
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Text(
                  l10n.protocolExplanation,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.deepBlue.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 3.h),
              // 4 Squares Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  mainAxisSpacing: 3.h,
                  crossAxisSpacing: 3.w,
                  children: [
                    _buildSquareCard(
                      context,
                      title: l10n.square1Title,
                      description: l10n.square1Desc,
                      icon: Icons.psychology,
                      gradient: const [Color(0xFF4ECDC4), Color(0xFF44A08D)],
                      onTap: () {
                        // TODO: Navigate to Self Awareness Screen
                        _showComingSoon(context, l10n.square1Title);
                      },
                    ),
                    _buildSquareCard(
                      context,
                      title: l10n.square2Title,
                      description: l10n.square2Desc,
                      icon: Icons.air,
                      gradient: const [Color(0xFF667EEA), Color(0xFF764BA2)],
                      onTap: () {
                        // TODO: Navigate to Self Regulation Screen
                        _showComingSoon(context, l10n.square2Title);
                      },
                    ),
                    _buildSquareCard(
                      context,
                      title: l10n.square3Title,
                      description: l10n.square3Desc,
                      icon: Icons.task_alt,
                      gradient: const [Color(0xFFFFE259), Color(0xFFFFA751)],
                      onTap: () {
                        // TODO: Navigate to Daily Tasks Screen
                        _showComingSoon(context, l10n.square3Title);
                      },
                    ),
                    _buildSquareCard(
                      context,
                      title: l10n.square4Title,
                      description: l10n.square4Desc,
                      icon: Icons.self_improvement,
                      gradient: const [Color(0xFFF093FB), Color(0xFFF5576C)],
                      onTap: () {
                        // TODO: Navigate to Psychological Calming Screen
                        _showComingSoon(context, l10n.square4Title);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSquareCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
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
        child: Padding(
          padding: EdgeInsets.all(3.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                padding: EdgeInsets.all(2.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, size: 32.sp, color: Colors.white),
              ),
              SizedBox(height: 2.h),
              // Title
              Text(
                title,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.3,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 0.5.h),
              // Description
              Text(
                description,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.85),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showProtocolExplanation(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          l10n.missingSquareProtocol,
          style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w800),
        ),
        content: Text(
          l10n.protocolExplanation,
          style: GoogleFonts.spaceGrotesk(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: GoogleFonts.spaceGrotesk()),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature - Coming soon!'),
        backgroundColor: AppTheme.info,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
