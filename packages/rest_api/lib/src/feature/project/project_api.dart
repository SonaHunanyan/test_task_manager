import 'package:dio/dio.dart';
import 'package:rest_api/rest_api.dart';
import 'package:rest_api/src/constants/paths.dart';

class ProjectApi {
  const ProjectApi(this._client);
  final Dio _client;

  Future<List<ProjectDto>> getProjects() async {
    final response = await _client.get<dynamic>(Paths.projects);
    final projectsJson = response.data;
    final projects = <ProjectDto>[];
    for (final p in projectsJson) {
      projects.add(ProjectDto.fromJson(p));
    }
    return projects;
  }

  Future<ProjectDto> createProject({
    required String name,
  }) async {
    final response = await _client.post<dynamic>(Paths.projects, data: {
      'name': name,
    });
    final projectJson = response.data;
    return ProjectDto.fromJson(projectJson);
  }
}
