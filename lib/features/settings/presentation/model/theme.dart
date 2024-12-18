import 'package:flutter/material.dart';
import 'package:test_task_manager/core/theme/dark_theme.dart';
import 'package:test_task_manager/core/theme/light_theme.dart';

enum ThemeType {
  light,
  dark,
}

extension ThemeTypeAddition on ThemeType {
  static ThemeType getThemeTypeByName(String name) {
    return ThemeType.values.firstWhere(
        (element) => element.name.toLowerCase() == name.toLowerCase());
  }

  ThemeData get themeData {
    switch (this) {
      case ThemeType.light:
        return lightTheme;
      case ThemeType.dark:
        return darkTheme;
    }
  }

  bool get isDark => this == ThemeType.dark;
}
