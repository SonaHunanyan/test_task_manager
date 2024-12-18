import 'package:flutter/material.dart';
import 'package:test_task_manager/core/theme/app_colors.dart';
import 'package:test_task_manager/core/theme/text_styles.dart';

final base = ThemeData.light();

final lightTheme = base.copyWith(
  scaffoldBackgroundColor: Colors.white,
  colorScheme: const ColorScheme.light(
    onSurface: AppColors.backgroundLight,
    secondary: AppColors.secondary,
    secondaryFixed: AppColors.whitePurple,
    primaryContainer: Colors.white,
    primary: AppColors.mail,
    outline: AppColors.strokColor,
    onPrimary: AppColors.mail,
    tertiary: Colors.white,
    scrim: Colors.grey,
    surfaceBright: Colors.white,
    error: Colors.red,
    onSurfaceVariant: AppColors.longTextColor,
    outlineVariant: AppColors.darkSecondaryText,
    tertiaryContainer: Colors.white,
  ),
  primaryColorLight: Colors.white,
  secondaryHeaderColor: AppColors.queueBlue,
  primaryColor: AppColors.inProgressGold,
  primaryColorDark: AppColors.doneGreen,
  disabledColor: AppColors.switcherTrack,

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
