import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/components/cards/sticky_info_card.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/story_model.dart';
import 'package:mokrabela/screens/child/stories/story_reader_screen.dart';
import 'package:mokrabela/services/story_service.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class StoryMenuScreen extends StatefulWidget {
  final int? protocolSquare;
  const StoryMenuScreen({super.key, this.protocolSquare});

  @override
  State<StoryMenuScreen> createState() => _StoryMenuScreenState();
}

class _StoryMenuScreenState extends State<StoryMenuScreen> {
  final StoryService _storyService = StoryService();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          l10n.storiesTitle,
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
            colors: [Color(0xFFFAFAFA), Color(0xFFFFF3E0), Color(0xFFFAFAFA)],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              StreamBuilder<List<Story>>(
                stream: _storyService.getStories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    print('Story stream error: ${snapshot.error}');
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red,
                          ),
                          SizedBox(height: 2.h),
                          Text(l10n.errorLoadingStories),
                          Text(
                            '${snapshot.error}',
                            style: TextStyle(fontSize: 10.sp),
                          ),
                        ],
                      ),
                    );
                  }

                  final stories = snapshot.data ?? Story.getAllStories();
                  print('Stories loaded: ${stories.length}');

                  if (stories.isEmpty) {
                    return Center(child: Text(l10n.noStoriesAvailable));
                  }

                  return ListView.builder(
                    padding: EdgeInsets.fromLTRB(6.w, 2.h, 6.w, 25.h),
                    itemCount: stories.length,
                    itemBuilder: (context, index) {
                      final story = stories[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 3.h),
                        height: 22.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: story.gradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: story.gradient.first.withValues(
                                alpha: 0.4,
                              ),
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
                                    builder: (context) => StoryReaderScreen(
                                      story: story,
                                      protocolSquare: widget.protocolSquare,
                                    ),
                                  ),
                                );
                              },

                              child: Padding(
                                padding: EdgeInsets.all(3.h),
                                child: Row(
                                  children: [
                                    // Icon
                                    Container(
                                      width: 18.w,
                                      height: 18.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.25,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.white.withValues(
                                            alpha: 0.3,
                                          ),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Icon(
                                        story.icon,
                                        color: Colors.white,
                                        size: 10.w,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    // Text
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            _getStoryTitle(l10n, story),
                                            style: GoogleFonts.spaceGrotesk(
                                              fontSize: 19.sp,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 1.h),
                                          Text(
                                            _getStoryDescription(l10n, story),
                                            style: GoogleFonts.spaceGrotesk(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white.withValues(
                                                alpha: 0.9,
                                              ),
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 1.h),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.menu_book,
                                                color: Colors.white.withValues(
                                                  alpha: 0.8,
                                                ),
                                                size: 4.w,
                                              ),
                                              SizedBox(width: 1.w),
                                              Text(
                                                l10n.pagesCount(
                                                  story.pages.length,
                                                ),
                                                style: GoogleFonts.spaceGrotesk(
                                                  fontSize: 11.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white
                                                      .withValues(alpha: 0.8),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 6.w,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

              // Sticky info card at bottom
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: StickyInfoCard(
                  title: l10n.whyStoriesTitle,
                  description: l10n.whyStoriesDesc,
                  icon: Icons.auto_stories,
                  iconColor: const Color(0xFFFF6F00), // Orange
                  iconBackgroundColor: const Color(0xFFFFB74D), // Light Orange
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getStoryTitle(AppLocalizations l10n, Story story) {
    final locale = Localizations.localeOf(context).languageCode;
    // Try localized title first
    final localizedTitle = story.getTitle(locale);
    if (localizedTitle != story.titleKey) {
      return localizedTitle;
    }
    // Fallback to l10n for hardcoded stories
    switch (story.titleKey) {
      case 'braveStarTitle':
        return l10n.braveStarTitle;
      case 'magicGardenTitle':
        return l10n.magicGardenTitle;
      case 'friendlyDragonTitle':
        return l10n.friendlyDragonTitle;
      default:
        return story.titleKey;
    }
  }

  String _getStoryDescription(AppLocalizations l10n, Story story) {
    final locale = Localizations.localeOf(context).languageCode;
    // Try localized description first
    final localizedDesc = story.getDescription(locale);
    if (localizedDesc != story.descriptionKey) {
      return localizedDesc;
    }
    // Fallback to l10n for hardcoded stories
    switch (story.descriptionKey) {
      case 'braveStarDesc':
        return l10n.braveStarDesc;
      case 'magicGardenDesc':
        return l10n.magicGardenDesc;
      case 'friendlyDragonDesc':
        return l10n.friendlyDragonDesc;
      default:
        return story.descriptionKey;
    }
  }
}
