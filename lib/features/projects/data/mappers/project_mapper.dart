import 'package:rest_api/rest_api.dart';
import 'package:test_task_manager/features/projects/domain/entities/project.dart';

class ProjectMapper {
  static Project toProject(ProjectDto projectDto) {
    return Project(
      id: projectDto.id,
      name: projectDto.name,
      commentCount: projectDto.commentCount,
      order: projectDto.order,
      color: projectDto.color,
      isShared: projectDto.isShared,
      isFavorite: projectDto.isFavorite,
      isInboxProject: projectDto.isInboxProject,
      isTeamInbox: projectDto.isTeamInbox,
      viewStyle: projectDto.viewStyle,
      url: projectDto.url,
      parentId: projectDto.parentId,
    );
  }

  static List<Project> toProjects(List<ProjectDto> dtos) {
    return dtos.map(toProject).toList();
  }
}
