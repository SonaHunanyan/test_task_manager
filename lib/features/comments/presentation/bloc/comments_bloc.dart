import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_manager/features/comments/domain/entities/comment.dart';
import 'package:test_task_manager/features/comments/domain/entities/comment_result.dart';
import 'package:test_task_manager/features/comments/domain/repositories/comment_repository.dart';
import 'package:test_task_manager/features/comments/presentation/bloc/comments_event.dart';
import 'package:test_task_manager/features/comments/presentation/bloc/comments_state.dart';
import 'package:test_task_manager/features/comments/presentation/model/comments_error.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc({required this.commentRepository, required this.taskId})
      : super(const CommentsState$Initial()) {
    on<CommentsEvent>(
      (event, emit) => switch (event) {
        CommentsEvent$Get() => _get(event, emit),
        CommentsEvent$Create() => _create(event, emit),
        CommentsEvent$Delete() => _delete(event, emit),
        CommentsEvent$Update() => _update(event, emit),
      },
    );
    add(const CommentsEvent$Get());
  }
  final ICommentRepository commentRepository;
  final String taskId;

  Future<void> _get(
      CommentsEvent$Get event, Emitter<CommentsState> emit) async {
    emit(CommentsState$Loading(comments: state.comments));
    final commentsResult = await commentRepository.getComments(
      taskId: taskId,
    );
    switch (commentsResult) {
      case CommentResult$Success<List<Comment>>():
        emit(CommentsState$Data(comments: commentsResult.data));
      case CommentResult$Failure<List<Comment>>():
        emit(CommentsState$Error(
            comments: state.comments, error: const CommentsError$FailToGet()));
    }
  }

  Future<void> _delete(
      CommentsEvent$Delete event, Emitter<CommentsState> emit) async {
    final comments = state.comments;
    comments.removeWhere((e) => e.id == event.commentId);
    emit(CommentsState$Processing(comments: comments));
    final deleteResult =
        await commentRepository.deleteComment(commentId: event.commentId);
    switch (deleteResult) {
      case CommentResult$Success<void>():
        emit(CommentsState$Deleted(comments: comments));
      case CommentResult$Failure<void>():
        emit(CommentsState$Error(
            comments: state.comments,
            error: const CommentsError$FailToDelete()));
    }
  }

  Future<void> _create(
      CommentsEvent$Create event, Emitter<CommentsState> emit) async {
    final tempComment = Comment.fake(
      content: event.content,
      taskId: taskId,
    );
    final comments = [...state.comments, tempComment];
    emit(CommentsState$Processing(comments: comments));
    final commentResult = await commentRepository.createComment(
      taskId: taskId,
      content: event.content,
    );
    switch (commentResult) {
      case CommentResult$Success<Comment>():
        final index = state.comments.indexWhere((e) => e.id == tempComment.id);
        state.comments[index] = commentResult.data;
        emit(CommentsState$Created(comments: state.comments));
      case CommentResult$Failure<Comment>():
        state.comments.remove(tempComment);
        emit(CommentsState$Error(
            comments: state.comments,
            error: const CommentsError$FailToCreate()));
    }
  }

  Future<void> _update(
      CommentsEvent$Update event, Emitter<CommentsState> emit) async {
    final initialComments = [...state.comments];
    final comments = state.comments;
    final index = comments.indexWhere((e) => e.id == event.commentId);
    comments[index] = comments[index].copyWith(content: event.content);
    emit(CommentsState$Processing(comments: comments));
    final commentResult = await commentRepository.updateComment(
      commentId: event.commentId,
      content: event.content,
    );
    switch (commentResult) {
      case CommentResult$Success<Comment>():
        emit(CommentsState$Data(comments: comments));
      case CommentResult$Failure<Comment>():
        emit(CommentsState$Error(
            comments: initialComments,
            error: const CommentsError$FailToUpdate()));
    }
  }
}
