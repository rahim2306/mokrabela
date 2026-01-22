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
  String get minutes => 'minutes';

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
      'Focus games help improve concentration, memory, and cognitive skills. They\'re a fun way to train your brain and boost mental agility!';

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
  String get connectWatch => 'Connect Your Watch';

  @override
  String get watchScanning => 'Searching for your watch...';

  @override
  String get watchFound => 'Watch found!';

  @override
  String get watchConnecting => 'Connecting to your watch...';

  @override
  String get watchError => 'Couldn\'t find your watch. Is it turned on?';

  @override
  String get pairNow => 'Pair Now';

  @override
  String get availableDevices => 'Available Devices';

  @override
  String get noDevicesFound => 'No devices found nearby.';

  @override
  String get retryScan => 'Scan Again';

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
}
