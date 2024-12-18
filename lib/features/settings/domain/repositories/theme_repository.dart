import 'package:test_task_manager/features/settings/domain/entities/theme_result.dart';

abstract interface class IThemeRepository {
  Future<ThemeResult<String>> getTheme();
  Future<ThemeResult<void>> setTheme(String theme);
}
