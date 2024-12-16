import 'package:test_task_manager/features/tasks/domain/entities/task.dart';
import 'package:test_task_manager/features/tasks/domain/entities/task_result.dart';

abstract interface class ITaskRepository {
  const ITaskRepository();

  Future<TaskResult<List<Task>>> getTasks();

  Future<TaskResult<Task>> createTask({
    required String projectId,
    required String content,
  });

  Future<TaskResult<Task>> updateTask({
    required String id,
    required int priority,
  });

  Future<TaskResult<void>> deleteTask({
    required String id,
  });
}
