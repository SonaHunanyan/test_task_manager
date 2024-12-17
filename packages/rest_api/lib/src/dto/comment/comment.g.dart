// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentDto _$CommentDtoFromJson(Map<String, dynamic> json) => CommentDto(
      content: json['content'] as String,
      id: json['id'] as String,
      postedAt: DateTime.parse(json['posted_at'] as String),
      taskId: json['task_id'] as String,
      projectId: json['project_id'] as String?,
    );

Map<String, dynamic> _$CommentDtoToJson(CommentDto instance) =>
    <String, dynamic>{
      'content': instance.content,
      'id': instance.id,
      'posted_at': instance.postedAt.toIso8601String(),
      'project_id': instance.projectId,
      'task_id': instance.taskId,
    };
