import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'style_guide.dart';

class AppThemeData {
  AppThemeData._();
  static ThemeData get theme {
    return ThemeData(
      // Primary colors
      primaryColor: AppColors.familyPrimary,
      primarySwatch:
          MaterialColor(AppColors.familyPrimary.toARGB32(), const <int, Color>{
            50: AppColors.primary100,
            100: AppColors.primary100,
            200: AppColors.primary200,
            300: AppColors.primary300,
            400: AppColors.primary400,
            500: AppColors.primary500,
            600: AppColors.primary500,
            700: AppColors.primary500,
            800: AppColors.primary500,
            900: AppColors.primary500,
          }),

      // Scaffold and background
      scaffoldBackgroundColor: AppColors.bgPrimary,
      canvasColor: AppColors.bgPrimary,

      // App bar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.bgPrimary,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),

      // Text field theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.bgTertiary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusNormal),
          borderSide: const BorderSide(color: AppColors.borderDisabled),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusNormal),
          borderSide: const BorderSide(color: AppColors.borderDisabled),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusNormal),
          borderSide: const BorderSide(
            color: AppColors.familyPrimary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusNormal),
          borderSide: const BorderSide(color: AppColors.borderError),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.spacingMd,
          vertical: AppSpacing.spacingMd,
        ),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.familyPrimary,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.buttonDisabled,
          disabledForegroundColor: AppColors.textSecondary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.spacing2xl,
            vertical: AppSpacing.spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusNormal),
          ),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.familyPrimary,
          disabledForegroundColor: AppColors.textSecondary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.spacingMd,
            vertical: AppSpacing.spacingSm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusNormal),
          ),
        ),
      ),

      // Color scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.familyPrimary,
        secondary: AppColors.familySecondary,
        surface: AppColors.bgPrimary,
        error: AppColors.familyError,
        onSecondary: AppColors.white,
        onSurface: AppColors.textPrimary,
      ),

      // Text theme
      textTheme: const TextTheme(
        headlineLarge: AppStyles.h1,
        headlineMedium: AppStyles.h2,
        headlineSmall: AppStyles.h3,
        bodyLarge: AppStyles.p1,
        bodyMedium: AppStyles.p2,
        bodySmall: AppStyles.label1,
        labelLarge: AppStyles.label1,
        labelMedium: AppStyles.label2,
      ),
    );
  }
}
