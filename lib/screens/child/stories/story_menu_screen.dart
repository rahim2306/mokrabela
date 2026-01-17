import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/story_model.dart';
import 'package:mokrabela/screens/child/stories/story_reader_screen.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class StoryMenuScreen extends StatelessWidget {
  const StoryMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final stories = Story.getAllStories();

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
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
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
                      color: story.gradient.first.withValues(alpha: 0.4),
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
                                StoryReaderScreen(story: story),
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
                                color: Colors.white.withValues(alpha: 0.25),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.3),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                        '${story.pages.length} pages',
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white.withValues(
                                            alpha: 0.8,
                                          ),
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
          ),
        ),
      ),
    );
  }

  String _getStoryTitle(AppLocalizations l10n, Story story) {
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
