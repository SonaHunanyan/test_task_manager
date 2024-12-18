import 'package:storage/storage.dart';
import 'package:test_task_manager/features/settings/domain/entities/theme_result.dart';
import 'package:test_task_manager/features/settings/domain/repositories/theme_repository.dart';

class ThemeRepository implements IThemeRepository {
  const ThemeRepository(this._store);
  final Store _store;
  @override
  Future<ThemeResult<String>> getTheme() async {
    try {
      final theme = await _store.valueByKey(StoreKeys.theme);
      return ThemeResult$Success(data: theme);
    } catch (e, s) {
      return ThemeResult$Failure(e, s);
    }
  }

  @override
  Future<ThemeResult<void>> setTheme(String theme) async {
    try {
      await _store.setString(StoreKeys.theme, theme);
      return const ThemeResult$Success(data: null);
    } catch (e, s) {
      return ThemeResult$Failure(e, s);
    }
  }
}
