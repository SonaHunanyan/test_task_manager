import 'package:rest_api/rest_api.dart';
import 'package:test_task_manager/features/comments/data/mappers/comment_mapper.dart';
import 'package:test_task_manager/features/comments/domain/entities/comment.dart';
import 'package:test_task_manager/features/comments/domain/entities/comment_result.dart';
import 'package:test_task_manager/features/comments/domain/repositories/comment_repository.dart';

class CommentRepository implements ICommentRepository {
  const CommentRepository(this._commentApi);
  final CommentApi _commentApi;

  @override
  Future<CommentResult<Comment>> createComment(
      {required String taskId, required String content}) async {
    try {
      final commentDto = await _commentApi.createComment(
        taskId: taskId,
        content: content,
      );
      return CommentResult$Success(data: CommentMapper.toComment(commentDto));
    } catch (e, s) {
      return CommentResult$Failure(e, s);
    }
  }

  @override
  Future<CommentResult<void>> deleteComment({required String commentId}) async {
    try {
      await _commentApi.deleteComment(
        commentId: commentId,
      );
      return const CommentResult$Success(data: null);
    } catch (e, s) {
      return CommentResult$Failure(e, s);
    }
  }

  @override
  Future<CommentResult<List<Comment>>> getComments(
      {required String taskId}) async {
    try {
      final commentsDto = await _commentApi.getComments(
        taskId: taskId,
      );
      return CommentResult$Success(data: CommentMapper.toComments(commentsDto));
    } catch (e, s) {
      return CommentResult$Failure(e, s);
    }
  }

  @override
  Future<CommentResult<Comment>> updateComment(
      {required String commentId, required String content}) async {
    try {
      final commentDto = await _commentApi.updateComment(
        commentId: commentId,
        content: content,
      );
      return CommentResult$Success(data: CommentMapper.toComment(commentDto));
    } catch (e, s) {
      return CommentResult$Failure(e, s);
    }
  }
}
