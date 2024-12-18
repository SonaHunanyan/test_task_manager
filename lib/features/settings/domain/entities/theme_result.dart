sealed class ThemeResult<T> {
  const ThemeResult();
}

final class ThemeResult$Success<T> extends ThemeResult<T> {
  const ThemeResult$Success({required this.data});

  final T data;
}

final class ThemeResult$Failure<T> extends ThemeResult<T> {
  const ThemeResult$Failure(
    this.error, [
    this.stackTrace,
  ]);

  final Object error;

  final StackTrace? stackTrace;
}
