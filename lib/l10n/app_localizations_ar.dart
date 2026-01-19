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

  @override
  String get whyMusicTitle => 'لماذا نستمع للموسيقى الهادئة؟';

  @override
  String get whyMusicDesc =>
      'تساعد الموسيقى الهادئة على خلق بيئة سلمية، تقليل القلق، وتعزيز الاسترخاء. إنها مثالية للتأمل، الدراسة، أو وقت النوم.';

  @override
  String get whyStoriesTitle => 'لماذا نقرأ القصص؟';

  @override
  String get whyStoriesDesc =>
      'القصص تشعل الخيال، تعلم دروساً قيمة، وتساعد الأطفال على الاسترخاء. إنها طريقة رائعة للاسترخاء والحلم بأشياء كبيرة!';

  @override
  String get breatheIn => 'استنشق';

  @override
  String get breatheOut => 'ازفر';

  @override
  String get cycle => 'دورة';

  @override
  String get complete => 'مكتمل!';

  @override
  String breathingComplete(String exercise) {
    return '🎉 $exercise مكتمل! ✨';
  }

  @override
  String get focusGamesTitle => 'ألعاب التركيز';

  @override
  String get memoryFlipTitle => 'قلب الذاكرة';

  @override
  String get memoryFlipDesc => 'طابق أزواج البطاقات لتحسين الذاكرة والتركيز';

  @override
  String get moves => 'الحركات';

  @override
  String get time => 'الوقت';

  @override
  String get gameComplete => 'اللعبة مكتملة!';

  @override
  String get playAgain => 'العب مرة أخرى';

  @override
  String get wellDone => 'أحسنت!';

  @override
  String get calmMusicTitle => 'موسيقى هادئة';

  @override
  String get rainSounds => 'أصوات المطر';

  @override
  String get rainSoundsDesc => 'مطر لطيف لتهدئة عقلك';

  @override
  String get natureAmbience => 'الطبيعة';

  @override
  String get natureAmbienceDesc => 'أصوات الطبيعة الهادئة';

  @override
  String get oceanWaves => 'أمواج البحر';

  @override
  String get oceanWavesDesc => 'أمواج البحر المهدئة';

  @override
  String get calmMusicTrack => 'موسيقى هادئة';

  @override
  String get calmMusicTrackDesc => 'ألحان مريحة للسلام';

  @override
  String get storiesTitle => 'قصص';

  @override
  String get braveStarTitle => 'النجمة الشجاعة';

  @override
  String get braveStarDesc => 'قصة عن الشجاعة والإيمان بالنفس';

  @override
  String get magicGardenTitle => 'الحديقة السحرية';

  @override
  String get magicGardenDesc => 'اكتشف سحر اللطف';

  @override
  String get friendlyDragonTitle => 'التنين الودود';

  @override
  String get friendlyDragonDesc => 'قصة مؤثرة عن الصداقة';

  @override
  String get braveStarPage1 =>
      'ذات مرة، في السماء الواسعة، عاشت نجمة صغيرة اسمها ستيلا. كانت أصغر نجمة في مجموعتها، لكن كانت لديها أكبر الأحلام.';

  @override
  String get braveStarPage2 =>
      'كل ليلة، كانت ستيلا تشاهد النجوم الأخرى تتألق بشدة. \"أتمنى أن أتألق مثلهم\"، كانت تهمس للقمر.';

  @override
  String get braveStarPage3 =>
      'ذات ليلة، غطت سحابة مظلمة السماء. اختبأت كل النجوم الكبيرة خلفها خوفاً. لكن ستيلا فكرت: \"يجب على أحد أن ينير الطريق للأطفال في الأسفل.\"';

  @override
  String get braveStarPage4 =>
      'بكل شجاعتها، دفعت ستيلا عبر السحابة. كان الأمر صعباً ومخيفاً، لكنها استمرت. بدأ ضوؤها يتوهج أكثر فأكثر!';

  @override
  String get braveStarPage5 =>
      'نظر الأطفال على الأرض ورأوا ضوء ستيلا الشجاع. \"انظروا! نجم ساطع!\" هتفوا. أدركت ستيلا أنها لا تحتاج لأن تكون الأكبر لتحدث فرقاً.';

  @override
  String get braveStarPage6 =>
      'من تلك الليلة فصاعداً، تألقت ستيلا بثقة. تعلمت أن الشجاعة لا تعني عدم الخوف - بل تعني أن تتألق على أي حال. النهاية. ⭐';

  @override
  String get magicGardenPage1 =>
      'في ركن هادئ من العالم، كانت هناك حديقة سحرية لا تظهر إلا لمن يؤمن بالسحر حقاً.';

  @override
  String get magicGardenPage2 =>
      'فتاة فضولية تدعى مايا كانت تحب الاستكشاف. في يوم مشمس، تبعت فراشة ذهبية واكتشفت بوابة مخفية مغطاة بالكروم.';

  @override
  String get magicGardenPage3 =>
      'عندما لمست مايا البوابة، انفتحت بتوهج لطيف. بالداخل كانت أجمل حديقة رأتها على الإطلاق - زهور تغني، وأشجار ترقص، وجداول تتلألأ كالماس.';

  @override
  String get magicGardenPage4 =>
      'في وسط الحديقة وقفت شجرة حكيمة عجوز. \"مرحباً يا مايا\"، قالت بصوت دافئ. \"هذه الحديقة تنمو من اللطف والرعاية. هل ستساعدينها على الازدهار؟\"';

  @override
  String get magicGardenPage5 =>
      'سقت مايا الزهور، وغنت للأشجار، وساعدت المخلوقات الصغيرة. مع كل عمل لطيف، نمت الحديقة أكثر حيوية وسحراً.';

  @override
  String get magicGardenPage6 =>
      'عندما حان وقت المغادرة، أعطت الشجرة مايا بذرة خاصة. \"ازرعي هذه في قلبك\"، قالت. \"اللطف هو السحر الحقيقي.\" ابتسمت مايا، عالمة أنها تستطيع خلق السحر في أي مكان. النهاية. 🌸';

  @override
  String get friendlyDragonPage1 =>
      'عالياً في الجبال الضبابية عاش تنين اسمه إمبر. على عكس التنانين الأخرى، لم يرد إمبر حراسة الكنوز أو إطلاق النار على الفرسان.';

  @override
  String get friendlyDragonPage2 =>
      'أراد إمبر فقط صديقاً. لكن كلما طار إلى القرية، كان الناس يهربون صارخين. \"أنا لست مخيفاً!\" كان إمبر ينادي، لكن لم يبق أحد ليستمع.';

  @override
  String get friendlyDragonPage3 =>
      'في يوم من الأيام، ضاع صبي شجاع صغير اسمه ليو في الجبال. عندما حل الليل وهبت الرياح الباردة، بدأ ليو يبكي. حينها رأى توهجاً برتقالياً دافئاً.';

  @override
  String get friendlyDragonPage4 =>
      'كان إمبر! نفخ التنين بلطف هواءً دافئاً ليبقي ليو مرتاحاً. \"لا تخف\"، قال إمبر بهدوء. \"سأساعدك على العودة إلى المنزل.\"';

  @override
  String get friendlyDragonPage5 =>
      'طار إمبر بليو بأمان إلى القرية. عندما رأى الناس كم كان التنين لطيفاً ورقيقاً، أدركوا أنهم كانوا مخطئين في الحكم عليه بمظهره.';

  @override
  String get friendlyDragonPage6 =>
      'من ذلك اليوم فصاعداً، كان لإمبر العديد من الأصدقاء في القرية. تعلم أن الصداقة الحقيقية تأتي لمن هم لطفاء وصبورون. وتعلم ليو أن أكبر القلوب تأتي أحياناً في أكثر الأشكال غير المتوقعة. النهاية. 🐉';
}
