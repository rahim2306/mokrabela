import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// MokraBela App Theme - Unified theme with improved contrast
class AppTheme {
  // Primary Brand Colors
  static const Color primary = Color(0xFF4ECDC4); // Teal
  static const Color primaryDark = Color(0xFF3DB8AF);
  static const Color primaryLight = Color(0xFF6FD9D1);

  static const Color secondary = Color(0xFF9B8FD9); // Purple/Lavender
  static const Color secondaryDark = Color(0xFF7B6FB9);
  static const Color secondaryLight = Color(0xFFB5A9E3);

  // Logo Colors
  static const Color deepBlue = Color(0xFF2C5F7C);
  static const Color vibrantOrange = Color(0xFFF9A03F);
  static const Color tealGreen = Color(0xFF3D9970);

  // Text Colors - Improved Contrast
  static const Color textPrimary = Color(
    0xFF1A1A1A,
  ); // Very dark for maximum contrast
  static const Color textSecondary = Color(0xFF4A4A4A); // Dark gray
  static const Color textTertiary = Color(0xFF7F8C8D); // Medium gray
  static const Color textLight = Color(0xFF9E9E9E); // Light gray
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Background Colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color cardBackground = Color(0xFFFAFAFA);

  // Border Colors - Improved Contrast
  static const Color border = Color(0xFFD0D0D0); // Darker border
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color borderDark = Color(0xFF9E9E9E);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color successGreen = Color(0xFF27AE60);
  static const Color error = Color(0xFFE53935);
  static const Color errorRed = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFFFA726);
  static const Color warningYellow = Color(0xFFF39C12);
  static const Color info = Color(0xFF29B6F6);

  // Illustration/Accent Colors
  static const Color illustrationPurple = Color(0xFFB5A9E3);
  static const Color illustrationTeal = Color(0xFF6FD9D1);
  static const Color lightBlue = Color(0xFF5DADE2);
  static const Color softOrange = Color(0xFFFFB366);
  static const Color paleBlue = Color(0xFFE3F2FD);

  // Shadow Colors
  static const Color shadow = Color(0x1A000000);
  static const Color shadowLight = Color(0x0D000000);

  // Gradients
  static const LinearGradient kidsBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFAFAFA), // Off-white at top
      Color(0xFFBBDEE6), // Soft teal/mint in middle
      Color(0xFFFAFAFA), // Off-white at bottom
    ],
    stops: [0.0, 0.1, 0.9],
  );

  /// Main Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.light,
        primary: primary,
        secondary: secondary,
        tertiary: tealGreen,
        surface: Colors.white,
        error: error,
      ),

      // Text Theme - Using nunito font with BOLD weights for maximum contrast
      textTheme: GoogleFonts.spaceGroteskTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold, // w700
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
            fontWeight: FontWeight.w600, // Increased from w500
            color: textPrimary,
            letterSpacing: 0.3,
          ),
          titleLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600, // Increased from w500
            color: textPrimary,
            letterSpacing: 0.2,
          ),
          titleMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600, // Increased from w500
            color: textPrimary,
            letterSpacing: 0.2,
          ),
          titleSmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600, // Increased from w500
            color:
                textPrimary, // Changed from textSecondary for better contrast
            letterSpacing: 0.2,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500, // Increased from normal (w400)
            color: textPrimary,
            letterSpacing: 0.1,
            height: 1.5,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500, // Increased from normal (w400)
            color: textPrimary,
            letterSpacing: 0.1,
            height: 1.4,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500, // Increased from normal (w400)
            color:
                textPrimary, // Changed from textSecondary for better contrast
            letterSpacing: 0.1,
            height: 1.3,
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600, // Increased from w500
            color: textPrimary,
            letterSpacing: 0.1,
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600, // Increased from w500
            color:
                textPrimary, // Changed from textSecondary for better contrast
            letterSpacing: 0.1,
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600, // Increased from w500
            color: textSecondary, // Keep secondary for smallest text
            letterSpacing: 0.1,
          ),
        ),
      ),

      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: GoogleFonts.spaceGrotesk(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 6,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: deepBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.nunito(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: 0.3,
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 24),
      ),

      // Input Decoration Theme - Improved Contrast & Visibility
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF8F9FA), // Light gray fill for contrast
        // Borders
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: border, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderLight, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: deepBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: error, width: 2),
        ),

        // Padding
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),

        // Text Styles - CRITICAL FOR VISIBILITY
        // Typed text style
        hintStyle: const TextStyle(
          color: Color(
            0xFF757575,
          ), // Darker hint for better contrast (was textLight)
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),

        // Label when not focused
        labelStyle: const TextStyle(
          color: textSecondary, // 0xFF4A4A4A - Dark gray
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),

        // Label when focused
        floatingLabelStyle: const TextStyle(
          color: deepBlue, // 0xFF2C5F7C - Matches focused border
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),

        // Error text style
        errorStyle: const TextStyle(
          color: error, // 0xFFE53935 - High contrast red
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),

        // Error text when focused
        errorMaxLines: 2,

        // Icon colors
        prefixIconColor: textSecondary, // 0xFF4A4A4A
        suffixIconColor: textSecondary,

        // Icon color when focused
        iconColor: deepBlue,
      ),

      // Text Selection Theme - Cursor visibility
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: deepBlue, // 0xFF2C5F7C - Visible cursor
        selectionColor: Color(0x332C5F7C), // Light blue selection
        selectionHandleColor: deepBlue,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: deepBlue, size: 24),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        titleTextStyle: GoogleFonts.nunito(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        contentTextStyle: GoogleFonts.nunito(
          fontSize: 16,
          color: textPrimary,
          height: 1.5,
        ),
      ),
    );
  }

  /// Beautiful Gradients
  static const LinearGradient authGradient = LinearGradient(
    colors: [
      Color(0xFF2C5F7C), // Deep blue
      Color(0xFF3D9970), // Teal green
      Color(0xFFF9A03F), // Vibrant orange
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [deepBlue, tealGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [vibrantOrange, softOrange],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Shadows
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 12,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 6,
      offset: const Offset(0, 2),
      spreadRadius: 0,
    ),
  ];

  /// Constants
  static const double buttonHeight = 56.0;
  static const double cardPadding = 20.0;
  static const double borderRadius = 16.0;
  static const double iconSize = 28.0;
  static const double spacing = 16.0;
}
