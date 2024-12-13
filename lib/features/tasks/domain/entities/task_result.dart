sealed class TaskResult<T> {
  const TaskResult();
}

final class TaskResult$Success<T> extends TaskResult<T> {
  const TaskResult$Success({required this.data});

  final T data;
}

final class TaskResult$Failure<T> extends TaskResult<T> {
  const TaskResult$Failure(
    this.error, [
    this.stackTrace,
  ]);

  final Object error;

  final StackTrace? stackTrace;
}
