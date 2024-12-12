import 'package:flutter/material.dart';
import 'package:test_task_manager/core/theme/app_colors.dart';
import 'package:test_task_manager/core/theme/text_styles.dart';

final base = ThemeData.dark();

final darkTheme = base.copyWith(
  scaffoldBackgroundColor: Colors.white,
  colorScheme: const ColorScheme.dark(
    onSurface: AppColors.backgroundDark,
    secondary: AppColors.secondary,
    primaryContainer: AppColors.detailColor,
    primary: Colors.white,
    outline: AppColors.blackPurple,
    onPrimary: AppColors.backgroundDark,
    tertiary: AppColors.darkStrokColor,
    surfaceTint: AppColors.backgroundDark,
    scrim: AppColors.backgroundDark,
    error: Colors.red,
    onSurfaceVariant: Color(0xffA6A6A6),
    onPrimaryContainer: AppColors.mail,
    outlineVariant: AppColors.darkSecondaryText,
    tertiaryContainer: AppColors.blackPurple,
  ),
  primaryColorLight: AppColors.backgroundDark,

  /// Text theme
  textTheme: base.primaryTextTheme.copyWith(
    displaySmall: AppTextStyles.displaySmall,
    headlineLarge: AppTextStyles.headlineLarge,
    headlineMedium: AppTextStyles.headlineMedium,
    headlineSmall: AppTextStyles.headlineSmall,
    titleLarge: AppTextStyles.titleLarge,
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    bodySmall: AppTextStyles.bodySmall,
  ),
);
