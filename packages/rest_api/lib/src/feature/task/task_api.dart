import 'package:dio/dio.dart';
import 'package:rest_api/src/constants/paths.dart';
import 'package:rest_api/src/dto/task/task.dart';

class TaskApi {
  const TaskApi(this._client);
  final Dio _client;

  Future<List<TaskDto>> getTasks() async {
    final response = await _client.get<dynamic>(Paths.tasks);
    final tasksJson = response.data;
    final tasks = <TaskDto>[];
    for (final t in tasksJson) {
      tasks.add(TaskDto.fromJson(t));
    }
    return tasks;
  }

  Future<TaskDto> createTask({
    required String projectId,
    required String content,
  }) async {
    final response = await _client.post<dynamic>(Paths.tasks, data: {
      'project_id': projectId,
      'content': content,
    });
    final taskJson = response.data;
    return TaskDto.fromJson(taskJson);
  }

  Future<TaskDto> updateTask({
    required String id,
    required int priority,
  }) async {
    final response = await _client.post<dynamic>('${Paths.tasks}/$id', data: {
      'priority': priority,
    });
    final taskJson = response.data;
    return TaskDto.fromJson(taskJson);
  }

  Future<TaskDto> deleteTask({
    required String id,
  }) async {
    final response = await _client.delete<dynamic>('${Paths.tasks}/$id');
    final taskJson = response.data;
    return TaskDto.fromJson(taskJson);
  }
}
