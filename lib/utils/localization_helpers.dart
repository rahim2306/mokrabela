import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/achievement_model.dart';

extension AppLocalizationsX on AppLocalizations {
  /// Maps an achievement title or description key to its localized string
  String getAchievementString(String key) {
    switch (key) {
      // Titles
      case 'achFirstBreathing':
        return achFirstBreathing;
      case 'achBreathing5':
        return achBreathing5;
      case 'achBreathing10':
        return achBreathing10;
      case 'achBreathingMaster':
        return achBreathingMaster;
      case 'achFirstFocus':
        return achFirstFocus;
      case 'achFocusChampion':
        return achFocusChampion;
      case 'achMusicBeginner':
        return achMusicBeginner;
      case 'achMusicExpert':
        return achMusicExpert;
      case 'achStoryStarter':
        return achStoryStarter;
      case 'achStoryMaster':
        return achStoryMaster;
      case 'achStreak3':
        return achStreak3;
      case 'achStreak7':
        return achStreak7;
      case 'achStreak14':
        return achStreak14;
      case 'achStreak30':
        return achStreak30;
      case 'achEarlyBird':
        return achEarlyBird;
      case 'achCalm10':
        return achCalm10;
      case 'achCalm30':
        return achCalm30;
      case 'achCalm60':
        return achCalm60;
      case 'achReduceHyper20':
        return achReduceHyper20;
      case 'achReduceHyper50':
        return achReduceHyper50;
      case 'achPerfectPosture':
        return achPerfectPosture;
      case 'achFirstDay':
        return achFirstDay;
      case 'achFirstWeek':
        return achFirstWeek;
      case 'achFirstMonth':
        return achFirstMonth;
      case 'achTasks100':
        return achTasks100;
      case 'achTasks500':
        return achTasks500;
      case 'achTasks1000':
        return achTasks1000;
      case 'achQuickLearner':
        return achQuickLearner;
      case 'achOverachiever':
        return achOverachiever;
      case 'achCalmMaster':
        return achCalmMaster;
      case 'achExplorer':
        return achExplorer;

      // Descriptions
      case 'achFirstBreathingDesc':
        return achFirstBreathingDesc;
      case 'achBreathing5Desc':
        return achBreathing5Desc;
      case 'achBreathing10Desc':
        return achBreathing10Desc;
      case 'achBreathingMasterDesc':
        return achBreathingMasterDesc;
      case 'achFirstFocusDesc':
        return achFirstFocusDesc;
      case 'achFocusChampionDesc':
        return achFocusChampionDesc;
      case 'achMusicBeginnerDesc':
        return achMusicBeginnerDesc;
      case 'achMusicExpertDesc':
        return achMusicExpertDesc;
      case 'achStoryStarterDesc':
        return achStoryStarterDesc;
      case 'achStoryMasterDesc':
        return achStoryMasterDesc;
      case 'achStreak3Desc':
        return achStreak3Desc;
      case 'achStreak7Desc':
        return achStreak7Desc;
      case 'achStreak14Desc':
        return achStreak14Desc;
      case 'achStreak30Desc':
        return achStreak30Desc;
      case 'achEarlyBirdDesc':
        return achEarlyBirdDesc;
      case 'achCalm10Desc':
        return achCalm10Desc;
      case 'achCalm30Desc':
        return achCalm30Desc;
      case 'achCalm60Desc':
        return achCalm60Desc;
      case 'achReduceHyper20Desc':
        return achReduceHyper20Desc;
      case 'achReduceHyper50Desc':
        return achReduceHyper50Desc;
      case 'achPerfectPostureDesc':
        return achPerfectPostureDesc;
      case 'achFirstDayDesc':
        return achFirstDayDesc;
      case 'achFirstWeekDesc':
        return achFirstWeekDesc;
      case 'achFirstMonthDesc':
        return achFirstMonthDesc;
      case 'achTasks100Desc':
        return achTasks100Desc;
      case 'achTasks500Desc':
        return achTasks500Desc;
      case 'achTasks1000Desc':
        return achTasks1000Desc;
      case 'achQuickLearnerDesc':
        return achQuickLearnerDesc;
      case 'achOverachieverDesc':
        return achOverachieverDesc;
      case 'achCalmMasterDesc':
        return achCalmMasterDesc;
      case 'achExplorerDesc':
        return achExplorerDesc;

      // Rarities
      case 'COMMON':
      case 'rarityCommon':
        return rarityCommon;
      case 'RARE':
      case 'rarityRare':
        return rarityRare;
      case 'EPIC':
      case 'rarityEpic':
        return rarityEpic;
      case 'LEGENDARY':
      case 'rarityLegendary':
        return rarityLegendary;

      default:
        return key;
    }
  }

  /// Maps an achievement category to its localized string
  String getCategoryString(AchievementCategory category) {
    switch (category) {
      case AchievementCategory.exercise:
        return categoryExercise;
      case AchievementCategory.streaks:
        return categoryStreaks;
      case AchievementCategory.calm:
        return categoryCalm;
      case AchievementCategory.milestones:
        return categoryMilestones;
      case AchievementCategory.special:
        return categorySpecial;
    }
  }
}
