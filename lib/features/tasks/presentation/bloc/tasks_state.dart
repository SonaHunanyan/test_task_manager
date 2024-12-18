import 'package:collection/collection.dart';
import 'package:test_task_manager/features/tasks/domain/entities/complete_task.dart';
import 'package:test_task_manager/features/tasks/domain/entities/task.dart';
import 'package:test_task_manager/features/tasks/presentation/model/tasks_error.dart';

sealed class TasksState {
  const TasksState({
    this.tasks = const [],
    this.completeTasks = const [],
  });
  final List<Task> tasks;
  final List<CompleteTask> completeTasks;

  Task? taskById(String id) => tasks.firstWhereOrNull((e) => e.id == id);
}

class TasksState$Initial extends TasksState {
  const TasksState$Initial();
}

class TasksState$Processing extends TasksState {
  const TasksState$Processing({
    required super.tasks,
    required super.completeTasks,
  });
}

class TasksState$Data extends TasksState {
  const TasksState$Data({
    required super.tasks,
    required super.completeTasks,
  });
}

class TasksState$Error extends TasksState {
  const TasksState$Error({
    required super.tasks,
    required this.error,
    required super.completeTasks,
  });
  final TasksError error;
}

class TasksState$Deleted extends TasksState {
  const TasksState$Deleted({
    required super.tasks,
    required super.completeTasks,
  });
}

class TasksState$Loading extends TasksState {
  const TasksState$Loading({
    required super.tasks,
    required super.completeTasks,
  });
}
