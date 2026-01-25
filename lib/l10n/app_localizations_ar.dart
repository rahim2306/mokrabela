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
  String get todaysCalmTime => 'وقت الهدوء اليوم';

  @override
  String get minutes => 'دقيقة';

  @override
  String get dailyCalmGoal => 'هدف الهدوء اليومي';

  @override
  String get goalReached => 'تم الوصول للهدف!';

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
  String get focusTimer => 'مؤقت التركيز';

  @override
  String get addTask => 'أضف مهمة';

  @override
  String get myTasks => 'مهامي';

  @override
  String get start => 'بدء';

  @override
  String get pause => 'إيقاف مؤقت';

  @override
  String get resume => 'استئناف';

  @override
  String get reset => 'إعادة ضبط';

  @override
  String get taskTitle => 'عنوان المهمة';

  @override
  String get duration => 'المدة (دقيقة)';

  @override
  String get cancel => 'إلغاء';

  @override
  String get save => 'حفظ';

  @override
  String get helloLabel => 'مرحباً';

  @override
  String get letsStartProtocol => 'لنبدأ بروتوكولك';

  @override
  String get missingSquareProtocol => 'لماذا هذا البروتوكول؟';

  @override
  String protocolWelcome(String userName) {
    return 'مرحباً $userName، لنبدأ بروتوكولك';
  }

  @override
  String get protocolExplanation =>
      'تساعدك هذه المربعات الـ 4 على فهم مشاعرك، والتحكم في طاقتك، والعثور على السلام.';

  @override
  String get square1Title => 'الوعي الذاتي';

  @override
  String get square1Desc => 'افهم مشاعرك';

  @override
  String get square2Title => 'التنظيم الذاتي';

  @override
  String get square2Desc => 'تحكم في طاقتك';

  @override
  String get square3Title => 'المهام اليومية';

  @override
  String get square3Desc => 'نظم وقتك';

  @override
  String get square4Title => 'التهدئة النفسية';

  @override
  String get square4Desc => 'اعثر على سلامك';

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
  String get seconds => 'seconds';

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
  String get whyFocusGamesTitle => 'لماذا نلعب ألعاب التركيز؟';

  @override
  String get whyFocusGamesDesc =>
      'تساعد ألعاب التركيز على تحسين التركيز، الذاكرة، والمهارات المعرفية. إنها طريقة ممتعة لتدريب عقلك وتعزيز خفة الحركة الذهنية!';

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

  @override
  String get dtNewTask => 'مهمة جديدة';

  @override
  String get dtTaskTitlePlaceholder => 'على ماذا تريد التركيز؟';

  @override
  String get dtTaskDurationLabel => 'المدة (دقيقة)';

  @override
  String get dtAddButton => 'إضافة';

  @override
  String get dtCancelButton => 'إلغاء';

  @override
  String get howAreYouFeeling => 'بماذا تشعر الآن؟';

  @override
  String get activityLevel => 'مستوى النشاط (1-10)';

  @override
  String get quiet => 'هادئ';

  @override
  String get hyper => 'نشيط جداً';

  @override
  String get guidedBodyScan => 'مسح الجسم الموجه';

  @override
  String get bodyScanDesc => 'تحقق من كل جزء من أجزاء جسمك.';

  @override
  String get saveSession => 'حفظ جلستي';

  @override
  String get connectWatch => 'توصيل ساعتك';

  @override
  String get watchScanning => 'البحث عن ساعتك...';

  @override
  String get watchFound => 'تم العثور على الساعة!';

  @override
  String get watchConnecting => 'جاري الاتصال بساعتك...';

  @override
  String get watchError => 'تعذر العثور على ساعتك. هل هي قيد التشغيل؟';

  @override
  String get pairNow => 'اقرن الآن';

  @override
  String get availableDevices => 'الأجهزة المتاحة';

  @override
  String get noDevicesFound => 'لم يتم العثور على أجهزة قريبة.';

  @override
  String get retryScan => 'إعادة المسح';

  @override
  String get stopTechnique => 'تقنية STOP';

  @override
  String get stopStep1Title => 'S - توقف';

  @override
  String get stopStep1Desc => 'توقف عما تفعله. خذ لحظة.';

  @override
  String get stopStep2Title => 'T - خذ نفساً';

  @override
  String get stopStep2Desc => 'خذ نفساً عميقاً وبطيئاً. اشعر به.';

  @override
  String get stopStep3Title => 'O - لاحظ';

  @override
  String get stopStep3Desc => 'لاحظ أفكارك ومشاعرك.';

  @override
  String get stopStep4Title => 'P - تقدم';

  @override
  String get stopStep4Desc => 'استمر بمزيد من الهدوء والتركيز.';

  @override
  String get breatheWithMe => 'تنفس معي';

  @override
  String get feelingCooler => 'أشعر بهدوء أكبر الآن!';

  @override
  String get expressYourself => 'عبر عن نفسك';

  @override
  String get mindfulnessPrompts => 'تمارين اليقظة';

  @override
  String get drawingCanvas => 'لوحة الرسم';

  @override
  String get clearCanvas => 'مسح';

  @override
  String get saveDrawing => 'حفظ';

  @override
  String get calmingSounds => 'أصوات هادئة';

  @override
  String get bedtimeStories => 'قصص النوم';

  @override
  String get mindfulness => 'اليقظة الذهنية';

  @override
  String get friend => 'صديق';

  @override
  String get emotionHappy => 'سعيد';

  @override
  String get emotionSad => 'حزين';

  @override
  String get emotionAngry => 'غاضب';

  @override
  String get emotionAnxious => 'قلق';

  @override
  String get emotionCalm => 'هادئ';

  @override
  String get emotionTired => 'تعبان';

  @override
  String get reportSaved => 'تم حفظ التقرير! أنت تقوم بعمل رائع.';

  @override
  String errorOccurred(String error) {
    return 'عفواً! خطأ: $error';
  }

  @override
  String get bsStartFeetTitle => 'ابدأ بالقدمين';

  @override
  String get bsStartFeetDesc =>
      'هز أصابع قدميك. اشعر بملامستها للأرض. أرخها الآن.';

  @override
  String get bsMovingLegsTitle => 'التحرك إلى الساقين';

  @override
  String get bsMovingLegsDesc =>
      'شد عضلات ساقك لمدة ثانية... ثم اتركها تسترخي.';

  @override
  String get bsRelaxTummyTitle => 'أرخِ بطنك';

  @override
  String get bsRelaxTummyDesc =>
      'ضع يدك على بطنك. اشعر بارتفاعها وانخفاضها مع تنفسك.';

  @override
  String get bsSoftShouldersTitle => 'أكتاف ناعمة';

  @override
  String get bsSoftShouldersDesc =>
      'ارفع كتفيك إلى أذنيك... ثم أنزلهما بوزن ثقيل.';

  @override
  String get bsPeacefulFaceTitle => 'وجه مسالم';

  @override
  String get bsPeacefulFaceDesc =>
      'ابتسم ابتسامة عريضة... ثم أرخِ وجهك تماماً. أنت تقوم بعمل رائع!';

  @override
  String get bsPeacefulButton => 'أشعر بالسلام';

  @override
  String get dtGreatJob => 'عمل رائع!';

  @override
  String get dtSessionFinished => 'لقد أنهيت جلسة التركيز الخاصة بك!';

  @override
  String get dtAwesome => 'رائع!';

  @override
  String dtProgress(String completed, String total) {
    return 'تم إنجاز $completed من أصل $total';
  }

  @override
  String get dtTaskList => 'قائمة المهام';

  @override
  String get dtNoTasks => 'لا توجد مهام اليوم';

  @override
  String get dtNoTasksDesc => 'أضف مهمة لتبدأ يومك!';

  @override
  String get galleryPermissionRequired => 'إذن المعرض مطلوب لحفظ الرسومات.';

  @override
  String get savedToGallery => 'تم الحفظ في المعرض! 🎨';

  @override
  String galleryError(String error) {
    return 'خطأ في المعرض: $error';
  }

  @override
  String saveError(String error) {
    return 'خطأ في الحفظ: $error';
  }

  @override
  String get errorLoadingStories => 'خطأ في تحميل القصص';

  @override
  String get noStoriesAvailable => 'لا توجد قصص متاحة';

  @override
  String pagesCount(int count) {
    return '$count صفحات';
  }

  @override
  String pageIndicator(int current, int total) {
    return 'صفحة $current من $total';
  }

  @override
  String get swipeToTurnPage => 'اسحب لقلب الصفحة';

  @override
  String get theEnd => 'النهاية';

  @override
  String get liveHeartbeatMotion => 'نبضات القلب والحركة الحية';

  @override
  String get motionZ => 'الحركة (Z)';

  @override
  String get energy => 'الطاقة';

  @override
  String get liveTag => 'مباشر';

  @override
  String get achFirstBreathing => 'النفس الأول';

  @override
  String get achFirstBreathingDesc => 'أكمل أول تمرين تنفس لك.';

  @override
  String get achBreathing5 => 'تنفس مستقر';

  @override
  String get achBreathing5Desc => 'أكمل 5 تمارين تنفس.';

  @override
  String get achBreathing10 => 'خبير تنفس';

  @override
  String get achBreathing10Desc => 'أكمل 10 تمارين تنفس.';

  @override
  String get achBreathingMaster => 'ماستر التنفس';

  @override
  String get achBreathingMasterDesc => 'أكمل 30 تمرين تنفس.';

  @override
  String get achFirstFocus => 'عقل مركز';

  @override
  String get achFirstFocusDesc => 'أكمل أول تمرين تركيز لك.';

  @override
  String get achFocusChampion => 'بطل التركيز';

  @override
  String get achFocusChampionDesc => 'أكمل 20 تمرين تركيز.';

  @override
  String get achMusicBeginner => 'روح موسيقية';

  @override
  String get achMusicBeginnerDesc => 'استمع إلى 5 مقاطع هادئة.';

  @override
  String get achMusicExpert => 'عاشق الموسيقى';

  @override
  String get achMusicExpertDesc => 'استمع إلى 25 مقطعاً هادئاً.';

  @override
  String get achStoryStarter => 'مستمع القصص';

  @override
  String get achStoryStarterDesc => 'استمع إلى 3 قصص.';

  @override
  String get achStoryMaster => 'عاشق الحكايات';

  @override
  String weekLabel(int count) {
    return 'الأسبوع $count من 5';
  }

  @override
  String get weekPrefix => 'الأسبوع';

  @override
  String get continueTraining => 'استمر في عادات التدريب';

  @override
  String get focusQuest => 'مهمة التركيز';

  @override
  String get mindfulStories => 'قصص واعية';

  @override
  String get calmingRhythms => 'إيقاعات مهدئة';

  @override
  String get finalDiscoveryDashboard => 'لوحة الاستكشاف النهائية';

  @override
  String get protocolAnalytics => 'تحليلات البروتوكول';

  @override
  String get avgStressLevel => 'متوسط مستوى التوتر';

  @override
  String get avgActivityLevel => 'متوسط مستوى النشاط';

  @override
  String get weeklyBreakdown => 'التقسيم الأسبوعي';

  @override
  String get noProtocolData => 'لا توجد بيانات بروتوكول بعد';

  @override
  String get noProtocolDataDesc => 'ستظهر الإحصائيات عند إكمال الأنشطة.';

  @override
  String weekDetail(int index) {
    return 'الأسبوع $index';
  }

  @override
  String sessionsCount(int count) {
    return '$count جلسات';
  }

  @override
  String stressPercentage(int percentage) {
    return '$percentage% توتر';
  }

  @override
  String get achStoryMasterDesc => 'استمع إلى 15 قصة.';

  @override
  String get achStreak3 => 'سلسلة لـ 3 أيام';

  @override
  String get achStreak3Desc => 'حافظ على سلسلة نشاط لمدة 3 أيام.';

  @override
  String get achStreak7 => 'محارب الأسبوع';

  @override
  String get achStreak7Desc => 'حافظ على سلسلة نشاط لمدة 7 أيام.';

  @override
  String get achStreak14 => 'انتصار الأسبوعين';

  @override
  String get achStreak14Desc => 'حافظ على سلسلة نشاط لمدة 14 يوماً.';

  @override
  String get achStreak30 => 'ماستر الشهر';

  @override
  String get achStreak30Desc => 'حافظ على سلسلة نشاط لمدة 30 يوماً.';

  @override
  String get achEarlyBird => 'الطير المبكر';

  @override
  String get achEarlyBirdDesc => 'أكمل 5 جلسات قبل الساعة 9 صباحاً.';

  @override
  String get achCalm10 => '10 دقائق من الهدوء';

  @override
  String get achCalm10Desc => 'ابقَ في حالة هدوء لمدة 10 دقائق.';

  @override
  String get achCalm30 => '30 دقيقة من الهدوء';

  @override
  String get achCalm30Desc => 'ابقَ في حالة هدوء لمدة 30 دقيقة.';

  @override
  String get achCalm60 => 'ساعة من السلام';

  @override
  String get achCalm60Desc => 'ابقَ في حالة هدوء لمدة ساعة.';

  @override
  String get achReduceHyper20 => 'مقلل النشاط الزائد';

  @override
  String get achReduceHyper20Desc => 'قلل النشاط الزائد بنسبة 20% في الجلسة.';

  @override
  String get achReduceHyper50 => 'ملك الهدوء';

  @override
  String get achReduceHyper50Desc => 'قلل النشاط الزائد بنسبة 50% في الجلسة.';

  @override
  String get achPerfectPosture => 'توازن مثالي';

  @override
  String get achPerfectPostureDesc =>
      'حافظ على وضعية جسم مثالية لمدة 15 دقيقة.';

  @override
  String get achFirstDay => 'اليوم الأول';

  @override
  String get achFirstDayDesc => 'أكمل يومك الأول مع البروتوكول.';

  @override
  String get achFirstWeek => 'نجاح السبعة أيام';

  @override
  String get achFirstWeekDesc => 'أكمل أول أسبوع كامل لك.';

  @override
  String get achFirstMonth => 'محترف البروتوكول';

  @override
  String get achFirstMonthDesc => 'أكمل أول شهر كامل لك.';

  @override
  String get achTasks100 => 'المئوي';

  @override
  String get achTasks100Desc => 'أكمل 100 مهمة بروتوكول.';

  @override
  String get achTasks500 => 'منتصف الطريق إلى الألف';

  @override
  String get achTasks500Desc => 'أكمل 500 مهمة بروتوكول.';

  @override
  String get achTasks1000 => 'عملاق المهام';

  @override
  String get achTasks1000Desc => 'أكمل 1000 مهمة بروتوكول.';

  @override
  String get achQuickLearner => 'متعلم سريع';

  @override
  String get achQuickLearnerDesc => 'أكمل 5 تمارين جديدة في يوم واحد.';

  @override
  String get achOverachiever => 'متفوق';

  @override
  String get achOverachieverDesc =>
      'أكمل جميع مهام البروتوكول لـ 7 أيام متتالية.';

  @override
  String get achCalmMaster => 'ماستر زين';

  @override
  String get achCalmMasterDesc => 'حافظ على قمة الهدوء خلال مهمة صعبة.';

  @override
  String get achExplorer => 'مستكشف فضولي';

  @override
  String get achExplorerDesc => 'جرب كل نوع من التمارين مرة واحدة على الأقل.';

  @override
  String get rarityCommon => 'شائع';

  @override
  String get rarityRare => 'نادر';

  @override
  String get rarityEpic => 'ملحمي';

  @override
  String get rarityLegendary => 'أسطوري';

  @override
  String get howToUnlock => 'طريقة الفتح';

  @override
  String get achievementUnlocked => 'تم الفتح';

  @override
  String get achievementLocked => 'مغلق';

  @override
  String get achProgress => 'التقدم';

  @override
  String achPointsCount(int count) {
    return '+$count نقاط';
  }

  @override
  String get achUnlockedTitle => 'تم الفتح!';

  @override
  String get loginToViewAchievements => 'يرجى تسجيل الدخول لعرض الإنجازات';

  @override
  String get errorLoadingAchievements => 'خطأ في تحميل الإنجازات';

  @override
  String get totalPointsLabel => 'إجمالي النقاط';

  @override
  String levelIndicator(int level) {
    return 'المستوى $level';
  }

  @override
  String achievementsCount(int unlocked, int total) {
    return '$unlocked/$total إنجازات';
  }

  @override
  String get categoryAll => 'الكل';

  @override
  String get categoryExercise => 'تمارين';

  @override
  String get categoryStreaks => 'سلاسل';

  @override
  String get categoryCalm => 'هدوء';

  @override
  String get categoryMilestones => 'إنجازات رئيسية';

  @override
  String get categorySpecial => 'خاص';

  @override
  String get showOnlyUnlocked => 'إظهار المفتوحة فقط';

  @override
  String get noAchievementsFound => 'لم يتم العثور على إنجازات';
}
