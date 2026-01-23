import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/story_model.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:mokrabela/services/session_service.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class StoryReaderScreen extends StatefulWidget {
  final Story story;

  const StoryReaderScreen({super.key, required this.story});

  @override
  State<StoryReaderScreen> createState() => _StoryReaderScreenState();
}

class _StoryReaderScreenState extends State<StoryReaderScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  bool _hasRecordedCompletion = false;
  final SessionService _sessionService = SessionService();
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      final newPage = _pageController.page?.round() ?? 0;
      if (newPage != _currentPage) {
        setState(() {
          _currentPage = newPage;
        });

        // Check if user reached the final page
        if (_currentPage == widget.story.pages.length - 1 &&
            !_hasRecordedCompletion) {
          _recordStoryCompletion();
        }
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Record story completion when user reaches the final page
  Future<void> _recordStoryCompletion() async {
    if (_hasRecordedCompletion) return;

    _hasRecordedCompletion = true;

    try {
      final user = _authService.currentUser;
      if (user == null) return;

      final now = DateTime.now();
      final l10n = AppLocalizations.of(context)!;

      await _sessionService.saveSession(
        childId: user.uid,
        type: 'story',
        exerciseName: widget.story.getTitle(l10n.localeName),
        exerciseType: widget.story.id,
        startTime: now,
        endTime: now,
        completed: true,
        exerciseData: {
          'storyId': widget.story.id,
          'pagesRead': widget.story.pages.length,
        },
        context: context,
      );
    } catch (e) {
      print('Error recording story completion: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              widget.story.gradient.first.withValues(alpha: 0.1),
              widget.story.gradient.last.withValues(alpha: 0.05),
              const Color(0xFFFFFBF5),
            ],
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
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 1.h,
                          ),
                          decoration: BoxDecoration(
                            color: widget.story.gradient.first.withValues(
                              alpha: 0.15,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            l10n.pageIndicator(
                              _currentPage + 1,
                              widget.story.pages.length,
                            ),
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.deepBlue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 48),
                  ],
                ),
              ),

              // Page View with Peel Effect
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.story.pages.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _buildPage(widget.story.pages[index], index);
                  },
                ),
              ),

              // Navigation Hint
              Padding(
                padding: EdgeInsets.all(2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_currentPage > 0)
                      Icon(
                        Icons.arrow_back_ios,
                        color: AppTheme.deepBlue.withValues(alpha: 0.5),
                        size: 5.w,
                      ),
                    SizedBox(width: 2.w),
                    Text(
                      _currentPage < widget.story.pages.length - 1
                          ? l10n.swipeToTurnPage
                          : l10n.theEnd,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.deepBlue.withValues(alpha: 0.6),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    if (_currentPage < widget.story.pages.length - 1)
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppTheme.deepBlue.withValues(alpha: 0.5),
                        size: 5.w,
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

  Widget _buildPage(StoryPage page, int pageIndex) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: widget.story.gradient.first.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Story icon on first page only
          if (pageIndex == 0)
            Container(
              width: 18.w,
              height: 18.w,
              margin: EdgeInsets.only(bottom: 3.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: widget.story.gradient),
                shape: BoxShape.circle,
              ),
              child: Icon(widget.story.icon, color: Colors.white, size: 9.w),
            ),

          // Content text
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Text(
                  _getPageContent(context, page),
                  style: GoogleFonts.merriweather(
                    fontSize: 16.sp,
                    height: 1.8,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.deepBlue,
                    letterSpacing: 0.3,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),

          // Page number
          SizedBox(height: 2.h),
          Text(
            '${pageIndex + 1}',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppTheme.deepBlue.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }

  String _getPageContent(BuildContext context, StoryPage page) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    // Try localized content first (for Firestore stories)
    if (page.localizedContent != null) {
      return page.getContent(locale);
    }

    // Fallback to l10n for hardcoded stories
    final contentKey = page.contentKey;

    // Map content keys to localized strings
    switch (contentKey) {
      // Brave Star pages
      case 'braveStarPage1':
        return l10n.braveStarPage1;
      case 'braveStarPage2':
        return l10n.braveStarPage2;
      case 'braveStarPage3':
        return l10n.braveStarPage3;
      case 'braveStarPage4':
        return l10n.braveStarPage4;
      case 'braveStarPage5':
        return l10n.braveStarPage5;
      case 'braveStarPage6':
        return l10n.braveStarPage6;

      // Magic Garden pages
      case 'magicGardenPage1':
        return l10n.magicGardenPage1;
      case 'magicGardenPage2':
        return l10n.magicGardenPage2;
      case 'magicGardenPage3':
        return l10n.magicGardenPage3;
      case 'magicGardenPage4':
        return l10n.magicGardenPage4;
      case 'magicGardenPage5':
        return l10n.magicGardenPage5;
      case 'magicGardenPage6':
        return l10n.magicGardenPage6;

      // Friendly Dragon pages
      case 'friendlyDragonPage1':
        return l10n.friendlyDragonPage1;
      case 'friendlyDragonPage2':
        return l10n.friendlyDragonPage2;
      case 'friendlyDragonPage3':
        return l10n.friendlyDragonPage3;
      case 'friendlyDragonPage4':
        return l10n.friendlyDragonPage4;
      case 'friendlyDragonPage5':
        return l10n.friendlyDragonPage5;
      case 'friendlyDragonPage6':
        return l10n.friendlyDragonPage6;

      default:
        return contentKey;
    }
  }
}
