import 'package:rest_api/rest_api.dart';
import 'package:test_task_manager/features/tasks/data/mappers/task_mapper.dart';
import 'package:test_task_manager/features/tasks/domain/entities/task.dart';
import 'package:test_task_manager/features/tasks/domain/entities/task_result.dart';
import 'package:test_task_manager/features/tasks/domain/repositories/task_repository.dart';

class TaskRepository implements ITaskRepository {
  const TaskRepository(this._taskApi);
  final TaskApi _taskApi;
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
}
