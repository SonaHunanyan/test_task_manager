import 'package:test_task_manager/features/tasks/domain/entities/task.dart';
import 'package:test_task_manager/features/tasks/domain/entities/task_result.dart';

abstract interface class ITaskRepository {
  const ITaskRepository();

  Future<TaskResult<List<Task>>> getTasks();
}