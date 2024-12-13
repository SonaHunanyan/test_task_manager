import 'package:rest_api/rest_api.dart';
import 'package:test_task_manager/features/projects/data/mappers/project_mapper.dart';
import 'package:test_task_manager/features/projects/domain/entities/project.dart';
import 'package:test_task_manager/features/projects/domain/entities/project_result.dart';
import 'package:test_task_manager/features/projects/domain/repositories/project_repository.dart';

class ProjectRepository implements IProjectRepository {
  const ProjectRepository(this._projectApi);
  final ProjectApi _projectApi;
  @override
  Future<ProjectResult<List<Project>>> getProjects() async {
    try {
      final projectsDto = await _projectApi.getProjects();
      final projects = ProjectMapper.toProjects(projectsDto);
      return ProjectResult$Success(data: projects);
    } catch (e, s) {
      return ProjectResult$Failure(e, s);
    }
  }

  @override
  Future<ProjectResult<Project>> createProject({
    required String name,
  }) async {
    try {
      final projectDto = await _projectApi.createProject(
        name: name,
      );
      return ProjectResult$Success(data: ProjectMapper.toProject(projectDto));
    } catch (e, s) {
      return ProjectResult$Failure(e, s);
    }
  }
}
