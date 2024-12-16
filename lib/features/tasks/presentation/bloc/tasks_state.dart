import 'package:test_task_manager/features/tasks/domain/entities/task.dart';
import 'package:test_task_manager/features/tasks/presentation/model/tasks_error.dart';

sealed class TasksState {
  const TasksState({this.tasks = const []});
  final List<Task> tasks;

  Task taskById(String id) => tasks.firstWhere((e) => e.id == id);
}

class TasksState$Initial extends TasksState {
  const TasksState$Initial();
}

class TasksState$Processing extends TasksState {
  const TasksState$Processing({required super.tasks});
}

class TasksState$Data extends TasksState {
  const TasksState$Data({required super.tasks});
}

class TasksState$Error extends TasksState {
  const TasksState$Error({required super.tasks, required this.error});
  final TasksError error;
}

class TasksState$Deleted extends TasksState {
  const TasksState$Deleted({required super.tasks});
}

class TasksState$Loading extends TasksState {
  const TasksState$Loading({required super.tasks});
}
