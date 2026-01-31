// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'MokraBela';

  @override
  String get welcome => 'Welcome';

  @override
  String hello(String name) {
    return 'Hello, $name!';
  }

  @override
  String get languageSelector => 'Select Language';

  @override
  String get english => 'English';

  @override
  String get french => 'French';

  @override
  String get arabic => 'Arabic';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String currentLanguage(String language) {
    return 'Current Language: $language';
  }

  @override
  String get welcomeToMokrabela => 'Welcome to MokraBela';

  @override
  String get welcomeSubtitle =>
      'Helping children feel calmer, more focused, and supported—together.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get logIn => 'Log in';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get loginSubtitle => 'Sign in to continue your journey.';

  @override
  String get loginFailed => 'Login failed. Please check your credentials.';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get onboardingQuestion1 => 'Which sentence describes you the best?';

  @override
  String get optionParent =>
      'I am a parent who wants to monitor my child\'s progress.';

  @override
  String get optionTeacher => 'I am a teacher who works with students.';

  @override
  String get next => 'Next';

  @override
  String get back => 'Back';

  @override
  String get skip => 'Skip';

  @override
  String get intro1Title => 'Support Comes First';

  @override
  String get intro1Description =>
      'Children don\'t regulate alone. With guidance from parents and teachers, calm becomes a habit.';

  @override
  String get intro2Title => 'Building Inner Calm';

  @override
  String get intro2Description =>
      'Step by step, children learn to calm themselves, focus better, and feel in control.';

  @override
  String welcomeChild(String name) {
    return 'Welcome, $name!';
  }

  @override
  String get watchConnected => 'Connected';

  @override
  String get watchDisconnected => 'Disconnected';

  @override
  String get dailyProgress => 'Daily Progress';

  @override
  String get todaysCalmTime => 'Today\'s Calm Time';

  @override
  String get minutes => 'minutes';

  @override
  String get dailyCalmGoal => 'Daily Calm Goal';

  @override
  String get goalReached => 'Goal reached!';

  @override
  String tasksRemaining(int count) {
    return '$count Tasks Remaining';
  }

  @override
  String get breathingExercise => 'Breathing';

  @override
  String get focusGames => 'Focus Games';

  @override
  String get calmMusic => 'Calm Music';

  @override
  String get stories => 'Stories';

  @override
  String get missingSquare => 'The Missing Square';

  @override
  String get protocol => 'Protocol';

  @override
  String get focusTimer => 'Focus Timer';

  @override
  String get addTask => 'Add Task';

  @override
  String get myTasks => 'My Tasks';

  @override
  String get start => 'Start';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'Resume';

  @override
  String get reset => 'Reset';

  @override
  String get taskTitle => 'Task Title';

  @override
  String get duration => 'Duration (min)';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get helloLabel => 'Hello';

  @override
  String get letsStartProtocol => 'Let\'s start your protocol';

  @override
  String get missingSquareProtocol => 'Why use the protocol?';

  @override
  String protocolWelcome(String userName) {
    return 'Hello $userName, let\'s start your protocol';
  }

  @override
  String get protocolExplanation =>
      'These 4 squares help you understand feelings, control energy, and find peace.';

  @override
  String get square1Title => 'Self Awareness';

  @override
  String get square1Desc => 'Understand your feelings';

  @override
  String get square2Title => 'Self Regulation';

  @override
  String get square2Desc => 'Control your energy';

  @override
  String get square3Title => 'Daily Tasks';

  @override
  String get square3Desc => 'Organize your time';

  @override
  String get square4Title => 'Psychological Calming';

  @override
  String get square4Desc => 'Find your peace';

  @override
  String get achievements => 'Achievements';

  @override
  String get trophiesTab => 'Trophies';

  @override
  String get mailboxTab => 'Mailbox';

  @override
  String get tapToStart => 'Tap to start';

  @override
  String get goodMorning => 'Good Morning';

  @override
  String get language => 'Language';

  @override
  String get logout => 'Log Out';

  @override
  String get tasks => 'Tasks';

  @override
  String get manageYourTimeWell => 'Manage your\ntime well';

  @override
  String get onboardingQuestion2 => 'When would you like to check in daily?';

  @override
  String get reminderHabitText => 'A gentle reminder helps you build a habit.';

  @override
  String get am => 'AM';

  @override
  String get pm => 'PM';

  @override
  String get tellUsMoreTitle => 'Tell us more about yourself';

  @override
  String get tellUsMoreSubtitle => 'Choose a few words that fit for you';

  @override
  String get profileImage => 'Profile image';

  @override
  String get fullName => 'Full Name';

  @override
  String get firstName => 'First Name';

  @override
  String get familyName => 'Family Name';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get dateOfBirth => 'Date of Birth';

  @override
  String get gender => 'Gender';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get other => 'Other';

  @override
  String get preferNotToSay => 'Prefer not to say';

  @override
  String get goToFinalCheckIn => 'Go To Final Check in';

  @override
  String get iAmA => 'I am a...';

  @override
  String get signUp => 'Sign Up';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get invalidEmail => 'Please enter a valid email';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get invalidPhoneNumber => 'Please enter a valid phone number';

  @override
  String get registrationSuccess => 'Registration successful!';

  @override
  String get registrationFailed => 'Registration failed. Please try again.';

  @override
  String get emailAlreadyInUse => 'This email is already in use';

  @override
  String get weakPassword => 'Password is too weak';

  @override
  String get networkError => 'Network error. Please check your connection.';

  @override
  String get selectGender => 'Select gender';

  @override
  String get selectDate => 'Select date';

  @override
  String get languageShort => 'Eng';

  @override
  String get breathingExercisesTitle => 'Breathing Exercises';

  @override
  String get goldenBreathTitle => 'Golden Breath';

  @override
  String get goldenBreathDesc => 'Short exercise (6s) for energy.';

  @override
  String get butterflyBreathTitle => 'Butterfly Breath';

  @override
  String get butterflyBreathDesc => 'Calm exercise (10s) for deep relaxation.';

  @override
  String get oceanBreathTitle => 'Ocean Breath';

  @override
  String get oceanBreathDesc => 'Exercise (8s) mimicking ocean waves.';

  @override
  String get forestBreathTitle => 'Forest Breath';

  @override
  String get forestBreathDesc => 'Gentle exercise (7s) for balance.';

  @override
  String get seconds => 'seconds';

  @override
  String startExercise(String exercise) {
    return 'Start $exercise...';
  }

  @override
  String get whyBreatheTitle => 'Why breathe consciously?';

  @override
  String get whyBreatheDesc =>
      'Breathing exercises help calm the mind, reduce stress, and improve focus. It\'s a magical way to recharge or relax.';

  @override
  String get whyMusicTitle => 'Why listen to calm music?';

  @override
  String get whyMusicDesc =>
      'Calm music helps create a peaceful environment, reduces anxiety, and enhances relaxation. It\'s perfect for meditation, study, or bedtime.';

  @override
  String get whyStoriesTitle => 'Why read stories?';

  @override
  String get whyStoriesDesc =>
      'Stories spark imagination, teach valuable lessons, and help children relax. They\'re a wonderful way to wind down and dream big!';

  @override
  String get whyFocusGamesTitle => 'Why play focus games?';

  @override
  String get whyFocusGamesDesc =>
      'Focus games help improve concentration, memory, and cognitive skills. It\'s a fun way to train your brain and boost mental agility!';

  @override
  String get breatheIn => 'Breathe In';

  @override
  String get breatheOut => 'Breathe Out';

  @override
  String get cycle => 'Cycle';

  @override
  String get complete => 'Complete!';

  @override
  String breathingComplete(String exercise) {
    return '🎉 $exercise Complete! ✨';
  }

  @override
  String get focusGamesTitle => 'Focus Games';

  @override
  String get memoryFlipTitle => 'Memory Flip';

  @override
  String get memoryFlipDesc =>
      'Match pairs of cards to improve memory and focus';

  @override
  String get moves => 'Moves';

  @override
  String get time => 'Time';

  @override
  String get gameComplete => 'Game Complete!';

  @override
  String get playAgain => 'Play Again';

  @override
  String get wellDone => 'Well Done!';

  @override
  String get calmMusicTitle => 'Calm Music';

  @override
  String get rainSounds => 'Rain Sounds';

  @override
  String get rainSoundsDesc => 'Gentle rain to calm your mind';

  @override
  String get natureAmbience => 'Nature Ambience';

  @override
  String get natureAmbienceDesc => 'Peaceful sounds of nature';

  @override
  String get oceanWaves => 'Ocean Waves';

  @override
  String get oceanWavesDesc => 'Soothing ocean waves';

  @override
  String get calmMusicTrack => 'Calm Music';

  @override
  String get calmMusicTrackDesc => 'Relaxing melodies for peace';

  @override
  String get storiesTitle => 'Stories';

  @override
  String get braveStarTitle => 'The Brave Little Star';

  @override
  String get braveStarDesc => 'A tale of courage and believing in yourself';

  @override
  String get magicGardenTitle => 'The Magic Garden';

  @override
  String get magicGardenDesc => 'Discover the magic of kindness';

  @override
  String get friendlyDragonTitle => 'The Friendly Dragon';

  @override
  String get friendlyDragonDesc => 'A heartwarming story about friendship';

  @override
  String get braveStarPage1 =>
      'Once upon a time, in the vast night sky, there lived a little star named Stella. She was the smallest star in her constellation, but she had the biggest dreams.';

  @override
  String get braveStarPage2 =>
      'Every night, Stella watched the other stars shine brightly. \"I wish I could shine as bright as them,\" she would whisper to the moon.';

  @override
  String get braveStarPage3 =>
      'One night, a dark cloud covered the sky. All the big stars hid behind it, afraid to shine. But Stella thought, \"Someone needs to light the way for the children below.\"';

  @override
  String get braveStarPage4 =>
      'With all her courage, Stella pushed through the cloud. It was hard and scary, but she kept going. Her light began to glow brighter and brighter!';

  @override
  String get braveStarPage5 =>
      'The children on Earth looked up and saw Stella\'s brave light. \"Look! A shooting star!\" they cheered. Stella realized she didn\'t need to be the biggest to make a difference.';

  @override
  String get braveStarPage6 =>
      'From that night on, Stella shone with confidence. She learned that being brave doesn\'t mean you\'re not scared—it means you shine anyway. The End. ⭐';

  @override
  String get magicGardenPage1 =>
      'In a quiet corner of the world, there was a magical garden that only appeared to those who truly believed in magic.';

  @override
  String get magicGardenPage2 =>
      'A curious girl named Maya loved exploring. One sunny day, she followed a golden butterfly and discovered a hidden gate covered in vines.';

  @override
  String get magicGardenPage3 =>
      'As Maya touched the gate, it opened with a gentle glow. Inside was the most beautiful garden she had ever seen—flowers that sang, trees that danced, and streams that sparkled like diamonds.';

  @override
  String get magicGardenPage4 =>
      'In the center of the garden stood a wise old tree. \"Welcome, Maya,\" it said with a warm voice. \"This garden grows from kindness and care. Will you help it bloom?\"';

  @override
  String get magicGardenPage5 =>
      'Maya watered the flowers, sang to the trees, and helped the little creatures. With each kind act, the garden grew more vibrant and magical.';

  @override
  String get magicGardenPage6 =>
      'When it was time to leave, the tree gave Maya a special seed. \"Plant this in your heart,\" it said. \"Kindness is the real magic.\" Maya smiled, knowing she could create magic anywhere. The End. 🌸';

  @override
  String get friendlyDragonPage1 =>
      'High in the misty mountains lived a dragon named Ember. Unlike other dragons, Ember didn\'t want to guard treasure or breathe fire at knights.';

  @override
  String get friendlyDragonPage2 =>
      'Ember just wanted a friend. But whenever he flew down to the village, people would run away screaming. \"I\'m not scary!\" Ember would call out, but no one stayed to listen.';

  @override
  String get friendlyDragonPage3 =>
      'One day, a brave little boy named Leo got lost in the mountains. As night fell and the cold wind blew, Leo began to cry. That\'s when he saw a warm, orange glow.';

  @override
  String get friendlyDragonPage4 =>
      'It was Ember! The dragon gently breathed warm air to keep Leo cozy. \"Don\'t be afraid,\" Ember said softly. \"I\'ll help you get home.\"';

  @override
  String get friendlyDragonPage5 =>
      'Ember flew Leo safely back to the village. When the people saw how kind and gentle the dragon was, they realized they had been wrong to judge him by his appearance.';

  @override
  String get friendlyDragonPage6 =>
      'From that day on, Ember had many friends in the village. He learned that true friendship comes to those who are kind and patient. And Leo learned that the biggest hearts sometimes come in the most unexpected forms. The End. 🐉';

  @override
  String get dtNewTask => 'New Task';

  @override
  String get dtTaskTitlePlaceholder => 'What do you want to focus on?';

  @override
  String get dtTaskDurationLabel => 'Duration (minutes)';

  @override
  String get dtAddButton => 'Add';

  @override
  String get dtCancelButton => 'Cancel';

  @override
  String get howAreYouFeeling => 'How are you feeling?';

  @override
  String get activityLevel => 'Activity Level (1-10)';

  @override
  String get quiet => 'Quiet';

  @override
  String get hyper => 'Hyper';

  @override
  String get guidedBodyScan => 'Guided Body Scan';

  @override
  String get bodyScanDesc => 'Check in with every part of your body.';

  @override
  String get saveSession => 'Save My Session';

  @override
  String get connectWatch => 'Connect Watch';

  @override
  String get watchScanning => 'Scanning for devices...';

  @override
  String get watchFound => 'Device found!';

  @override
  String get watchConnecting => 'Connecting to your watch...';

  @override
  String get watchError => 'Couldn\'t find your watch. Is it turned on?';

  @override
  String get pairNow => 'Pair Now';

  @override
  String get availableDevices => 'Available Devices';

  @override
  String get noDevicesFound => 'No devices found';

  @override
  String get retryScan => 'Retry Scan';

  @override
  String get stopTechnique => 'STOP Technique';

  @override
  String get stopStep1Title => 'S - Stop';

  @override
  String get stopStep1Desc => 'Stop what you are doing. Take a moment.';

  @override
  String get stopStep2Title => 'T - Take a Breath';

  @override
  String get stopStep2Desc => 'Take a slow, deep breath. Feel it.';

  @override
  String get stopStep3Title => 'O - Observe';

  @override
  String get stopStep3Desc => 'Notice your thoughts and feelings.';

  @override
  String get stopStep4Title => 'P - Proceed';

  @override
  String get stopStep4Desc => 'Continue with more calm and focus.';

  @override
  String get breatheWithMe => 'Breathe with me';

  @override
  String get feelingCooler => 'I\'m feeling cooler now!';

  @override
  String get expressYourself => 'Express Yourself';

  @override
  String get mindfulnessPrompts => 'Mindfulness Prompts';

  @override
  String get drawingCanvas => 'Drawing Canvas';

  @override
  String get clearCanvas => 'Clear';

  @override
  String get saveDrawing => 'Save';

  @override
  String get calmingSounds => 'Calming Sounds';

  @override
  String get bedtimeStories => 'Bedtime Stories';

  @override
  String get mindfulness => 'Mindfulness';

  @override
  String get friend => 'Friend';

  @override
  String get emotionHappy => 'Happy';

  @override
  String get emotionSad => 'Sad';

  @override
  String get emotionAngry => 'Angry';

  @override
  String get emotionAnxious => 'Anxious';

  @override
  String get emotionCalm => 'Calm';

  @override
  String get emotionTired => 'Tired';

  @override
  String get reportSaved => 'Report saved! You are doing great.';

  @override
  String errorOccurred(String error) {
    return 'Oops! Error: $error';
  }

  @override
  String get bsStartFeetTitle => 'Start with Feet';

  @override
  String get bsStartFeetDesc =>
      'Wiggle your toes. Feel them touching the floor. Relax them now.';

  @override
  String get bsMovingLegsTitle => 'Moving to Legs';

  @override
  String get bsMovingLegsDesc =>
      'Tense your leg muscles for a second... and let them go loose.';

  @override
  String get bsRelaxTummyTitle => 'Relax Your Tummy';

  @override
  String get bsRelaxTummyDesc =>
      'Place your hand on your belly. Feel it rise and fall as you breathe.';

  @override
  String get bsSoftShouldersTitle => 'Soft Shoulders';

  @override
  String get bsSoftShouldersDesc =>
      'Bring your shoulders up to your ears... then drop them down heavy.';

  @override
  String get bsPeacefulFaceTitle => 'Peaceful Face';

  @override
  String get bsPeacefulFaceDesc =>
      'Smile big... then relax your face completely. You are doing great!';

  @override
  String get bsPeacefulButton => 'I feel peaceful';

  @override
  String get dtGreatJob => 'Great Job!';

  @override
  String get dtSessionFinished => 'You finished your focus session!';

  @override
  String get dtAwesome => 'Awesome!';

  @override
  String dtProgress(String completed, String total) {
    return '$completed of $total completed';
  }

  @override
  String get dtTaskList => 'Tasks list';

  @override
  String get dtNoTasks => 'No tasks for today';

  @override
  String get dtNoTasksDesc => 'Add a task to start your day!';

  @override
  String get galleryPermissionRequired =>
      'Gallery permission is required to save drawings.';

  @override
  String get savedToGallery => 'Saved to Gallery! 🎨';

  @override
  String galleryError(String error) {
    return 'Gallery Error: $error';
  }

  @override
  String saveError(String error) {
    return 'Save Error: $error';
  }

  @override
  String get errorLoadingStories => 'Error loading stories';

  @override
  String get noStoriesAvailable => 'No stories available';

  @override
  String pagesCount(int count) {
    return '$count pages';
  }

  @override
  String pageIndicator(int current, int total) {
    return 'Page $current of $total';
  }

  @override
  String get swipeToTurnPage => 'Swipe to turn page';

  @override
  String get theEnd => 'The End';

  @override
  String get liveHeartbeatMotion => 'Live Heartbeat & Motion';

  @override
  String get motionZ => 'Motion (Z)';

  @override
  String get energy => 'Energy';

  @override
  String get liveTag => 'LIVE';

  @override
  String get statsAndReports => 'Statistics & Reports';

  @override
  String get errorLoadingStats => 'Error loading stats';

  @override
  String get activityTrends => 'Activity Trends';

  @override
  String get activityTrendsDesc => 'Daily total sessions and time';

  @override
  String get stressRegulation => 'Stress Regulation';

  @override
  String get stressRegulationDesc => 'Stress levels before vs after sessions';

  @override
  String get protocolProgressTitle => 'Protocol Progress';

  @override
  String get protocolProgressDesc => '5-Week therapeutic journey status';

  @override
  String get exportReports => 'Export Reports';

  @override
  String get pdfReport => 'PDF Report';

  @override
  String get csvData => 'CSV Data';

  @override
  String get sessions => 'Sessions';

  @override
  String get calmTime => 'Calm Time';

  @override
  String get avgStressReduction => 'Avg Stress ↓';

  @override
  String get timeRangeWeek => 'Week';

  @override
  String get timeRangeMonth => 'Month';

  @override
  String get timeRangeFiveWeeks => '5 Weeks';

  @override
  String get noProtocolData => 'No Protocol Data Yet';

  @override
  String errorExporting(String type, String error) {
    return 'Error exporting $type: $error';
  }

  @override
  String get achFirstBreathing => 'First Breath';

  @override
  String get achFirstBreathingDesc => 'Complete your first breathing exercise.';

  @override
  String get achBreathing5 => 'Breathing Steady';

  @override
  String get achBreathing5Desc => 'Complete 5 breathing exercises.';

  @override
  String get achBreathing10 => 'Breathing Expert';

  @override
  String get achBreathing10Desc => 'Complete 10 breathing exercises.';

  @override
  String get achBreathingMaster => 'Breathing Master';

  @override
  String get achBreathingMasterDesc => 'Complete 30 breathing exercises.';

  @override
  String get achFirstFocus => 'Focused Mind';

  @override
  String get achFirstFocusDesc => 'Complete your first focus exercise.';

  @override
  String get achFocusChampion => 'Focus Champion';

  @override
  String get achFocusChampionDesc => 'Complete 20 focus exercises.';

  @override
  String get achMusicBeginner => 'Musical Soul';

  @override
  String get achMusicBeginnerDesc => 'Listen to 5 calming tracks.';

  @override
  String get achMusicExpert => 'Music Enthusiast';

  @override
  String get achMusicExpertDesc => 'Listen to 25 calming tracks.';

  @override
  String get achStoryStarter => 'Story Listener';

  @override
  String get achStoryStarterDesc => 'Listen to 3 stories.';

  @override
  String get achStoryMaster => 'Fable Fanatic';

  @override
  String weekLabel(int weekNum) {
    return 'Week $weekNum';
  }

  @override
  String get weekPrefix => 'WEEK';

  @override
  String get continueTraining => 'Continue training habits';

  @override
  String get focusQuest => 'Focus Quest';

  @override
  String get mindfulStories => 'Mindful Stories';

  @override
  String get calmingRhythms => 'Calming Rhythms';

  @override
  String get finalDiscoveryDashboard => 'Missing Square Protocol dashboard';

  @override
  String get protocolAnalytics => 'Protocol Analytics';

  @override
  String get avgStressLevel => 'Avg Stress Level';

  @override
  String get avgActivityLevel => 'Avg Activity Level';

  @override
  String get weeklyBreakdown => 'Weekly Breakdown';

  @override
  String get noProtocolDataDesc =>
      'Stats will appear as you complete activities.';

  @override
  String weekDetail(int index) {
    return 'Week $index';
  }

  @override
  String sessionsCount(int count) {
    return '$count sessions';
  }

  @override
  String stressPercentage(int percentage) {
    return '$percentage% Stress';
  }

  @override
  String get achStoryMasterDesc => 'Listen to 15 stories.';

  @override
  String get achStreak3 => '3 Day Streak';

  @override
  String get achStreak3Desc => 'Maintain a 3-day activity streak.';

  @override
  String get achStreak7 => 'Week Warrior';

  @override
  String get achStreak7Desc => 'Maintain a 7-day activity streak.';

  @override
  String get achStreak14 => 'Two Week Triumph';

  @override
  String get achStreak14Desc => 'Maintain a 14-day activity streak.';

  @override
  String get achStreak30 => 'Monthly Master';

  @override
  String get achStreak30Desc => 'Maintain a 30-day activity streak.';

  @override
  String get achEarlyBird => 'Early Bird';

  @override
  String get achEarlyBirdDesc => 'Complete 5 sessions before 9 AM.';

  @override
  String get achCalm10 => '10 Minutes of Calm';

  @override
  String get achCalm10Desc => 'Stay in a calm state for 10 minutes.';

  @override
  String get achCalm30 => '30 Minutes of Calm';

  @override
  String get achCalm30Desc => 'Stay in a calm state for 30 minutes.';

  @override
  String get achCalm60 => 'Hour of Peace';

  @override
  String get achCalm60Desc => 'Stay in a calm state for 1 hour.';

  @override
  String get achReduceHyper20 => 'Hyperactivity Reducer';

  @override
  String get achReduceHyper20Desc =>
      'Reduce hyperactivity by 20% in a session.';

  @override
  String get achReduceHyper50 => 'Calmness King';

  @override
  String get achReduceHyper50Desc =>
      'Reduce hyperactivity by 50% in a session.';

  @override
  String get achPerfectPosture => 'Perfect Balance';

  @override
  String get achPerfectPostureDesc =>
      'Maintain perfect posture for 15 minutes.';

  @override
  String get achFirstDay => 'Day One';

  @override
  String get achFirstDayDesc => 'Complete your first day with the protocol.';

  @override
  String get achFirstWeek => 'Seven Day Success';

  @override
  String get achFirstWeekDesc => 'Complete your first full week.';

  @override
  String get achFirstMonth => 'Protocol Pro';

  @override
  String get achFirstMonthDesc => 'Complete your first full month.';

  @override
  String get achTasks100 => 'Centurion';

  @override
  String get achTasks100Desc => 'Complete 100 protocol tasks.';

  @override
  String get achTasks500 => 'Halfway to a Thousand';

  @override
  String get achTasks500Desc => 'Complete 500 protocol tasks.';

  @override
  String get achTasks1000 => 'Task Titan';

  @override
  String get achTasks1000Desc => 'Complete 1000 protocol tasks.';

  @override
  String get achQuickLearner => 'Quick Learner';

  @override
  String get achQuickLearnerDesc => 'Complete 5 new exercises in one day.';

  @override
  String get achOverachiever => 'Overachiever';

  @override
  String get achOverachieverDesc =>
      'Complete all protocol tasks 7 days in a row.';

  @override
  String get achCalmMaster => 'Zen Master';

  @override
  String get achCalmMasterDesc =>
      'Maintain peak calmness during a difficult task.';

  @override
  String get achExplorer => 'Curious Explorer';

  @override
  String get achExplorerDesc => 'Try every type of exercise at least once.';

  @override
  String get rarityCommon => 'Common';

  @override
  String get rarityRare => 'Rare';

  @override
  String get rarityEpic => 'Epic';

  @override
  String get rarityLegendary => 'Legendary';

  @override
  String get howToUnlock => 'How to Unlock';

  @override
  String get achievementUnlocked => 'Unlocked';

  @override
  String get achievementLocked => 'Locked';

  @override
  String get achProgress => 'Progress';

  @override
  String achPointsCount(int count) {
    return '+$count Points';
  }

  @override
  String get achUnlockedTitle => 'Unlocked!';

  @override
  String get loginToViewAchievements => 'Please log in to view achievements';

  @override
  String get errorLoadingAchievements => 'Error loading achievements';

  @override
  String get totalPointsLabel => 'Total Points';

  @override
  String levelIndicator(int level) {
    return 'Level $level';
  }

  @override
  String achievementsCount(int unlocked, int total) {
    return '$unlocked/$total Achievements';
  }

  @override
  String get categoryAll => 'All';

  @override
  String get categoryExercise => 'Exercise';

  @override
  String get categoryStreaks => 'Streaks';

  @override
  String get categoryCalm => 'Calm';

  @override
  String get categoryMilestones => 'Milestones';

  @override
  String get categorySpecial => 'Special';

  @override
  String get showOnlyUnlocked => 'Show only unlocked';

  @override
  String get noAchievementsFound => 'No achievements found';

  @override
  String get parentOverview => 'Overview';

  @override
  String get protocolRoadmap => 'Protocol Roadmap';

  @override
  String get thisWeek => 'This Week';

  @override
  String get streak => 'Streak';

  @override
  String get recentActivity => 'Recent Activity';

  @override
  String get noRecentActivity => 'No recent activity';

  @override
  String get weekTitleRegulationSafety => 'Regulation &\nSafety';

  @override
  String get weekTitleFocusControl => 'Focus &\nControl';

  @override
  String get weekTitleDailyStructure => 'Daily\nStructure';

  @override
  String get weekTitleCreativeCalm => 'Creative\nCalm';

  @override
  String get weekTitleIntegrationReview => 'Mastery &\nAssessment';

  @override
  String get weekDesc1 => 'Breathing, Body Scan, Daily Tasks';

  @override
  String get weekDesc2 => 'Memory Flip, Stories';

  @override
  String get weekDesc3 => 'Daily Tasks, Self-Regulation';

  @override
  String get weekDesc4 => 'Drawing, Music';

  @override
  String get weekDesc5 => 'Math Puzzle, Memory Sequence';

  @override
  String get selectChildToView => 'Select a child to view their progress';

  @override
  String get childProfile => 'Child Profile';

  @override
  String get noChildSelected => 'No Child Selected';

  @override
  String get createChildToStart => 'Create a child account to get started';

  @override
  String get createChildAccountLabel => 'Create Child Account';

  @override
  String get manageChild => 'Manage Child';

  @override
  String get rewardsAndEncouragement => 'Rewards & Encouragement';

  @override
  String get sendMessage => 'Send Message';

  @override
  String get sendMessageDesc => 'Send a message to your child';

  @override
  String get recentAchievements => 'Recent Achievements';

  @override
  String get noAchievementsYet => 'No achievements yet. Keep going!';

  @override
  String get sendSticker => 'Send Sticker';

  @override
  String get sendStickerDesc => 'Send a motivational badge';

  @override
  String get accountSafety => 'Account Safety';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get resetPasswordDesc => 'Send recovery email to child';

  @override
  String get removeChild => 'Remove Child';

  @override
  String get removeChildDesc => 'Unlink account from parent';

  @override
  String get watchStatus => 'Watch Status';

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String get device => 'Device';

  @override
  String get battery => 'Battery';

  @override
  String lastSyncedAt(String timestamp) {
    return 'Last synced: $timestamp';
  }

  @override
  String ageYearsOld(String age) {
    return '$age years old';
  }

  @override
  String get selfReportedActivity => 'Self-Reported Activity';

  @override
  String get dominantMood => 'Dominant Mood';

  @override
  String get areYouSureDelete => 'Are you sure you want to remove this child?';

  @override
  String get deleteChildWarning =>
      'This action cannot be undone. All data will be permanently deleted.';

  @override
  String get delete => 'Delete';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get enterChildEmail => 'Enter child\'s email';

  @override
  String get emailSentSuccess => 'Reset link sent successfully';

  @override
  String get childRemovedSuccess => 'Child account removed successfully';

  @override
  String get bluetoothOff => 'Bluetooth is Off';

  @override
  String get turnOnBluetooth => 'Turn On Bluetooth';

  @override
  String get bluetoothOffDesc =>
      'Please turn on Bluetooth to connect to your child\'s watch.';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get noActivityYet => 'No Activity Yet';

  @override
  String get noActivityYetDesc =>
      'Your child hasn\'t started any sessions yet. Check back once they begin their journey!';

  @override
  String get noChildSelectedTitle => 'No Child Selected';

  @override
  String get noChildSelectedMessage =>
      'Please select a child from the top dropdown to view their progress.';

  @override
  String get noStatsAvailable => 'No Statistics Available';

  @override
  String get noStatsAvailableDesc =>
      'Complete some activities to see insights here.';
}
