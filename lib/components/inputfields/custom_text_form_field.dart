import 'package:flutter/material.dart';

/// A reusable custom text form field widget with regex validation support
class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? regexPattern;
  final String? errorMessage;
  final String? Function(String?)? customValidator;
  final int? maxLines;
  final TextCapitalization textCapitalization;
  final bool enabled;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.regexPattern,
    this.errorMessage,
    this.customValidator,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: obscureText ? 1 : maxLines,
      textCapitalization: textCapitalization,
      enabled: enabled,
      style: const TextStyle(
        color: Color(0xFF2C3E50),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      validator: (value) {
        // Use custom validator if provided
        if (customValidator != null) {
          return customValidator!(value);
        }

        // Check if value is empty
        if (value == null || value.isEmpty) {
          return errorMessage ?? 'This field is required';
        }

        // Check regex pattern if provided
        if (regexPattern != null) {
          final regex = RegExp(regexPattern!);
          if (!regex.hasMatch(value)) {
            return errorMessage ?? 'Invalid input format';
          }
        }

        return null;
      },
    );
  }
}

/// Common regex patterns for validation
class ValidationPatterns {
  // Email validation pattern
  static const String email = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  // Password validation (minimum 6 characters)
  static const String passwordMin6 = r'^.{6,}$';

  // Password validation (minimum 8 characters, at least one letter and one number)
  static const String passwordStrong =
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';

  // Name validation (letters, spaces, hyphens only)
  static const String name = r'^[a-zA-Z\s\-]+$';

  // Phone number validation (basic international format)
  static const String phone = r'^\+?[\d\s\-\(\)]+$';

  // Numbers only
  static const String numbersOnly = r'^\d+$';

  // Alphanumeric only
  static const String alphanumeric = r'^[a-zA-Z0-9]+$';
}
