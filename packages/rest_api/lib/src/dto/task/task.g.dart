// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskDto _$TaskDtoFromJson(Map<String, dynamic> json) => TaskDto(
      id: json['id'] as String,
      content: json['content'] as String,
      description: json['description'] as String,
      commentCount: (json['comment_count'] as num).toInt(),
      isCompleted: (json['is_completed'] as num).toInt(),
      order: (json['order'] as num).toInt(),
      priority: (json['priority'] as num).toInt(),
      projectId: json['project_id'] as String,
      labels:
          (json['labels'] as List<dynamic>).map((e) => e as String).toList(),
      creatorId: json['creator_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      due: json['due'] == null
          ? null
          : DueDto.fromJson(json['due'] as Map<String, dynamic>),
      sectionId: json['section_id'] as String?,
      parentId: json['parent_id'] as String?,
      assigneeId: json['assignee_id'] as String?,
      assignerId: json['assigner_id'] as String?,
    );

Map<String, dynamic> _$TaskDtoToJson(TaskDto instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'description': instance.description,
      'comment_count': instance.commentCount,
      'is_completed': instance.isCompleted,
      'order': instance.order,
      'priority': instance.priority,
      'project_id': instance.projectId,
      'labels': instance.labels,
      'due': instance.due,
      'section_id': instance.sectionId,
      'parent_id': instance.parentId,
      'creator_id': instance.creatorId,
      'created_at': instance.createdAt.toIso8601String(),
      'assignee_id': instance.assigneeId,
      'assigner_id': instance.assignerId,
    };
