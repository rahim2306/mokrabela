import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'MokraBela'**
  String get appTitle;

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// Greeting message with user name
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}!'**
  String hello(String name);

  /// Label for language selector
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get languageSelector;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// French language option
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// Arabic language option
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// Button to change language
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// Display current language
  ///
  /// In en, this message translates to:
  /// **'Current Language: {language}'**
  String currentLanguage(String language);

  /// Welcome screen title
  ///
  /// In en, this message translates to:
  /// **'Welcome to MokraBela'**
  String get welcomeToMokrabela;

  /// Welcome screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Helping children feel calmer, more focused, and supported—together.'**
  String get welcomeSubtitle;

  /// Get started button
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// Log in button
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// Login screen title
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// Login screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue your journey.'**
  String get loginSubtitle;

  /// Login failure message
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please check your credentials.'**
  String get loginFailed;

  /// Sign up prompt text
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// Login prompt text
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// First onboarding question
  ///
  /// In en, this message translates to:
  /// **'Which sentence describes you the best?'**
  String get onboardingQuestion1;

  /// Parent role option
  ///
  /// In en, this message translates to:
  /// **'I am a parent who wants to monitor my child\'s progress.'**
  String get optionParent;

  /// Teacher role option
  ///
  /// In en, this message translates to:
  /// **'I am a teacher who works with students.'**
  String get optionTeacher;

  /// Next button
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Back button
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Skip button
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// Title for first introduction screen
  ///
  /// In en, this message translates to:
  /// **'Support Comes First'**
  String get intro1Title;

  /// Description for first introduction screen
  ///
  /// In en, this message translates to:
  /// **'Children don\'t regulate alone. With guidance from parents and teachers, calm becomes a habit.'**
  String get intro1Description;

  /// Title for second introduction screen
  ///
  /// In en, this message translates to:
  /// **'Building Inner Calm'**
  String get intro2Title;

  /// Description for second introduction screen
  ///
  /// In en, this message translates to:
  /// **'Step by step, children learn to calm themselves, focus better, and feel in control.'**
  String get intro2Description;

  /// Welcome message for child dashboard
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}!'**
  String welcomeChild(String name);

  /// Watch connection status - connected
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get watchConnected;

  /// Watch connection status - disconnected
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get watchDisconnected;

  /// Daily progress label
  ///
  /// In en, this message translates to:
  /// **'Daily Progress'**
  String get dailyProgress;

  /// Title for daily calm time tracking
  ///
  /// In en, this message translates to:
  /// **'Today\'s Calm Time'**
  String get todaysCalmTime;

  /// Abbreviation for minutes
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// Setting title for daily calm goal
  ///
  /// In en, this message translates to:
  /// **'Daily Calm Goal'**
  String get dailyCalmGoal;

  /// Message when daily goal is reached
  ///
  /// In en, this message translates to:
  /// **'Goal reached!'**
  String get goalReached;

  /// Number of tasks remaining
  ///
  /// In en, this message translates to:
  /// **'{count} Tasks Remaining'**
  String tasksRemaining(int count);

  /// Breathing exercise card title
  ///
  /// In en, this message translates to:
  /// **'Breathing'**
  String get breathingExercise;

  /// Focus games card title
  ///
  /// In en, this message translates to:
  /// **'Focus Games'**
  String get focusGames;

  /// Calm music card title
  ///
  /// In en, this message translates to:
  /// **'Calm Music'**
  String get calmMusic;

  /// Stories card title
  ///
  /// In en, this message translates to:
  /// **'Stories'**
  String get stories;

  /// Missing Square protocol title
  ///
  /// In en, this message translates to:
  /// **'The Missing Square'**
  String get missingSquare;

  /// No description provided for @protocol.
  ///
  /// In en, this message translates to:
  /// **'Protocol'**
  String get protocol;

  /// No description provided for @focusTimer.
  ///
  /// In en, this message translates to:
  /// **'Focus Timer'**
  String get focusTimer;

  /// No description provided for @addTask.
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get addTask;

  /// No description provided for @myTasks.
  ///
  /// In en, this message translates to:
  /// **'My Tasks'**
  String get myTasks;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @taskTitle.
  ///
  /// In en, this message translates to:
  /// **'Task Title'**
  String get taskTitle;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration (min)'**
  String get duration;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Simple hello greeting
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get helloLabel;

  /// Invitation to start protocol
  ///
  /// In en, this message translates to:
  /// **'Let\'s start your protocol'**
  String get letsStartProtocol;

  /// Missing Square protocol title
  ///
  /// In en, this message translates to:
  /// **'Why use the protocol?'**
  String get missingSquareProtocol;

  /// Personalized welcome message for protocol screen
  ///
  /// In en, this message translates to:
  /// **'Hello {userName}, let\'s start your protocol'**
  String protocolWelcome(String userName);

  /// Protocol explanation subtitle
  ///
  /// In en, this message translates to:
  /// **'These 4 squares help you understand feelings, control energy, and find peace.'**
  String get protocolExplanation;

  /// Square 1 title
  ///
  /// In en, this message translates to:
  /// **'Self Awareness'**
  String get square1Title;

  /// Square 1 description
  ///
  /// In en, this message translates to:
  /// **'Understand your feelings'**
  String get square1Desc;

  /// Square 2 title
  ///
  /// In en, this message translates to:
  /// **'Self Regulation'**
  String get square2Title;

  /// Square 2 description
  ///
  /// In en, this message translates to:
  /// **'Control your energy'**
  String get square2Desc;

  /// Square 3 title
  ///
  /// In en, this message translates to:
  /// **'Daily Tasks'**
  String get square3Title;

  /// Square 3 description
  ///
  /// In en, this message translates to:
  /// **'Organize your time'**
  String get square3Desc;

  /// Square 4 title
  ///
  /// In en, this message translates to:
  /// **'Psychological Calming'**
  String get square4Title;

  /// Square 4 description
  ///
  /// In en, this message translates to:
  /// **'Find your peace'**
  String get square4Desc;

  /// Achievements button label
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// Tab label for achievements view
  ///
  /// In en, this message translates to:
  /// **'Trophies'**
  String get trophiesTab;

  /// Tab label for rewards view
  ///
  /// In en, this message translates to:
  /// **'Mailbox'**
  String get mailboxTab;

  /// Tap to start instruction
  ///
  /// In en, this message translates to:
  /// **'Tap to start'**
  String get tapToStart;

  /// Morning greeting
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get goodMorning;

  /// Language setting label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Logout button text
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// Tasks label
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// Daily progress card motivational text
  ///
  /// In en, this message translates to:
  /// **'Manage your\ntime well'**
  String get manageYourTimeWell;

  /// Second onboarding question
  ///
  /// In en, this message translates to:
  /// **'When would you like to check in daily?'**
  String get onboardingQuestion2;

  /// Reminder card text
  ///
  /// In en, this message translates to:
  /// **'A gentle reminder helps you build a habit.'**
  String get reminderHabitText;

  /// AM time indicator
  ///
  /// In en, this message translates to:
  /// **'AM'**
  String get am;

  /// PM time indicator
  ///
  /// In en, this message translates to:
  /// **'PM'**
  String get pm;

  /// Registration form title
  ///
  /// In en, this message translates to:
  /// **'Tell us more about yourself'**
  String get tellUsMoreTitle;

  /// Registration form subtitle
  ///
  /// In en, this message translates to:
  /// **'Choose a few words that fit for you'**
  String get tellUsMoreSubtitle;

  /// Profile image label
  ///
  /// In en, this message translates to:
  /// **'Profile image'**
  String get profileImage;

  /// Full name field label
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// First name field label
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// Family name field label
  ///
  /// In en, this message translates to:
  /// **'Family Name'**
  String get familyName;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Phone number field label
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// Date of birth field label
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// Gender field label
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// Male gender option
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// Female gender option
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// Other gender option
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// Prefer not to say option
  ///
  /// In en, this message translates to:
  /// **'Prefer not to say'**
  String get preferNotToSay;

  /// Submit registration button
  ///
  /// In en, this message translates to:
  /// **'Go To Final Check in'**
  String get goToFinalCheckIn;

  /// Role selection label
  ///
  /// In en, this message translates to:
  /// **'I am a...'**
  String get iAmA;

  /// Sign up button text
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// Required field validation message
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// Invalid email validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalidEmail;

  /// Password too short validation message
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// Invalid phone number validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get invalidPhoneNumber;

  /// Registration success message
  ///
  /// In en, this message translates to:
  /// **'Registration successful!'**
  String get registrationSuccess;

  /// Registration failed message
  ///
  /// In en, this message translates to:
  /// **'Registration failed. Please try again.'**
  String get registrationFailed;

  /// Email already in use error
  ///
  /// In en, this message translates to:
  /// **'This email is already in use'**
  String get emailAlreadyInUse;

  /// Weak password error
  ///
  /// In en, this message translates to:
  /// **'Password is too weak'**
  String get weakPassword;

  /// Network error message
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your connection.'**
  String get networkError;

  /// Gender dropdown placeholder
  ///
  /// In en, this message translates to:
  /// **'Select gender'**
  String get selectGender;

  /// Date picker placeholder
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDate;

  /// Short language code for display
  ///
  /// In en, this message translates to:
  /// **'Eng'**
  String get languageShort;

  /// Title for breathing exercises screen
  ///
  /// In en, this message translates to:
  /// **'Breathing Exercises'**
  String get breathingExercisesTitle;

  /// Title for golden breath exercise
  ///
  /// In en, this message translates to:
  /// **'Golden Breath'**
  String get goldenBreathTitle;

  /// Description for golden breath exercise
  ///
  /// In en, this message translates to:
  /// **'Short exercise (6s) for energy.'**
  String get goldenBreathDesc;

  /// Title for butterfly breath exercise
  ///
  /// In en, this message translates to:
  /// **'Butterfly Breath'**
  String get butterflyBreathTitle;

  /// Description for butterfly breath exercise
  ///
  /// In en, this message translates to:
  /// **'Calm exercise (10s) for deep relaxation.'**
  String get butterflyBreathDesc;

  /// Title for ocean breath exercise
  ///
  /// In en, this message translates to:
  /// **'Ocean Breath'**
  String get oceanBreathTitle;

  /// Description for ocean breath exercise
  ///
  /// In en, this message translates to:
  /// **'Exercise (8s) mimicking ocean waves.'**
  String get oceanBreathDesc;

  /// Title for forest breath exercise
  ///
  /// In en, this message translates to:
  /// **'Forest Breath'**
  String get forestBreathTitle;

  /// Description for forest breath exercise
  ///
  /// In en, this message translates to:
  /// **'Gentle exercise (7s) for balance.'**
  String get forestBreathDesc;

  /// Seconds unit label
  ///
  /// In en, this message translates to:
  /// **'seconds'**
  String get seconds;

  /// Message when starting an exercise
  ///
  /// In en, this message translates to:
  /// **'Start {exercise}...'**
  String startExercise(String exercise);

  /// Title for breathing info card
  ///
  /// In en, this message translates to:
  /// **'Why breathe consciously?'**
  String get whyBreatheTitle;

  /// Description for breathing info card
  ///
  /// In en, this message translates to:
  /// **'Breathing exercises help calm the mind, reduce stress, and improve focus. It\'s a magical way to recharge or relax.'**
  String get whyBreatheDesc;

  /// Title for music info card
  ///
  /// In en, this message translates to:
  /// **'Why listen to calm music?'**
  String get whyMusicTitle;

  /// Description for music info card
  ///
  /// In en, this message translates to:
  /// **'Calm music helps create a peaceful environment, reduces anxiety, and enhances relaxation. It\'s perfect for meditation, study, or bedtime.'**
  String get whyMusicDesc;

  /// Title for stories info card
  ///
  /// In en, this message translates to:
  /// **'Why read stories?'**
  String get whyStoriesTitle;

  /// Description for stories info card
  ///
  /// In en, this message translates to:
  /// **'Stories spark imagination, teach valuable lessons, and help children relax. They\'re a wonderful way to wind down and dream big!'**
  String get whyStoriesDesc;

  /// Title for focus games info card
  ///
  /// In en, this message translates to:
  /// **'Why play focus games?'**
  String get whyFocusGamesTitle;

  /// Description for focus games info card
  ///
  /// In en, this message translates to:
  /// **'Focus games help improve concentration, memory, and cognitive skills. It\'s a fun way to train your brain and boost mental agility!'**
  String get whyFocusGamesDesc;

  /// Inhale phase indicator
  ///
  /// In en, this message translates to:
  /// **'Breathe In'**
  String get breatheIn;

  /// Exhale phase indicator
  ///
  /// In en, this message translates to:
  /// **'Breathe Out'**
  String get breatheOut;

  /// Cycle label for breathing session
  ///
  /// In en, this message translates to:
  /// **'Cycle'**
  String get cycle;

  /// Session completion message
  ///
  /// In en, this message translates to:
  /// **'Complete!'**
  String get complete;

  /// Breathing exercise completion message
  ///
  /// In en, this message translates to:
  /// **'🎉 {exercise} Complete! ✨'**
  String breathingComplete(String exercise);

  /// Title for focus games section
  ///
  /// In en, this message translates to:
  /// **'Focus Games'**
  String get focusGamesTitle;

  /// Title for memory flip game
  ///
  /// In en, this message translates to:
  /// **'Memory Flip'**
  String get memoryFlipTitle;

  /// Description for memory flip game
  ///
  /// In en, this message translates to:
  /// **'Match pairs of cards to improve memory and focus'**
  String get memoryFlipDesc;

  /// Moves counter label
  ///
  /// In en, this message translates to:
  /// **'Moves'**
  String get moves;

  /// Time label
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// Game completion title
  ///
  /// In en, this message translates to:
  /// **'Game Complete!'**
  String get gameComplete;

  /// Play again button
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get playAgain;

  /// Congratulations message
  ///
  /// In en, this message translates to:
  /// **'Well Done!'**
  String get wellDone;

  /// Title for calm music screen
  ///
  /// In en, this message translates to:
  /// **'Calm Music'**
  String get calmMusicTitle;

  /// Rain sounds track title
  ///
  /// In en, this message translates to:
  /// **'Rain Sounds'**
  String get rainSounds;

  /// Rain sounds track description
  ///
  /// In en, this message translates to:
  /// **'Gentle rain to calm your mind'**
  String get rainSoundsDesc;

  /// Nature ambience track title
  ///
  /// In en, this message translates to:
  /// **'Nature Ambience'**
  String get natureAmbience;

  /// Nature ambience track description
  ///
  /// In en, this message translates to:
  /// **'Peaceful sounds of nature'**
  String get natureAmbienceDesc;

  /// Ocean waves track title
  ///
  /// In en, this message translates to:
  /// **'Ocean Waves'**
  String get oceanWaves;

  /// Ocean waves track description
  ///
  /// In en, this message translates to:
  /// **'Soothing ocean waves'**
  String get oceanWavesDesc;

  /// Calm music track title
  ///
  /// In en, this message translates to:
  /// **'Calm Music'**
  String get calmMusicTrack;

  /// Calm music track description
  ///
  /// In en, this message translates to:
  /// **'Relaxing melodies for peace'**
  String get calmMusicTrackDesc;

  /// Title for stories section
  ///
  /// In en, this message translates to:
  /// **'Stories'**
  String get storiesTitle;

  /// Brave star story title
  ///
  /// In en, this message translates to:
  /// **'The Brave Little Star'**
  String get braveStarTitle;

  /// Brave star story description
  ///
  /// In en, this message translates to:
  /// **'A tale of courage and believing in yourself'**
  String get braveStarDesc;

  /// Magic garden story title
  ///
  /// In en, this message translates to:
  /// **'The Magic Garden'**
  String get magicGardenTitle;

  /// Magic garden story description
  ///
  /// In en, this message translates to:
  /// **'Discover the magic of kindness'**
  String get magicGardenDesc;

  /// Friendly dragon story title
  ///
  /// In en, this message translates to:
  /// **'The Friendly Dragon'**
  String get friendlyDragonTitle;

  /// Friendly dragon story description
  ///
  /// In en, this message translates to:
  /// **'A heartwarming story about friendship'**
  String get friendlyDragonDesc;

  /// No description provided for @braveStarPage1.
  ///
  /// In en, this message translates to:
  /// **'Once upon a time, in the vast night sky, there lived a little star named Stella. She was the smallest star in her constellation, but she had the biggest dreams.'**
  String get braveStarPage1;

  /// No description provided for @braveStarPage2.
  ///
  /// In en, this message translates to:
  /// **'Every night, Stella watched the other stars shine brightly. \"I wish I could shine as bright as them,\" she would whisper to the moon.'**
  String get braveStarPage2;

  /// No description provided for @braveStarPage3.
  ///
  /// In en, this message translates to:
  /// **'One night, a dark cloud covered the sky. All the big stars hid behind it, afraid to shine. But Stella thought, \"Someone needs to light the way for the children below.\"'**
  String get braveStarPage3;

  /// No description provided for @braveStarPage4.
  ///
  /// In en, this message translates to:
  /// **'With all her courage, Stella pushed through the cloud. It was hard and scary, but she kept going. Her light began to glow brighter and brighter!'**
  String get braveStarPage4;

  /// No description provided for @braveStarPage5.
  ///
  /// In en, this message translates to:
  /// **'The children on Earth looked up and saw Stella\'s brave light. \"Look! A shooting star!\" they cheered. Stella realized she didn\'t need to be the biggest to make a difference.'**
  String get braveStarPage5;

  /// No description provided for @braveStarPage6.
  ///
  /// In en, this message translates to:
  /// **'From that night on, Stella shone with confidence. She learned that being brave doesn\'t mean you\'re not scared—it means you shine anyway. The End. ⭐'**
  String get braveStarPage6;

  /// No description provided for @magicGardenPage1.
  ///
  /// In en, this message translates to:
  /// **'In a quiet corner of the world, there was a magical garden that only appeared to those who truly believed in magic.'**
  String get magicGardenPage1;

  /// No description provided for @magicGardenPage2.
  ///
  /// In en, this message translates to:
  /// **'A curious girl named Maya loved exploring. One sunny day, she followed a golden butterfly and discovered a hidden gate covered in vines.'**
  String get magicGardenPage2;

  /// No description provided for @magicGardenPage3.
  ///
  /// In en, this message translates to:
  /// **'As Maya touched the gate, it opened with a gentle glow. Inside was the most beautiful garden she had ever seen—flowers that sang, trees that danced, and streams that sparkled like diamonds.'**
  String get magicGardenPage3;

  /// No description provided for @magicGardenPage4.
  ///
  /// In en, this message translates to:
  /// **'In the center of the garden stood a wise old tree. \"Welcome, Maya,\" it said with a warm voice. \"This garden grows from kindness and care. Will you help it bloom?\"'**
  String get magicGardenPage4;

  /// No description provided for @magicGardenPage5.
  ///
  /// In en, this message translates to:
  /// **'Maya watered the flowers, sang to the trees, and helped the little creatures. With each kind act, the garden grew more vibrant and magical.'**
  String get magicGardenPage5;

  /// No description provided for @magicGardenPage6.
  ///
  /// In en, this message translates to:
  /// **'When it was time to leave, the tree gave Maya a special seed. \"Plant this in your heart,\" it said. \"Kindness is the real magic.\" Maya smiled, knowing she could create magic anywhere. The End. 🌸'**
  String get magicGardenPage6;

  /// No description provided for @friendlyDragonPage1.
  ///
  /// In en, this message translates to:
  /// **'High in the misty mountains lived a dragon named Ember. Unlike other dragons, Ember didn\'t want to guard treasure or breathe fire at knights.'**
  String get friendlyDragonPage1;

  /// No description provided for @friendlyDragonPage2.
  ///
  /// In en, this message translates to:
  /// **'Ember just wanted a friend. But whenever he flew down to the village, people would run away screaming. \"I\'m not scary!\" Ember would call out, but no one stayed to listen.'**
  String get friendlyDragonPage2;

  /// No description provided for @friendlyDragonPage3.
  ///
  /// In en, this message translates to:
  /// **'One day, a brave little boy named Leo got lost in the mountains. As night fell and the cold wind blew, Leo began to cry. That\'s when he saw a warm, orange glow.'**
  String get friendlyDragonPage3;

  /// No description provided for @friendlyDragonPage4.
  ///
  /// In en, this message translates to:
  /// **'It was Ember! The dragon gently breathed warm air to keep Leo cozy. \"Don\'t be afraid,\" Ember said softly. \"I\'ll help you get home.\"'**
  String get friendlyDragonPage4;

  /// No description provided for @friendlyDragonPage5.
  ///
  /// In en, this message translates to:
  /// **'Ember flew Leo safely back to the village. When the people saw how kind and gentle the dragon was, they realized they had been wrong to judge him by his appearance.'**
  String get friendlyDragonPage5;

  /// No description provided for @friendlyDragonPage6.
  ///
  /// In en, this message translates to:
  /// **'From that day on, Ember had many friends in the village. He learned that true friendship comes to those who are kind and patient. And Leo learned that the biggest hearts sometimes come in the most unexpected forms. The End. 🐉'**
  String get friendlyDragonPage6;

  /// Title for add task dialog
  ///
  /// In en, this message translates to:
  /// **'New Task'**
  String get dtNewTask;

  /// Placeholder for task title input
  ///
  /// In en, this message translates to:
  /// **'What do you want to focus on?'**
  String get dtTaskTitlePlaceholder;

  /// Label for task duration input
  ///
  /// In en, this message translates to:
  /// **'Duration (minutes)'**
  String get dtTaskDurationLabel;

  /// Button to confirm adding task
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get dtAddButton;

  /// No description provided for @dtCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get dtCancelButton;

  /// No description provided for @howAreYouFeeling.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling?'**
  String get howAreYouFeeling;

  /// No description provided for @activityLevel.
  ///
  /// In en, this message translates to:
  /// **'Activity Level (1-10)'**
  String get activityLevel;

  /// No description provided for @quiet.
  ///
  /// In en, this message translates to:
  /// **'Quiet'**
  String get quiet;

  /// No description provided for @hyper.
  ///
  /// In en, this message translates to:
  /// **'Hyper'**
  String get hyper;

  /// No description provided for @guidedBodyScan.
  ///
  /// In en, this message translates to:
  /// **'Guided Body Scan'**
  String get guidedBodyScan;

  /// No description provided for @bodyScanDesc.
  ///
  /// In en, this message translates to:
  /// **'Check in with every part of your body.'**
  String get bodyScanDesc;

  /// No description provided for @saveSession.
  ///
  /// In en, this message translates to:
  /// **'Save My Session'**
  String get saveSession;

  /// No description provided for @connectWatch.
  ///
  /// In en, this message translates to:
  /// **'Connect Your Watch'**
  String get connectWatch;

  /// No description provided for @watchScanning.
  ///
  /// In en, this message translates to:
  /// **'Searching for your watch...'**
  String get watchScanning;

  /// No description provided for @watchFound.
  ///
  /// In en, this message translates to:
  /// **'Watch found!'**
  String get watchFound;

  /// No description provided for @watchConnecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting to your watch...'**
  String get watchConnecting;

  /// No description provided for @watchError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t find your watch. Is it turned on?'**
  String get watchError;

  /// No description provided for @pairNow.
  ///
  /// In en, this message translates to:
  /// **'Pair Now'**
  String get pairNow;

  /// No description provided for @availableDevices.
  ///
  /// In en, this message translates to:
  /// **'Available Devices'**
  String get availableDevices;

  /// No description provided for @noDevicesFound.
  ///
  /// In en, this message translates to:
  /// **'No devices found nearby.'**
  String get noDevicesFound;

  /// No description provided for @retryScan.
  ///
  /// In en, this message translates to:
  /// **'Scan Again'**
  String get retryScan;

  /// No description provided for @stopTechnique.
  ///
  /// In en, this message translates to:
  /// **'STOP Technique'**
  String get stopTechnique;

  /// No description provided for @stopStep1Title.
  ///
  /// In en, this message translates to:
  /// **'S - Stop'**
  String get stopStep1Title;

  /// No description provided for @stopStep1Desc.
  ///
  /// In en, this message translates to:
  /// **'Stop what you are doing. Take a moment.'**
  String get stopStep1Desc;

  /// No description provided for @stopStep2Title.
  ///
  /// In en, this message translates to:
  /// **'T - Take a Breath'**
  String get stopStep2Title;

  /// No description provided for @stopStep2Desc.
  ///
  /// In en, this message translates to:
  /// **'Take a slow, deep breath. Feel it.'**
  String get stopStep2Desc;

  /// No description provided for @stopStep3Title.
  ///
  /// In en, this message translates to:
  /// **'O - Observe'**
  String get stopStep3Title;

  /// No description provided for @stopStep3Desc.
  ///
  /// In en, this message translates to:
  /// **'Notice your thoughts and feelings.'**
  String get stopStep3Desc;

  /// No description provided for @stopStep4Title.
  ///
  /// In en, this message translates to:
  /// **'P - Proceed'**
  String get stopStep4Title;

  /// No description provided for @stopStep4Desc.
  ///
  /// In en, this message translates to:
  /// **'Continue with more calm and focus.'**
  String get stopStep4Desc;

  /// No description provided for @breatheWithMe.
  ///
  /// In en, this message translates to:
  /// **'Breathe with me'**
  String get breatheWithMe;

  /// No description provided for @feelingCooler.
  ///
  /// In en, this message translates to:
  /// **'I\'m feeling cooler now!'**
  String get feelingCooler;

  /// No description provided for @expressYourself.
  ///
  /// In en, this message translates to:
  /// **'Express Yourself'**
  String get expressYourself;

  /// No description provided for @mindfulnessPrompts.
  ///
  /// In en, this message translates to:
  /// **'Mindfulness Prompts'**
  String get mindfulnessPrompts;

  /// No description provided for @drawingCanvas.
  ///
  /// In en, this message translates to:
  /// **'Drawing Canvas'**
  String get drawingCanvas;

  /// No description provided for @clearCanvas.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearCanvas;

  /// No description provided for @saveDrawing.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveDrawing;

  /// No description provided for @calmingSounds.
  ///
  /// In en, this message translates to:
  /// **'Calming Sounds'**
  String get calmingSounds;

  /// No description provided for @bedtimeStories.
  ///
  /// In en, this message translates to:
  /// **'Bedtime Stories'**
  String get bedtimeStories;

  /// No description provided for @mindfulness.
  ///
  /// In en, this message translates to:
  /// **'Mindfulness'**
  String get mindfulness;

  /// No description provided for @friend.
  ///
  /// In en, this message translates to:
  /// **'Friend'**
  String get friend;

  /// No description provided for @emotionHappy.
  ///
  /// In en, this message translates to:
  /// **'Happy'**
  String get emotionHappy;

  /// No description provided for @emotionSad.
  ///
  /// In en, this message translates to:
  /// **'Sad'**
  String get emotionSad;

  /// No description provided for @emotionAngry.
  ///
  /// In en, this message translates to:
  /// **'Angry'**
  String get emotionAngry;

  /// No description provided for @emotionAnxious.
  ///
  /// In en, this message translates to:
  /// **'Anxious'**
  String get emotionAnxious;

  /// No description provided for @emotionCalm.
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get emotionCalm;

  /// No description provided for @emotionTired.
  ///
  /// In en, this message translates to:
  /// **'Tired'**
  String get emotionTired;

  /// No description provided for @reportSaved.
  ///
  /// In en, this message translates to:
  /// **'Report saved! You are doing great.'**
  String get reportSaved;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'Oops! Error: {error}'**
  String errorOccurred(String error);

  /// No description provided for @bsStartFeetTitle.
  ///
  /// In en, this message translates to:
  /// **'Start with Feet'**
  String get bsStartFeetTitle;

  /// No description provided for @bsStartFeetDesc.
  ///
  /// In en, this message translates to:
  /// **'Wiggle your toes. Feel them touching the floor. Relax them now.'**
  String get bsStartFeetDesc;

  /// No description provided for @bsMovingLegsTitle.
  ///
  /// In en, this message translates to:
  /// **'Moving to Legs'**
  String get bsMovingLegsTitle;

  /// No description provided for @bsMovingLegsDesc.
  ///
  /// In en, this message translates to:
  /// **'Tense your leg muscles for a second... and let them go loose.'**
  String get bsMovingLegsDesc;

  /// No description provided for @bsRelaxTummyTitle.
  ///
  /// In en, this message translates to:
  /// **'Relax Your Tummy'**
  String get bsRelaxTummyTitle;

  /// No description provided for @bsRelaxTummyDesc.
  ///
  /// In en, this message translates to:
  /// **'Place your hand on your belly. Feel it rise and fall as you breathe.'**
  String get bsRelaxTummyDesc;

  /// No description provided for @bsSoftShouldersTitle.
  ///
  /// In en, this message translates to:
  /// **'Soft Shoulders'**
  String get bsSoftShouldersTitle;

  /// No description provided for @bsSoftShouldersDesc.
  ///
  /// In en, this message translates to:
  /// **'Bring your shoulders up to your ears... then drop them down heavy.'**
  String get bsSoftShouldersDesc;

  /// No description provided for @bsPeacefulFaceTitle.
  ///
  /// In en, this message translates to:
  /// **'Peaceful Face'**
  String get bsPeacefulFaceTitle;

  /// No description provided for @bsPeacefulFaceDesc.
  ///
  /// In en, this message translates to:
  /// **'Smile big... then relax your face completely. You are doing great!'**
  String get bsPeacefulFaceDesc;

  /// No description provided for @bsPeacefulButton.
  ///
  /// In en, this message translates to:
  /// **'I feel peaceful'**
  String get bsPeacefulButton;

  /// No description provided for @dtGreatJob.
  ///
  /// In en, this message translates to:
  /// **'Great Job!'**
  String get dtGreatJob;

  /// No description provided for @dtSessionFinished.
  ///
  /// In en, this message translates to:
  /// **'You finished your focus session!'**
  String get dtSessionFinished;

  /// No description provided for @dtAwesome.
  ///
  /// In en, this message translates to:
  /// **'Awesome!'**
  String get dtAwesome;

  /// No description provided for @dtProgress.
  ///
  /// In en, this message translates to:
  /// **'{completed} of {total} completed'**
  String dtProgress(String completed, String total);

  /// No description provided for @dtTaskList.
  ///
  /// In en, this message translates to:
  /// **'Tasks list'**
  String get dtTaskList;

  /// No description provided for @dtNoTasks.
  ///
  /// In en, this message translates to:
  /// **'No tasks for today'**
  String get dtNoTasks;

  /// No description provided for @dtNoTasksDesc.
  ///
  /// In en, this message translates to:
  /// **'Add a task to start your day!'**
  String get dtNoTasksDesc;

  /// No description provided for @galleryPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Gallery permission is required to save drawings.'**
  String get galleryPermissionRequired;

  /// No description provided for @savedToGallery.
  ///
  /// In en, this message translates to:
  /// **'Saved to Gallery! 🎨'**
  String get savedToGallery;

  /// No description provided for @galleryError.
  ///
  /// In en, this message translates to:
  /// **'Gallery Error: {error}'**
  String galleryError(String error);

  /// No description provided for @saveError.
  ///
  /// In en, this message translates to:
  /// **'Save Error: {error}'**
  String saveError(String error);

  /// No description provided for @errorLoadingStories.
  ///
  /// In en, this message translates to:
  /// **'Error loading stories'**
  String get errorLoadingStories;

  /// No description provided for @noStoriesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No stories available'**
  String get noStoriesAvailable;

  /// No description provided for @pagesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} pages'**
  String pagesCount(int count);

  /// No description provided for @pageIndicator.
  ///
  /// In en, this message translates to:
  /// **'Page {current} of {total}'**
  String pageIndicator(int current, int total);

  /// No description provided for @swipeToTurnPage.
  ///
  /// In en, this message translates to:
  /// **'Swipe to turn page'**
  String get swipeToTurnPage;

  /// No description provided for @theEnd.
  ///
  /// In en, this message translates to:
  /// **'The End'**
  String get theEnd;

  /// No description provided for @liveHeartbeatMotion.
  ///
  /// In en, this message translates to:
  /// **'Live Heartbeat & Motion'**
  String get liveHeartbeatMotion;

  /// No description provided for @motionZ.
  ///
  /// In en, this message translates to:
  /// **'Motion (Z)'**
  String get motionZ;

  /// No description provided for @energy.
  ///
  /// In en, this message translates to:
  /// **'Energy'**
  String get energy;

  /// No description provided for @liveTag.
  ///
  /// In en, this message translates to:
  /// **'LIVE'**
  String get liveTag;

  /// No description provided for @statsAndReports.
  ///
  /// In en, this message translates to:
  /// **'Statistics & Reports'**
  String get statsAndReports;

  /// No description provided for @errorLoadingStats.
  ///
  /// In en, this message translates to:
  /// **'Error loading stats'**
  String get errorLoadingStats;

  /// No description provided for @activityTrends.
  ///
  /// In en, this message translates to:
  /// **'Activity Trends'**
  String get activityTrends;

  /// No description provided for @activityTrendsDesc.
  ///
  /// In en, this message translates to:
  /// **'Daily total sessions and time'**
  String get activityTrendsDesc;

  /// No description provided for @stressRegulation.
  ///
  /// In en, this message translates to:
  /// **'Stress Regulation'**
  String get stressRegulation;

  /// No description provided for @stressRegulationDesc.
  ///
  /// In en, this message translates to:
  /// **'Stress levels before vs after sessions'**
  String get stressRegulationDesc;

  /// No description provided for @protocolProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Protocol Progress'**
  String get protocolProgressTitle;

  /// No description provided for @protocolProgressDesc.
  ///
  /// In en, this message translates to:
  /// **'5-Week therapeutic journey status'**
  String get protocolProgressDesc;

  /// No description provided for @exportReports.
  ///
  /// In en, this message translates to:
  /// **'Export Reports'**
  String get exportReports;

  /// No description provided for @pdfReport.
  ///
  /// In en, this message translates to:
  /// **'PDF Report'**
  String get pdfReport;

  /// No description provided for @csvData.
  ///
  /// In en, this message translates to:
  /// **'CSV Data'**
  String get csvData;

  /// Sessions stat label
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get sessions;

  /// Calm time stat label
  ///
  /// In en, this message translates to:
  /// **'Calm Time'**
  String get calmTime;

  /// No description provided for @avgStressReduction.
  ///
  /// In en, this message translates to:
  /// **'Avg Stress ↓'**
  String get avgStressReduction;

  /// No description provided for @timeRangeWeek.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get timeRangeWeek;

  /// No description provided for @timeRangeMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get timeRangeMonth;

  /// No description provided for @timeRangeFiveWeeks.
  ///
  /// In en, this message translates to:
  /// **'5 Weeks'**
  String get timeRangeFiveWeeks;

  /// No description provided for @noProtocolData.
  ///
  /// In en, this message translates to:
  /// **'No Protocol Data Yet'**
  String get noProtocolData;

  /// No description provided for @errorExporting.
  ///
  /// In en, this message translates to:
  /// **'Error exporting {type}: {error}'**
  String errorExporting(String type, String error);

  /// No description provided for @achFirstBreathing.
  ///
  /// In en, this message translates to:
  /// **'First Breath'**
  String get achFirstBreathing;

  /// No description provided for @achFirstBreathingDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete your first breathing exercise.'**
  String get achFirstBreathingDesc;

  /// No description provided for @achBreathing5.
  ///
  /// In en, this message translates to:
  /// **'Breathing Steady'**
  String get achBreathing5;

  /// No description provided for @achBreathing5Desc.
  ///
  /// In en, this message translates to:
  /// **'Complete 5 breathing exercises.'**
  String get achBreathing5Desc;

  /// No description provided for @achBreathing10.
  ///
  /// In en, this message translates to:
  /// **'Breathing Expert'**
  String get achBreathing10;

  /// No description provided for @achBreathing10Desc.
  ///
  /// In en, this message translates to:
  /// **'Complete 10 breathing exercises.'**
  String get achBreathing10Desc;

  /// No description provided for @achBreathingMaster.
  ///
  /// In en, this message translates to:
  /// **'Breathing Master'**
  String get achBreathingMaster;

  /// No description provided for @achBreathingMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete 30 breathing exercises.'**
  String get achBreathingMasterDesc;

  /// No description provided for @achFirstFocus.
  ///
  /// In en, this message translates to:
  /// **'Focused Mind'**
  String get achFirstFocus;

  /// No description provided for @achFirstFocusDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete your first focus exercise.'**
  String get achFirstFocusDesc;

  /// No description provided for @achFocusChampion.
  ///
  /// In en, this message translates to:
  /// **'Focus Champion'**
  String get achFocusChampion;

  /// No description provided for @achFocusChampionDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete 20 focus exercises.'**
  String get achFocusChampionDesc;

  /// No description provided for @achMusicBeginner.
  ///
  /// In en, this message translates to:
  /// **'Musical Soul'**
  String get achMusicBeginner;

  /// No description provided for @achMusicBeginnerDesc.
  ///
  /// In en, this message translates to:
  /// **'Listen to 5 calming tracks.'**
  String get achMusicBeginnerDesc;

  /// No description provided for @achMusicExpert.
  ///
  /// In en, this message translates to:
  /// **'Music Enthusiast'**
  String get achMusicExpert;

  /// No description provided for @achMusicExpertDesc.
  ///
  /// In en, this message translates to:
  /// **'Listen to 25 calming tracks.'**
  String get achMusicExpertDesc;

  /// No description provided for @achStoryStarter.
  ///
  /// In en, this message translates to:
  /// **'Story Listener'**
  String get achStoryStarter;

  /// No description provided for @achStoryStarterDesc.
  ///
  /// In en, this message translates to:
  /// **'Listen to 3 stories.'**
  String get achStoryStarterDesc;

  /// No description provided for @achStoryMaster.
  ///
  /// In en, this message translates to:
  /// **'Fable Fanatic'**
  String get achStoryMaster;

  /// Week label with number
  ///
  /// In en, this message translates to:
  /// **'Week {weekNum}'**
  String weekLabel(int weekNum);

  /// No description provided for @weekPrefix.
  ///
  /// In en, this message translates to:
  /// **'WEEK'**
  String get weekPrefix;

  /// No description provided for @continueTraining.
  ///
  /// In en, this message translates to:
  /// **'Continue training habits'**
  String get continueTraining;

  /// No description provided for @focusQuest.
  ///
  /// In en, this message translates to:
  /// **'Focus Quest'**
  String get focusQuest;

  /// No description provided for @mindfulStories.
  ///
  /// In en, this message translates to:
  /// **'Mindful Stories'**
  String get mindfulStories;

  /// No description provided for @calmingRhythms.
  ///
  /// In en, this message translates to:
  /// **'Calming Rhythms'**
  String get calmingRhythms;

  /// No description provided for @finalDiscoveryDashboard.
  ///
  /// In en, this message translates to:
  /// **'Missing Square Protocol dashboard'**
  String get finalDiscoveryDashboard;

  /// No description provided for @protocolAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Protocol Analytics'**
  String get protocolAnalytics;

  /// No description provided for @avgStressLevel.
  ///
  /// In en, this message translates to:
  /// **'Avg Stress Level'**
  String get avgStressLevel;

  /// No description provided for @avgActivityLevel.
  ///
  /// In en, this message translates to:
  /// **'Avg Activity Level'**
  String get avgActivityLevel;

  /// No description provided for @weeklyBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Weekly Breakdown'**
  String get weeklyBreakdown;

  /// No description provided for @noProtocolDataDesc.
  ///
  /// In en, this message translates to:
  /// **'Stats will appear as you complete activities.'**
  String get noProtocolDataDesc;

  /// No description provided for @weekDetail.
  ///
  /// In en, this message translates to:
  /// **'Week {index}'**
  String weekDetail(int index);

  /// No description provided for @sessionsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} sessions'**
  String sessionsCount(int count);

  /// No description provided for @stressPercentage.
  ///
  /// In en, this message translates to:
  /// **'{percentage}% Stress'**
  String stressPercentage(int percentage);

  /// No description provided for @achStoryMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'Listen to 15 stories.'**
  String get achStoryMasterDesc;

  /// No description provided for @achStreak3.
  ///
  /// In en, this message translates to:
  /// **'3 Day Streak'**
  String get achStreak3;

  /// No description provided for @achStreak3Desc.
  ///
  /// In en, this message translates to:
  /// **'Maintain a 3-day activity streak.'**
  String get achStreak3Desc;

  /// No description provided for @achStreak7.
  ///
  /// In en, this message translates to:
  /// **'Week Warrior'**
  String get achStreak7;

  /// No description provided for @achStreak7Desc.
  ///
  /// In en, this message translates to:
  /// **'Maintain a 7-day activity streak.'**
  String get achStreak7Desc;

  /// No description provided for @achStreak14.
  ///
  /// In en, this message translates to:
  /// **'Two Week Triumph'**
  String get achStreak14;

  /// No description provided for @achStreak14Desc.
  ///
  /// In en, this message translates to:
  /// **'Maintain a 14-day activity streak.'**
  String get achStreak14Desc;

  /// No description provided for @achStreak30.
  ///
  /// In en, this message translates to:
  /// **'Monthly Master'**
  String get achStreak30;

  /// No description provided for @achStreak30Desc.
  ///
  /// In en, this message translates to:
  /// **'Maintain a 30-day activity streak.'**
  String get achStreak30Desc;

  /// No description provided for @achEarlyBird.
  ///
  /// In en, this message translates to:
  /// **'Early Bird'**
  String get achEarlyBird;

  /// No description provided for @achEarlyBirdDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete 5 sessions before 9 AM.'**
  String get achEarlyBirdDesc;

  /// No description provided for @achCalm10.
  ///
  /// In en, this message translates to:
  /// **'10 Minutes of Calm'**
  String get achCalm10;

  /// No description provided for @achCalm10Desc.
  ///
  /// In en, this message translates to:
  /// **'Stay in a calm state for 10 minutes.'**
  String get achCalm10Desc;

  /// No description provided for @achCalm30.
  ///
  /// In en, this message translates to:
  /// **'30 Minutes of Calm'**
  String get achCalm30;

  /// No description provided for @achCalm30Desc.
  ///
  /// In en, this message translates to:
  /// **'Stay in a calm state for 30 minutes.'**
  String get achCalm30Desc;

  /// No description provided for @achCalm60.
  ///
  /// In en, this message translates to:
  /// **'Hour of Peace'**
  String get achCalm60;

  /// No description provided for @achCalm60Desc.
  ///
  /// In en, this message translates to:
  /// **'Stay in a calm state for 1 hour.'**
  String get achCalm60Desc;

  /// No description provided for @achReduceHyper20.
  ///
  /// In en, this message translates to:
  /// **'Hyperactivity Reducer'**
  String get achReduceHyper20;

  /// No description provided for @achReduceHyper20Desc.
  ///
  /// In en, this message translates to:
  /// **'Reduce hyperactivity by 20% in a session.'**
  String get achReduceHyper20Desc;

  /// No description provided for @achReduceHyper50.
  ///
  /// In en, this message translates to:
  /// **'Calmness King'**
  String get achReduceHyper50;

  /// No description provided for @achReduceHyper50Desc.
  ///
  /// In en, this message translates to:
  /// **'Reduce hyperactivity by 50% in a session.'**
  String get achReduceHyper50Desc;

  /// No description provided for @achPerfectPosture.
  ///
  /// In en, this message translates to:
  /// **'Perfect Balance'**
  String get achPerfectPosture;

  /// No description provided for @achPerfectPostureDesc.
  ///
  /// In en, this message translates to:
  /// **'Maintain perfect posture for 15 minutes.'**
  String get achPerfectPostureDesc;

  /// No description provided for @achFirstDay.
  ///
  /// In en, this message translates to:
  /// **'Day One'**
  String get achFirstDay;

  /// No description provided for @achFirstDayDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete your first day with the protocol.'**
  String get achFirstDayDesc;

  /// No description provided for @achFirstWeek.
  ///
  /// In en, this message translates to:
  /// **'Seven Day Success'**
  String get achFirstWeek;

  /// No description provided for @achFirstWeekDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete your first full week.'**
  String get achFirstWeekDesc;

  /// No description provided for @achFirstMonth.
  ///
  /// In en, this message translates to:
  /// **'Protocol Pro'**
  String get achFirstMonth;

  /// No description provided for @achFirstMonthDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete your first full month.'**
  String get achFirstMonthDesc;

  /// No description provided for @achTasks100.
  ///
  /// In en, this message translates to:
  /// **'Centurion'**
  String get achTasks100;

  /// No description provided for @achTasks100Desc.
  ///
  /// In en, this message translates to:
  /// **'Complete 100 protocol tasks.'**
  String get achTasks100Desc;

  /// No description provided for @achTasks500.
  ///
  /// In en, this message translates to:
  /// **'Halfway to a Thousand'**
  String get achTasks500;

  /// No description provided for @achTasks500Desc.
  ///
  /// In en, this message translates to:
  /// **'Complete 500 protocol tasks.'**
  String get achTasks500Desc;

  /// No description provided for @achTasks1000.
  ///
  /// In en, this message translates to:
  /// **'Task Titan'**
  String get achTasks1000;

  /// No description provided for @achTasks1000Desc.
  ///
  /// In en, this message translates to:
  /// **'Complete 1000 protocol tasks.'**
  String get achTasks1000Desc;

  /// No description provided for @achQuickLearner.
  ///
  /// In en, this message translates to:
  /// **'Quick Learner'**
  String get achQuickLearner;

  /// No description provided for @achQuickLearnerDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete 5 new exercises in one day.'**
  String get achQuickLearnerDesc;

  /// No description provided for @achOverachiever.
  ///
  /// In en, this message translates to:
  /// **'Overachiever'**
  String get achOverachiever;

  /// No description provided for @achOverachieverDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete all protocol tasks 7 days in a row.'**
  String get achOverachieverDesc;

  /// No description provided for @achCalmMaster.
  ///
  /// In en, this message translates to:
  /// **'Zen Master'**
  String get achCalmMaster;

  /// No description provided for @achCalmMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'Maintain peak calmness during a difficult task.'**
  String get achCalmMasterDesc;

  /// No description provided for @achExplorer.
  ///
  /// In en, this message translates to:
  /// **'Curious Explorer'**
  String get achExplorer;

  /// No description provided for @achExplorerDesc.
  ///
  /// In en, this message translates to:
  /// **'Try every type of exercise at least once.'**
  String get achExplorerDesc;

  /// No description provided for @rarityCommon.
  ///
  /// In en, this message translates to:
  /// **'Common'**
  String get rarityCommon;

  /// No description provided for @rarityRare.
  ///
  /// In en, this message translates to:
  /// **'Rare'**
  String get rarityRare;

  /// No description provided for @rarityEpic.
  ///
  /// In en, this message translates to:
  /// **'Epic'**
  String get rarityEpic;

  /// No description provided for @rarityLegendary.
  ///
  /// In en, this message translates to:
  /// **'Legendary'**
  String get rarityLegendary;

  /// No description provided for @howToUnlock.
  ///
  /// In en, this message translates to:
  /// **'How to Unlock'**
  String get howToUnlock;

  /// No description provided for @achievementUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked'**
  String get achievementUnlocked;

  /// No description provided for @achievementLocked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get achievementLocked;

  /// No description provided for @achProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get achProgress;

  /// No description provided for @achPointsCount.
  ///
  /// In en, this message translates to:
  /// **'+{count} Points'**
  String achPointsCount(int count);

  /// No description provided for @achUnlockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlocked!'**
  String get achUnlockedTitle;

  /// No description provided for @loginToViewAchievements.
  ///
  /// In en, this message translates to:
  /// **'Please log in to view achievements'**
  String get loginToViewAchievements;

  /// No description provided for @errorLoadingAchievements.
  ///
  /// In en, this message translates to:
  /// **'Error loading achievements'**
  String get errorLoadingAchievements;

  /// No description provided for @totalPointsLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Points'**
  String get totalPointsLabel;

  /// No description provided for @levelIndicator.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String levelIndicator(int level);

  /// No description provided for @achievementsCount.
  ///
  /// In en, this message translates to:
  /// **'{unlocked}/{total} Achievements'**
  String achievementsCount(int unlocked, int total);

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @categoryExercise.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get categoryExercise;

  /// No description provided for @categoryStreaks.
  ///
  /// In en, this message translates to:
  /// **'Streaks'**
  String get categoryStreaks;

  /// No description provided for @categoryCalm.
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get categoryCalm;

  /// No description provided for @categoryMilestones.
  ///
  /// In en, this message translates to:
  /// **'Milestones'**
  String get categoryMilestones;

  /// No description provided for @categorySpecial.
  ///
  /// In en, this message translates to:
  /// **'Special'**
  String get categorySpecial;

  /// No description provided for @showOnlyUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Show only unlocked'**
  String get showOnlyUnlocked;

  /// No description provided for @noAchievementsFound.
  ///
  /// In en, this message translates to:
  /// **'No achievements found'**
  String get noAchievementsFound;

  /// Parent dashboard overview tab title
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get parentOverview;

  /// Protocol roadmap card title
  ///
  /// In en, this message translates to:
  /// **'Protocol Roadmap'**
  String get protocolRoadmap;

  /// This week label for stats card
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thisWeek;

  /// Streak stat label
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streak;

  /// Recent activity feed title
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get recentActivity;

  /// Empty state for recent activity
  ///
  /// In en, this message translates to:
  /// **'No recent activity'**
  String get noRecentActivity;

  /// Week 1 title
  ///
  /// In en, this message translates to:
  /// **'Regulation &\nSafety'**
  String get weekTitleRegulationSafety;

  /// Week 2 title
  ///
  /// In en, this message translates to:
  /// **'Focus &\nControl'**
  String get weekTitleFocusControl;

  /// Week 3 title
  ///
  /// In en, this message translates to:
  /// **'Daily\nStructure'**
  String get weekTitleDailyStructure;

  /// Week 4 title
  ///
  /// In en, this message translates to:
  /// **'Creative\nCalm'**
  String get weekTitleCreativeCalm;

  /// Week 5 title
  ///
  /// In en, this message translates to:
  /// **'Mastery &\nAssessment'**
  String get weekTitleIntegrationReview;

  /// No description provided for @weekDesc1.
  ///
  /// In en, this message translates to:
  /// **'Breathing, Body Scan, Daily Tasks'**
  String get weekDesc1;

  /// No description provided for @weekDesc2.
  ///
  /// In en, this message translates to:
  /// **'Memory Flip, Stories'**
  String get weekDesc2;

  /// No description provided for @weekDesc3.
  ///
  /// In en, this message translates to:
  /// **'Daily Tasks, Self-Regulation'**
  String get weekDesc3;

  /// No description provided for @weekDesc4.
  ///
  /// In en, this message translates to:
  /// **'Drawing, Music'**
  String get weekDesc4;

  /// No description provided for @weekDesc5.
  ///
  /// In en, this message translates to:
  /// **'Math Puzzle, Memory Sequence'**
  String get weekDesc5;

  /// No description provided for @selectChildToView.
  ///
  /// In en, this message translates to:
  /// **'Select a child to view their progress'**
  String get selectChildToView;

  /// No description provided for @childProfile.
  ///
  /// In en, this message translates to:
  /// **'Child Profile'**
  String get childProfile;

  /// No description provided for @noChildSelected.
  ///
  /// In en, this message translates to:
  /// **'No Child Selected'**
  String get noChildSelected;

  /// No description provided for @createChildToStart.
  ///
  /// In en, this message translates to:
  /// **'Create a child account to get started'**
  String get createChildToStart;

  /// No description provided for @createChildAccountLabel.
  ///
  /// In en, this message translates to:
  /// **'Create Child Account'**
  String get createChildAccountLabel;

  /// No description provided for @manageChild.
  ///
  /// In en, this message translates to:
  /// **'Manage Child'**
  String get manageChild;

  /// No description provided for @rewardsAndEncouragement.
  ///
  /// In en, this message translates to:
  /// **'Rewards & Encouragement'**
  String get rewardsAndEncouragement;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessage;

  /// No description provided for @sendMessageDesc.
  ///
  /// In en, this message translates to:
  /// **'Send a message to your child'**
  String get sendMessageDesc;

  /// No description provided for @recentAchievements.
  ///
  /// In en, this message translates to:
  /// **'Recent Achievements'**
  String get recentAchievements;

  /// No description provided for @noAchievementsYet.
  ///
  /// In en, this message translates to:
  /// **'No achievements yet. Keep going!'**
  String get noAchievementsYet;

  /// No description provided for @sendSticker.
  ///
  /// In en, this message translates to:
  /// **'Send Sticker'**
  String get sendSticker;

  /// No description provided for @sendStickerDesc.
  ///
  /// In en, this message translates to:
  /// **'Send a motivational badge'**
  String get sendStickerDesc;

  /// No description provided for @accountSafety.
  ///
  /// In en, this message translates to:
  /// **'Account Safety'**
  String get accountSafety;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @resetPasswordDesc.
  ///
  /// In en, this message translates to:
  /// **'Send recovery email to child'**
  String get resetPasswordDesc;

  /// No description provided for @removeChild.
  ///
  /// In en, this message translates to:
  /// **'Remove Child'**
  String get removeChild;

  /// No description provided for @removeChildDesc.
  ///
  /// In en, this message translates to:
  /// **'Unlink account from parent'**
  String get removeChildDesc;

  /// No description provided for @watchStatus.
  ///
  /// In en, this message translates to:
  /// **'Watch Status'**
  String get watchStatus;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @device.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get device;

  /// No description provided for @battery.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get battery;

  /// No description provided for @lastSyncedAt.
  ///
  /// In en, this message translates to:
  /// **'Last synced: {timestamp}'**
  String lastSyncedAt(String timestamp);

  /// No description provided for @ageYearsOld.
  ///
  /// In en, this message translates to:
  /// **'{age} years old'**
  String ageYearsOld(String age);

  /// No description provided for @selfReportedActivity.
  ///
  /// In en, this message translates to:
  /// **'Self-Reported Activity'**
  String get selfReportedActivity;

  /// No description provided for @dominantMood.
  ///
  /// In en, this message translates to:
  /// **'Dominant Mood'**
  String get dominantMood;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
