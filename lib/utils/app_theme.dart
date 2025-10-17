import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF3366FF);
  static const Color primaryDark = Color(0xFF2541B2);
  static const Color primaryLight = Color(0xFF7B9FFF);

  // Accent colors
  static const Color accent = Color(0xFF4CAF50);
  static const Color accentDark = Color(0xFF388E3C);

  // Background colors
  static const Color background = Colors.white;
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFFE0E0E0);

  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFF9E9E9E);

  // Button colors
  static const Color buttonBackground = primary;
  static const Color buttonText = Colors.white;
  static const Color buttonDisabled = Color(0xFFBDBDBD);

  // Other colors
  static const Color divider = Color(0xFFDDDDDD);
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);
}

class AppTextStyles {
  // Headings
  static const TextStyle headline1 = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static const TextStyle headline3 = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Body text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18.0,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16.0,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 14.0,
    color: AppColors.textSecondary,
  );

  // Other text styles
  static const TextStyle caption = TextStyle(
    fontSize: 12.0,
    color: AppColors.textLight,
    letterSpacing: 0.2,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: AppColors.buttonText,
    letterSpacing: 0.5,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.headline1,
      displayMedium: AppTextStyles.headline2,
      displaySmall: AppTextStyles.headline3,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.button,
      titleMedium: AppTextStyles.subtitle,
      titleSmall: AppTextStyles.caption,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      error: AppColors.error,
    ),
  );
}