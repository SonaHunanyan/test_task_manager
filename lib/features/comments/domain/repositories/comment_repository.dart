import 'package:test_task_manager/features/comments/domain/entities/comment.dart';
import 'package:test_task_manager/features/comments/domain/entities/comment_result.dart';

abstract interface class ICommentRepository {
  const ICommentRepository();

  Future<CommentResult<List<Comment>>> getComments({required String taskId});

  Future<CommentResult<Comment>> createComment({
    required String taskId,
    required String content,
  });

  Future<CommentResult<Comment>> updateComment({
    required String commentId,
    required String content,
  });

  Future<CommentResult<void>> deleteComment({
    required String commentId,
  });
}
