import 'package:test_task_manager/features/comments/domain/entities/comment.dart';
import 'package:test_task_manager/features/comments/presentation/model/comments_error.dart';

class CommentsState {
  const CommentsState({this.comments = const <Comment>[]});
  final List<Comment> comments;
}

class CommentsState$Initial extends CommentsState {
  const CommentsState$Initial();
}

class CommentsState$Processing extends CommentsState {
  const CommentsState$Processing({required super.comments});
}

class CommentsState$Loading extends CommentsState {
  const CommentsState$Loading({required super.comments});
}

class CommentsState$Data extends CommentsState {
  const CommentsState$Data({required super.comments});
}

class CommentsState$Created extends CommentsState {
  const CommentsState$Created({required super.comments});
}

class CommentsState$Deleted extends CommentsState {
  const CommentsState$Deleted({required super.comments});
}

class CommentsState$Error extends CommentsState {
  const CommentsState$Error({
    required super.comments,
    required this.error,
  });
  final CommentsError error;
}
