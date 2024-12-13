sealed class ProjectResult<T> {
  const ProjectResult();
}

final class ProjectResult$Success<T> extends ProjectResult<T> {
  const ProjectResult$Success({required this.data});

  final T data;
}

final class ProjectResult$Failure<T> extends ProjectResult<T> {
  const ProjectResult$Failure(
    this.error, [
    this.stackTrace,
  ]);

  final Object error;

  final StackTrace? stackTrace;
}
