import 'package:test_task_manager/features/settings/presentation/model/theme.dart';

sealed class ThemeEvent {
  const ThemeEvent();
}

class ThemeEvent$Get extends ThemeEvent {
  const ThemeEvent$Get();
}

class ThemeEvent$Set extends ThemeEvent {
  const ThemeEvent$Set({required this.themeType});
  final ThemeType themeType;
}
