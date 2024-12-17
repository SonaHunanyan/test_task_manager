import 'package:rest_api/rest_api.dart';
import 'package:test_task_manager/features/comments/domain/entities/comment.dart';

class CommentMapper {
  static Comment toComment(CommentDto commentDto) {
    return Comment(
      content: commentDto.content,
      id: commentDto.id,
      postedAt: commentDto.postedAt.toLocal(),
      projectId: commentDto.projectId,
      taskId: commentDto.taskId,
    );
  }

  static List<Comment> toComments(List<CommentDto> dtos) {
    return dtos.map(toComment).toList();
  }
}
