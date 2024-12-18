import 'package:test_task_manager/features/tasks/domain/entities/complete_task.dart';
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
    int? priority,
    String? content,
    String? description,
  });

  Future<TaskResult<void>> deleteTask({
    required String id,
  });
  Future<TaskResult<Task>> updateTaskDueTime({
    required String id,
    required DateTime? dueTime,
    required DateTime? prevDueTime,
    required int? prevDuration,
  });

  Future<TaskResult<List<CompleteTask>>> getCompleteTasks();
  Future<TaskResult<void>> completeTask({
    required String id,
    required int timestamp,
  });
  Future<TaskResult<void>> reopenTask({required String id});
}
