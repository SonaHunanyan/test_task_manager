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
}
