// ignore_for_file: file_names

sealed class CommentResult<T> {
  const CommentResult();
}

final class CommentResult$Success<T> extends CommentResult<T> {
  const CommentResult$Success({required this.data});

  final T data;
}

final class CommentResult$Failure<T> extends CommentResult<T> {
  const CommentResult$Failure(
    this.error, [
    this.stackTrace,
  ]);

  final Object error;

  final StackTrace? stackTrace;
}
