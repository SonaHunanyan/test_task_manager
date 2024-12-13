class Project {
  const Project({
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
  final int commentCount;
  final int order;
  final String color;
  final bool isShared;
  final bool isFavorite;
  final bool isInboxProject;
  final bool isTeamInbox;
  final String viewStyle;
  final String url;
  final String? parentId;
}
