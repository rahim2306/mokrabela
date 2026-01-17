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

  /// Protocol label
  ///
  /// In en, this message translates to:
  /// **'Protocol'**
  String get protocol;

  /// Achievements button label
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

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
