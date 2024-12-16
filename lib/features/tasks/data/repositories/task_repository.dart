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
  Future<TaskResult<Task>> updateTask(
      {required String id, required int priority}) async {
    try {
      final taskDto = await _taskApi.updateTask(
        id: id,
        priority: priority,
      );
      final task = TaskMapper.toTask(taskDto);
      return TaskResult$Success(data: task);
    } catch (e, s) {
      return TaskResult$Failure(e, s);
    }
  }
}
