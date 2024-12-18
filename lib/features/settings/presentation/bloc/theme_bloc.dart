import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_manager/features/settings/domain/entities/theme_result.dart';
import 'package:test_task_manager/features/settings/domain/repositories/theme_repository.dart';
import 'package:test_task_manager/features/settings/presentation/bloc/theme_event.dart';
import 'package:test_task_manager/features/settings/presentation/bloc/theme_state.dart';
import 'package:test_task_manager/features/settings/presentation/model/theme.dart';
import 'package:test_task_manager/features/settings/presentation/model/theme_error.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required this.themeRepository})
      : super(const ThemeState$Initial()) {
    on<ThemeEvent>(
      (event, emit) => switch (event) {
        ThemeEvent$Get() => _get(event, emit),
        ThemeEvent$Set() => _set(event, emit),
      },
    );
    add(const ThemeEvent$Get());
  }

  final IThemeRepository themeRepository;

  Future<void> _get(ThemeEvent$Get event, Emitter<ThemeState> emit) async {
    emit(ThemeState$Processing(themeType: state.themeType));
    final themeResult = await themeRepository.getTheme();
    switch (themeResult) {
      case ThemeResult$Success<String>():
        final theme = ThemeTypeAddition.getThemeTypeByName(themeResult.data);
        emit(ThemeState$Data(themeType: theme));
      case ThemeResult$Failure<String>():
        emit(ThemeState$Error(
            themeType: state.themeType, error: ThemeError$FailToGet()));
    }
  }

  Future<void> _set(ThemeEvent$Set event, Emitter<ThemeState> emit) async {
    final initialTheme = event.themeType;
    emit(ThemeState$Processing(themeType: event.themeType));
    final themeResult = await themeRepository.setTheme(event.themeType.name);
    switch (themeResult) {
      case ThemeResult$Success<void>():
        emit(ThemeState$Data(themeType: event.themeType));
      case ThemeResult$Failure<void>():
        emit(ThemeState$Error(
            themeType: initialTheme, error: ThemeError$FailToSet()));
    }
  }
}
