import 'package:test_task_manager/features/settings/presentation/model/theme.dart';
import 'package:test_task_manager/features/settings/presentation/model/theme_error.dart';

class ThemeState {
  const ThemeState({this.themeType = ThemeType.light});
  final ThemeType themeType;
}

class ThemeState$Initial extends ThemeState {
  const ThemeState$Initial();
}

class ThemeState$Processing extends ThemeState {
  const ThemeState$Processing({required super.themeType});
}

class ThemeState$Data extends ThemeState {
  const ThemeState$Data({required super.themeType});
}

class ThemeState$Error extends ThemeState {
  const ThemeState$Error({
    required super.themeType,
    required this.error,
  });
  final ThemeError error;
}
