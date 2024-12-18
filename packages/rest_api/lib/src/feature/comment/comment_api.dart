import 'package:dio/dio.dart';
import 'package:rest_api/rest_api.dart';
import 'package:rest_api/src/constants/paths.dart';

class CommentApi {
  const CommentApi(this._client);
  final Dio _client;

  Future<List<CommentDto>> getComments({required String taskId}) async {
    final response =
        await _client.get<dynamic>(Paths.comments, queryParameters: {
      'task_id': taskId,
    });
    final commentsJson = response.data;
    final comments = <CommentDto>[];
    for (final c in commentsJson) {
      comments.add(CommentDto.fromJson(c));
    }
    return comments;
  }

  Future<CommentDto> createComment({
    required String taskId,
    required String content,
  }) async {
    final response = await _client.post<dynamic>(Paths.comments, data: {
      'task_id': taskId,
      'content': content,
    });
    final commentJson = response.data;
    return CommentDto.fromJson(commentJson);
  }

  Future<CommentDto> updateComment({
    required String commentId,
    required String content,
  }) async {
    final response =
        await _client.post<dynamic>('${Paths.comments}/$commentId', data: {
      'content': content,
    });
    final commentJson = response.data;
    return CommentDto.fromJson(commentJson);
  }

  Future<void> deleteComment({
    required String commentId,
  }) async {
    await _client.delete<dynamic>('${Paths.comments}/$commentId');
  }
}
