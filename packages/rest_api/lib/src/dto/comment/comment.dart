import 'package:json_annotation/json_annotation.dart';
import 'package:rest_api/src/converter/utc.dart';

part 'comment.g.dart';

@JsonSerializable()
class CommentDto {
  const CommentDto({
    required this.content,
    required this.id,
    required this.postedAt,
    required this.taskId,
    this.projectId,
  });

  @UTCConverter()
  final String content;
  final String id;
  @JsonKey(name: 'posted_at')
  final DateTime postedAt;
  @JsonKey(name: 'project_id')
  final String? projectId;
  @JsonKey(name: 'task_id')
  final String taskId;

  factory CommentDto.fromJson(Map<String, dynamic> json) =>
      _$CommentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CommentDtoToJson(this);
}
