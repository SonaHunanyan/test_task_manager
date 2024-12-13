import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable()
class ProjectDto {
  const ProjectDto({
    required this.id,
    required this.name,
    required this.commentCount,
    required this.order,
    required this.color,
    required this.isShared,
    required this.isFavorite,
    required this.isInboxProject,
    required this.isTeamInbox,
    required this.viewStyle,
    required this.url,
    this.parentId,
  });
  final String id;
  final String name;
  @JsonKey(name: 'comment_count')
  final int commentCount;
  final int order;
  final String color;
  @JsonKey(name: 'is_shared')
  final bool isShared;
  @JsonKey(name: 'is_favorite')
  final bool isFavorite;
  @JsonKey(name: 'is_inbox_project')
  final bool isInboxProject;
  @JsonKey(name: 'is_team_inbox')
  final bool isTeamInbox;
  @JsonKey(name: 'view_style')
  final String viewStyle;
  final String url;
  @JsonKey(name: 'parent_id')
  final String? parentId;

  factory ProjectDto.fromJson(Map<String, dynamic> json) =>
      _$ProjectDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectDtoToJson(this);
}
