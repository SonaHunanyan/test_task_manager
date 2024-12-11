import 'package:json_annotation/json_annotation.dart';
import 'package:rest_api/src/converter/utc.dart';
import 'package:rest_api/src/dto/due/due.dart';

part 'task.g.dart';

@JsonSerializable()
class TaskDto {
  TaskDto({
    required this.id,
    required this.content,
    required this.description,
    required this.commentCount,
    required this.isCompleted,
    required this.order,
    required this.priority,
    required this.projectId,
    required this.labels,
    required this.creatorId,
    required this.createdAt,
    this.due,
    this.sectionId,
    this.parentId,
    this.assigneeId,
    this.assignerId,
  });
  final String id;
  final String content;
  final String description;
  @JsonKey(name: 'comment_count')
  final int commentCount;
  @JsonKey(name: 'is_completed')
  final int isCompleted;
  final int order;
  final int priority;
  @JsonKey(name: 'project_id')
  final String projectId;
  final List<String> labels;
  final DueDto? due;
  @JsonKey(name: 'section_id')
  final String? sectionId;
  @JsonKey(name: 'parent_id')
  final String? parentId;
  @JsonKey(name: 'creator_id')
  final String creatorId;
  @JsonKey(name: 'created_at')
  @UTCConverter()
  final DateTime createdAt;
  @JsonKey(name: 'assignee_id')
  final String? assigneeId;
  @JsonKey(name: 'assigner_id')
  final String? assignerId;
  factory TaskDto.fromJson(Map<String, dynamic> json) =>
      _$TaskDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TaskDtoToJson(this);
}
