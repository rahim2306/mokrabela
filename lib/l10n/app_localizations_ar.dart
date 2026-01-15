// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'موكرابيلا';

  @override
  String get welcome => 'مرحبا';

  @override
  String hello(String name) {
    return 'مرحبا، $name!';
  }

  @override
  String get languageSelector => 'اختر اللغة';

  @override
  String get english => 'الإنجليزية';

  @override
  String get french => 'الفرنسية';

  @override
  String get arabic => 'العربية';

  @override
  String get changeLanguage => 'تغيير اللغة';

  @override
  String currentLanguage(String language) {
    return 'اللغة الحالية: $language';
  }

  @override
  String get welcomeToMokrabela => 'مرحبًا بكم في موكرابيلا';

  @override
  String get welcomeSubtitle =>
      'نساعد الأطفال على الشعور بالهدوء، وزيادة التركيز، والدعم معًا.';

  @override
  String get getStarted => 'ابدأ الآن';

  @override
  String get logIn => 'تسجيل الدخول';

  @override
  String get welcomeBack => 'مرحبا بعودتك';

  @override
  String get loginSubtitle => 'سجل الدخول لمتابعة رحلتك.';

  @override
  String get loginFailed => 'فشل تسجيل الدخول. يرجى التحقق من بيانات الاعتماد.';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get alreadyHaveAccount => 'هل لديك حساب بالفعل؟';

  @override
  String get onboardingQuestion1 => 'أي جملة تصفك بشكل أفضل؟';

  @override
  String get optionParent => 'أنا ولي أمر أريد متابعة تقدم طفلي.';

  @override
  String get optionTeacher => 'أنا معلم أعمل مع الطلاب.';

  @override
  String get next => 'التالي';

  @override
  String get back => 'رجوع';

  @override
  String get skip => 'تخطي';

  @override
  String get intro1Title => 'الدعم أولًا';

  @override
  String get intro1Description =>
      'الأطفال لا ينظمون أنفسهم وحدهم. بتوجيه من الأولياء والمعلمين، يصبح الهدوء عادة.';

  @override
  String get intro2Title => 'بناء الهدوء الداخلي';

  @override
  String get intro2Description =>
      'خطوة بخطوة، يتعلم الأطفال كيف يهدؤون أنفسهم، ويحسنون تركيزهم، ويشعرون بالتحكم.';

  @override
  String welcomeChild(String name) {
    return 'مرحبًا، $name!';
  }

  @override
  String get watchConnected => 'متصل';

  @override
  String get watchDisconnected => 'غير متصل';

  @override
  String get dailyProgress => 'التقدم اليومي';

  @override
  String tasksRemaining(int count) {
    return '$count مهام متبقية';
  }

  @override
  String get breathingExercise => 'التنفس';

  @override
  String get focusGames => 'ألعاب التركيز';

  @override
  String get calmMusic => 'موسيقى هادئة';

  @override
  String get stories => 'قصص';

  @override
  String get missingSquare => 'المربع المفقود';

  @override
  String get protocol => 'البروتوكول';

  @override
  String get achievements => 'الإنجازات';

  @override
  String get tapToStart => 'اضغط للبدء';

  @override
  String get goodMorning => 'صباح الخير';

  @override
  String get language => 'اللغة';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get tasks => 'المهام';

  @override
  String get manageYourTimeWell => 'أدر وقتك\nبشكل جيد';

  @override
  String get onboardingQuestion2 => 'متى تريد تسجيل الدخول يوميًا؟';

  @override
  String get reminderHabitText => 'التذكير اللطيف يساعدك على بناء عادة.';

  @override
  String get am => 'صباحاً';

  @override
  String get pm => 'مساءً';

  @override
  String get tellUsMoreTitle => 'أخبرنا المزيد عن نفسك';

  @override
  String get tellUsMoreSubtitle => 'اختر بعض الكلمات التي تناسبك';

  @override
  String get profileImage => 'صورة الملف الشخصي';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get familyName => 'اسم العائلة';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get dateOfBirth => 'تاريخ الميلاد';

  @override
  String get gender => 'الجنس';

  @override
  String get male => 'ذكر';

  @override
  String get female => 'أنثى';

  @override
  String get other => 'آخر';

  @override
  String get preferNotToSay => 'أفضل عدم القول';

  @override
  String get goToFinalCheckIn => 'الانتقال إلى التسجيل النهائي';

  @override
  String get iAmA => 'أنا...';

  @override
  String get signUp => 'التسجيل';

  @override
  String get fieldRequired => 'هذا الحقل مطلوب';

  @override
  String get invalidEmail => 'يرجى إدخال بريد إلكتروني صالح';

  @override
  String get passwordTooShort => 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';

  @override
  String get invalidPhoneNumber => 'يرجى إدخال رقم هاتف صالح';

  @override
  String get registrationSuccess => 'تم التسجيل بنجاح!';

  @override
  String get registrationFailed => 'فشل التسجيل. يرجى المحاولة مرة أخرى.';

  @override
  String get emailAlreadyInUse => 'هذا البريد الإلكتروني مستخدم بالفعل';

  @override
  String get weakPassword => 'كلمة المرور ضعيفة جدًا';

  @override
  String get networkError => 'خطأ في الشبكة. يرجى التحقق من اتصالك.';

  @override
  String get selectGender => 'اختر الجنس';

  @override
  String get selectDate => 'اختر التاريخ';

  @override
  String get languageShort => 'عربي';

  @override
  String get breathingExercisesTitle => 'تمارين التنفس';

  @override
  String get goldenBreathTitle => 'التنفس الذهبي';

  @override
  String get goldenBreathDesc => 'تمرين قصير (6 ثوانٍ) للتحفيز والنشاط.';

  @override
  String get butterflyBreathTitle => 'تنفس الفراشة';

  @override
  String get butterflyBreathDesc => 'تمرين هادئ (10 ثوانٍ) للاسترخاء العميق.';

  @override
  String get oceanBreathTitle => 'تنفس المحيط';

  @override
  String get oceanBreathDesc => 'تمرين (8 ثوانٍ) لمحاكاة هدوء الأمواج.';

  @override
  String get forestBreathTitle => 'تنفس الغابة';

  @override
  String get forestBreathDesc => 'تمرين لطيف (7 ثوانٍ) للتوازن الطبيعي.';

  @override
  String get seconds => 'ثواني';

  @override
  String startExercise(String exercise) {
    return 'بدء $exercise...';
  }

  @override
  String get whyBreatheTitle => 'لماذا نتنفس بوعي؟';

  @override
  String get whyBreatheDesc =>
      'تساعد تمارين التنفس على تهدئة العقل، تقليل التوتر، وزيادة التركيز. إنها طريقة سحرية لشحن طاقتك أو الاسترخاء بعد يوم طويل وممتع.';
}
