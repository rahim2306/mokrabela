import 'package:flutter/material.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:mokrabela/models/achievement_model.dart';
import 'package:mokrabela/components/cards/achievement_card.dart';
import 'package:mokrabela/services/achievement_service.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:sizer/sizer.dart';

/// Kids Achievements Screen - Rewards and achievements list
class KidsAchievementsScreen extends StatefulWidget {
  const KidsAchievementsScreen({super.key});

  @override
  State<KidsAchievementsScreen> createState() => _KidsAchievementsScreenState();
}

class _KidsAchievementsScreenState extends State<KidsAchievementsScreen> {
  final AchievementService _achievementService = AchievementService();
  final AuthService _authService = AuthService();
  AchievementCategory? _selectedCategory;
  bool _showOnlyUnlocked = false;

  @override
  void initState() {
    super.initState();
    _initializeAchievements();
  }

  Future<void> _initializeAchievements() async {
    final user = _authService.currentUser;
    if (user != null) {
      // Initialize achievements if this is first time
      await _achievementService.initializeAchievements(user.uid);
    }
  }

  List<Achievement> _getFilteredAchievements(List<Achievement> achievements) {
    var filtered = achievements;

    // Filter by category
    if (_selectedCategory != null) {
      filtered = filtered
          .where((achievement) => achievement.category == _selectedCategory)
          .toList();
    }

    // Filter by unlock status
    if (_showOnlyUnlocked) {
      filtered = filtered
          .where((achievement) => achievement.isUnlocked)
          .toList();
    }

    return filtered;
  }

  int _getTotalPoints(List<Achievement> achievements) {
    return achievements
        .where((achievement) => achievement.isUnlocked)
        .fold(0, (sum, achievement) => sum + achievement.points);
  }

  int _getUnlockedCount(List<Achievement> achievements) {
    return achievements.where((achievement) => achievement.isUnlocked).length;
  }

  int _getCurrentLevel(int totalPoints) {
    // Simple level calculation: 1 level per 500 points
    return (totalPoints / 500).floor() + 1;
  }

  double _getLevelProgress(int totalPoints) {
    final pointsInCurrentLevel = totalPoints % 500;
    return pointsInCurrentLevel / 500;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = _authService.currentUser;

    if (user == null) {
      return Center(
        child: Text(
          'Please log in to view achievements',
          style: TextStyle(fontSize: 16.sp),
        ),
      );
    }

    return StreamBuilder<List<Achievement>>(
      stream: _achievementService.getAchievements(user.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading achievements',
              style: TextStyle(fontSize: 16.sp),
            ),
          );
        }

        final achievements = snapshot.data ?? [];
        final filteredAchievements = _getFilteredAchievements(achievements);
        final totalPoints = _getTotalPoints(achievements);
        final unlockedCount = _getUnlockedCount(achievements);
        final currentLevel = _getCurrentLevel(totalPoints);
        final levelProgress = _getLevelProgress(totalPoints);

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),

              // Stats Header
              _buildStatsHeader(
                l10n,
                totalPoints,
                unlockedCount,
                achievements.length,
                currentLevel,
                levelProgress,
              ),

              SizedBox(height: 3.h),

              // Category Filters
              _buildCategoryFilters(l10n),

              SizedBox(height: 2.h),

              // Filter Toggle
              _buildFilterToggle(l10n),

              SizedBox(height: 2.h),

              // Achievements Grid
              _buildAchievementsGrid(filteredAchievements),

              SizedBox(height: 10.h), // Space for bottom nav
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatsHeader(
    AppLocalizations l10n,
    int totalPoints,
    int unlockedCount,
    int totalCount,
    int currentLevel,
    double levelProgress,
  ) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4ECDC4).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Total Points
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Points',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    totalPoints.toString(),
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.stars, size: 32.sp, color: Colors.white),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Level Progress
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Level $currentLevel',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${(levelProgress * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: levelProgress,
                  backgroundColor: Colors.white.withValues(alpha: 0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 8,
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),

          // Achievement Count
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.emoji_events, size: 20.sp, color: Colors.white),
              SizedBox(width: 2.w),
              Text(
                '$unlockedCount/$totalCount Achievements',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilters(AppLocalizations l10n) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildCategoryChip('All', null, Icons.grid_view),
          SizedBox(width: 2.w),
          _buildCategoryChip(
            'Exercise',
            AchievementCategory.exercise,
            Icons.air,
          ),
          SizedBox(width: 2.w),
          _buildCategoryChip(
            'Streaks',
            AchievementCategory.streaks,
            Icons.local_fire_department,
          ),
          SizedBox(width: 2.w),
          _buildCategoryChip(
            'Calm',
            AchievementCategory.calm,
            Icons.self_improvement,
          ),
          SizedBox(width: 2.w),
          _buildCategoryChip(
            'Milestones',
            AchievementCategory.milestones,
            Icons.celebration,
          ),
          SizedBox(width: 2.w),
          _buildCategoryChip(
            'Special',
            AchievementCategory.special,
            Icons.workspace_premium,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(
    String label,
    AchievementCategory? category,
    IconData icon,
  ) {
    final isSelected = _selectedCategory == category;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : AppTheme.primary.withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF4ECDC4).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18.sp,
              color: isSelected ? Colors.white : AppTheme.deepBlue,
            ),
            SizedBox(width: 2.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : AppTheme.deepBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterToggle(AppLocalizations l10n) {
    return Row(
      children: [
        Checkbox(
          value: _showOnlyUnlocked,
          onChanged: (value) {
            setState(() {
              _showOnlyUnlocked = value ?? false;
            });
          },
          activeColor: AppTheme.primary,
        ),
        Text(
          'Show only unlocked',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppTheme.deepBlue,
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementsGrid(List<Achievement> filteredAchievements) {
    if (filteredAchievements.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Column(
            children: [
              Icon(
                Icons.search_off,
                size: 48.sp,
                color: AppTheme.textSecondary.withValues(alpha: 0.5),
              ),
              SizedBox(height: 2.h),
              Text(
                'No achievements found',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 3.w,
        mainAxisSpacing: 2.h,
      ),
      itemCount: filteredAchievements.length,
      itemBuilder: (context, index) {
        return AchievementCard(
          achievement: filteredAchievements[index],
          onTap: () {
            // TODO: Show achievement detail modal
          },
        );
      },
    );
  }
}
