import 'package:flutter/material.dart';

/// ثيم مخصص للأطفال المصابين بـ ADHD (7-11 سنة)
/// يركز على الألوان الهادئة والتصميم البسيط والواضح
class ADHDKidsTheme {
  // الألوان الأساسية - ألوان هادئة ومريحة للعين
  static const Color primaryBlue = Color(0xFF4A90E2); // أزرق هادئ
  static const Color secondaryGreen = Color(0xFF7ED321); // أخضر مريح
  static const Color accentOrange = Color(0xFFFF9500); // برتقالي دافئ
  static const Color softPurple = Color(0xFF9013FE); // بنفسجي ناعم
  static const Color calmTeal = Color(0xFF50E3C2); // تركوازي هادئ

  // ألوان الخلفية
  static const Color backgroundLight = Color(0xFFF8F9FA); // خلفية فاتحة
  static const Color backgroundCard = Color(0xFFFFFFFF); // خلفية البطاقات
  static const Color backgroundGradientStart = Color(
    0xFFE3F2FD,
  ); // بداية التدرج
  static const Color backgroundGradientEnd = Color(0xFFF1F8E9); // نهاية التدرج

  // ألوان النص
  static const Color textPrimary = Color(0xFF2C3E50); // نص أساسي
  static const Color textSecondary = Color(0xFF7F8C8D); // نص ثانوي
  static const Color textLight = Color(0xFFBDC3C7); // نص فاتح

  // ألوان الحالة
  static const Color successGreen = Color(0xFF27AE60); // نجاح
  static const Color warningYellow = Color(0xFFF39C12); // تحذير
  static const Color errorRed = Color(0xFFE74C3C); // خطأ
  static const Color infoBlue = Color(0xFF3498DB); // معلومات

  // ألوان خاصة بـ ADHD
  static const Color focusBlue = Color(0xFF5DADE2); // لون التركيز
  static const Color calmGreen = Color(0xFF58D68D); // لون الهدوء
  static const Color energyOrange = Color(0xFFEB984E); // لون الطاقة
  static const Color balancePurple = Color(0xFFAF7AC5); // لون التوازن
  static const Color warningOrange = Color(0xFFF39C12); // نفس لون warningYellow
  /// الثيم الرئيسي للتطبيق
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        brightness: Brightness.light,
        primary: primaryBlue,
        secondary: secondaryGreen,
        tertiary: softPurple,
        surface: backgroundCard,
        error: errorRed,
      ),

      // الخطوط - خطوط واضحة وسهلة القراءة
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          letterSpacing: 0.5,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          letterSpacing: 0.5,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0.5,
        ),
        headlineLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0.3,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0.3,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textPrimary,
          letterSpacing: 0.3,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textPrimary,
          letterSpacing: 0.2,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textPrimary,
          letterSpacing: 0.2,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textSecondary,
          letterSpacing: 0.2,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: textPrimary,
          letterSpacing: 0.1,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: textPrimary,
          letterSpacing: 0.1,
          height: 1.4,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: textSecondary,
          letterSpacing: 0.1,
          height: 1.3,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textPrimary,
          letterSpacing: 0.1,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textSecondary,
          letterSpacing: 0.1,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: textLight,
          letterSpacing: 0.1,
        ),
      ),

      // تصميم الأزرار
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: primaryBlue.withAlpha((0.3 * 255).round()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),

      // تصميم البطاقات
      cardTheme: CardThemeData(
        color: backgroundCard,
        elevation: 6,
        shadowColor: Colors.black.withAlpha((0.1 * 255).round()),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      ),

      // تصميم شريط التطبيق
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: 0.3,
        ),
        iconTheme: IconThemeData(color: Colors.white, size: 24),
      ),

      // تصميم حقول الإدخال
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: backgroundCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: textLight, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: textLight, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: errorRed, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        labelStyle: const TextStyle(color: textSecondary, fontSize: 14),
        hintStyle: const TextStyle(color: textLight, fontSize: 14),
      ),

      // تصميم الأيقونات
      iconTheme: const IconThemeData(color: primaryBlue, size: 24),

      // تصميم التبديل والمؤشرات
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return secondaryGreen;
          }
          return textLight;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return secondaryGreen.withAlpha((0.3 * 255).round());
          }
          return textLight.withAlpha((0.3 * 255).round());
        }),
      ),

      // تصميم شريط التقدم
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryBlue,
        linearTrackColor: backgroundLight,
        circularTrackColor: backgroundLight,
      ),

      // تصميم الحوارات
      dialogTheme: DialogThemeData(
        backgroundColor: backgroundCard,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        contentTextStyle: const TextStyle(
          fontSize: 16,
          color: textPrimary,
          height: 1.5,
        ),
      ),

      // تصميم الشرائح السفلية
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: backgroundCard,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
    );
  }

  /// تدرجات لونية مخصصة للأطفال
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, calmTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [secondaryGreen, calmGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warningGradient = LinearGradient(
    colors: [accentOrange, energyOrange],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [backgroundGradientStart, backgroundGradientEnd],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /// ظلال مخصصة
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withAlpha((0.08 * 255).round()),
      blurRadius: 12,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withAlpha((0.04 * 255).round()),
      blurRadius: 6,
      offset: const Offset(0, 2),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get buttonShadow => [
    BoxShadow(
      color: primaryBlue.withAlpha((0.3 * 255).round()),
      blurRadius: 8,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
  ];

  /// أحجام مخصصة للأطفال
  static const double buttonHeight = 56.0;
  static const double cardPadding = 20.0;
  static const double borderRadius = 16.0;
  static const double iconSize = 28.0;
  static const double spacing = 16.0;

  /// ألوان حسب مستوى فرط النشاط
  static Color getHyperactivityColor(double level) {
    if (level < 30) return calmGreen;
    if (level < 60) return warningYellow;
    if (level < 80) return accentOrange;
    return errorRed;
  }

  /// ألوان حسب مستوى التركيز
  static Color getFocusColor(double level) {
    if (level > 80) return focusBlue;
    if (level > 60) return calmTeal;
    if (level > 40) return warningYellow;
    return errorRed;
  }

  /// تصميم خاص بالتمارين
  static BoxDecoration get exerciseCardDecoration => BoxDecoration(
    gradient: const LinearGradient(
      colors: [Color(0xFFE8F5E8), Color(0xFFF0F8FF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(borderRadius),
    boxShadow: cardShadow,
  );

  /// تصميم خاص بالإحصائيات
  static BoxDecoration get statsCardDecoration => BoxDecoration(
    gradient: const LinearGradient(
      colors: [Color(0xFFF8F9FA), Color(0xFFE9ECEF)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    borderRadius: BorderRadius.circular(borderRadius),
    boxShadow: cardShadow,
  );

  /// تصميم خاص بالتنبيهات
  static BoxDecoration getAlertDecoration(String type) {
    Color startColor, endColor;
    switch (type) {
      case 'success':
        startColor = successGreen.withAlpha((0.1 * 255).round());
        endColor = calmGreen.withAlpha((0.1 * 255).round());
        break;
      case 'warning':
        startColor = warningYellow.withAlpha((0.1 * 255).round());
        endColor = accentOrange.withAlpha((0.1 * 255).round());
        break;
      case 'error':
        startColor = errorRed.withAlpha((0.1 * 255).round());
        endColor = errorRed.withAlpha((0.2 * 255).round());
        break;
      default:
        startColor = infoBlue.withAlpha((0.1 * 255).round());
        endColor = primaryBlue.withAlpha((0.1 * 255).round());
    }

    return BoxDecoration(
      gradient: LinearGradient(
        colors: [startColor, endColor],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: type == 'success'
            ? successGreen
            : type == 'warning'
            ? warningYellow
            : type == 'error'
            ? errorRed
            : infoBlue,
        width: 1,
      ),
    );
  }

  // دالة لتحديد لون مستوى النشاط
  static Color getActivityLevelColor(double level) {
    if (level < 30) return calmGreen; // استبدال activityLow
    if (level < 70) return warningYellow; // استبدال activityMedium
    return accentOrange; // استبدال activityHigh
  }

  // ستايل للأزرار الثانوية
  static ButtonStyle get secondaryButtonStyle {
    return ElevatedButton.styleFrom(
      backgroundColor: accentOrange,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }

  // ستايل للأزرار الخطيرة
  static ButtonStyle get dangerButtonStyle {
    return ElevatedButton.styleFrom(
      backgroundColor: errorRed,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }

  // ستايل للأزرار الناجحة
  static ButtonStyle get successButtonStyle {
    return ElevatedButton.styleFrom(
      backgroundColor: successGreen,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
