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
}