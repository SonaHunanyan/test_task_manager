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
    int? priority,
    String? content,
    String? description,
  }) async {
    final response = await _client.post<dynamic>('${Paths.tasks}/$id', data: {
      if (priority != null) 'priority': priority,
      if (content != null) 'content': content,
      if (description != null) 'description': description,
    });
    final taskJson = response.data;
    return TaskDto.fromJson(taskJson);
  }

  Future<TaskDto> updateTaskDueTime({
    required String id,
    required String? dueTime,
    int? duration,
  }) async {
    final response = await _client.post<dynamic>('${Paths.tasks}/$id', data: {
      'due_datetime': dueTime,
      if (duration != null && duration > 0) 'duration': duration,
      if (duration != null && duration > 0) 'duration_unit': 'minute',
    });
    final taskJson = response.data;
    return TaskDto.fromJson(taskJson);
  }

  Future<void> deleteTask({
    required String id,
  }) async {
    await _client.delete<dynamic>('${Paths.tasks}/$id');
  }
}
