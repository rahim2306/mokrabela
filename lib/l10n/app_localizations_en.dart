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
}
