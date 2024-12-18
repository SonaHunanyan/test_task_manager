import 'dart:convert';

import 'package:rest_api/rest_api.dart';
import 'package:storage/storage.dart';
import 'package:test_task_manager/features/tasks/data/mappers/complete_task_mapper.dart';
import 'package:test_task_manager/features/tasks/data/mappers/task_mapper.dart';
import 'package:test_task_manager/features/tasks/domain/entities/complete_task.dart';
import 'package:test_task_manager/features/tasks/domain/entities/task.dart';
import 'package:test_task_manager/features/tasks/domain/entities/task_result.dart';
import 'package:test_task_manager/features/tasks/domain/repositories/task_repository.dart';

class TaskRepository implements ITaskRepository {
  const TaskRepository(
    this._taskApi, {
    required this.store,
  });
  final TaskApi _taskApi;
  final Store store;
  @override
  Future<TaskResult<List<Task>>> getTasks() async {
    try {
      final tasksDto = await _taskApi.getTasks();
      final tasks = TaskMapper.toTasks(tasksDto);
      return TaskResult$Success(data: tasks);
    } catch (e, s) {
      return TaskResult$Failure(e, s);
    }
  }

  @override
  Future<TaskResult<Task>> createTask({
    required String projectId,
    required String content,
  }) async {
    try {
      final taskDto = await _taskApi.createTask(
        projectId: projectId,
        content: content,
      );
      return TaskResult$Success(data: TaskMapper.toTask(taskDto));
    } catch (e, s) {
      return TaskResult$Failure(e, s);
    }
  }

  @override
  Future<TaskResult<void>> deleteTask({required String id}) async {
    try {
      await _taskApi.deleteTask(
        id: id,
      );
      return const TaskResult$Success(data: null);
    } catch (e, s) {
      return TaskResult$Failure(e, s);
    }
  }

  @override
  Future<TaskResult<Task>> updateTask({
    required String id,
    int? priority,
    String? content,
    String? description,
  }) async {
    try {
      final taskDto = await _taskApi.updateTask(
        id: id,
        priority: priority,
        content: content,
        description: description,
      );
      final task = TaskMapper.toTask(taskDto);
      return TaskResult$Success(data: task);
    } catch (e, s) {
      return TaskResult$Failure(e, s);
    }
  }

  @override
  Future<TaskResult<Task>> updateTaskDueTime({
    required String id,
    required DateTime? dueTime,
    required DateTime? prevDueTime,
    required int? prevDuration,
  }) async {
    try {
      int? totalDuration;
      if (dueTime == null && prevDueTime != null) {
        final duration = DateTime.now().difference(prevDueTime).inMinutes;
        totalDuration = (prevDuration ?? 0) + duration;
      }
      final taskDto = await _taskApi.updateTaskDueTime(
        id: id,
        dueTime: dueTime?.toIso8601String(),
        duration: totalDuration,
      );

      final task = TaskMapper.toTask(taskDto);
      return TaskResult$Success(data: task);
    } catch (e, s) {
      return TaskResult$Failure(e, s);
    }
  }

  @override
  Future<TaskResult<List<CompleteTask>>> getCompleteTasks() async {
    try {
      final tasksJson = store.valueByKey(StoreKeys.completeTasks);

      if (tasksJson == null) return const TaskResult$Success(data: []);
      final List<dynamic> decodedList = jsonDecode(tasksJson);
      final tasks =
          decodedList.map((json) => CompleteTaskMapper.fromJson(json)).toList();
      return TaskResult$Success(data: tasks);
    } catch (e, s) {
      return TaskResult$Failure(e, s);
    }
  }

  Future<void> _addCompleteTask({required CompleteTask completeTask}) async {
    final tasksResult = await getCompleteTasks();
    switch (tasksResult) {
      case TaskResult$Success<List<CompleteTask>>():
        final tasks = [...tasksResult.data, completeTask];
        await _saveCompleteTasks(tasks);
      case TaskResult$Failure<List<CompleteTask>>():
        throw Exception(tasksResult.error);
    }
  }

  Future<void> _removeCompleteTask({required String taskId}) async {
    final tasksResult = await getCompleteTasks();
    switch (tasksResult) {
      case TaskResult$Success<List<CompleteTask>>():
        final tasks = tasksResult.data..removeWhere((e) => e.taskId == taskId);
        await _saveCompleteTasks(tasks);
      case TaskResult$Failure<List<CompleteTask>>():
        throw Exception(tasksResult.error);
    }
  }

  Future<void> _saveCompleteTasks(List<CompleteTask> tasks) async {
    final tasksJson = jsonEncode(
        tasks.map((task) => CompleteTaskMapper.toJson(task)).toList());

    await store.setString(StoreKeys.completeTasks, tasksJson);
  }

  @override
  Future<TaskResult<void>> completeTask({
    required String id,
    required int timestamp,
  }) async {
    try {
      await _addCompleteTask(
          completeTask: CompleteTask(
        completeTimestamp: timestamp,
        taskId: id,
      ));
      return const TaskResult$Success(data: null);
    } catch (e, s) {
      return TaskResult$Failure(e, s);
    }
  }

  @override
  Future<TaskResult<void>> reopenTask({required String id}) async {
    try {
      await _removeCompleteTask(taskId: id);
      return const TaskResult$Success(data: null);
    } catch (e, s) {
      return TaskResult$Failure(e, s);
    }
  }
}
