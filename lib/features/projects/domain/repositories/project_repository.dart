import 'package:test_task_manager/features/projects/domain/entities/project.dart';
import 'package:test_task_manager/features/projects/domain/entities/project_result.dart';

abstract interface class IProjectRepository {
  const IProjectRepository();

  Future<ProjectResult<List<Project>>> getProjects();

  Future<ProjectResult<Project>> createProject({
    required String name,
  });
}
