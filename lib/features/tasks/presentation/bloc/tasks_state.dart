import 'package:test_task_manager/features/tasks/domain/entities/task.dart';

sealed class TasksState {
  const TasksState({this.tasks = const []});
  final List<Task> tasks;
}

class TasksState$Initial extends TasksState {
  const TasksState$Initial();
}

class TasksState$Loading extends TasksState {
  const TasksState$Loading({required super.tasks});
}

class TasksState$Data extends TasksState {
  const TasksState$Data({required super.tasks});
}

class TasksState$FailToGet extends TasksState {
  const TasksState$FailToGet();
}

class TasksState$FailToCreate extends TasksState {
  const TasksState$FailToCreate({required super.tasks});
}

class TasksState$FailToUpdate extends TasksState {
  const TasksState$FailToUpdate({required super.tasks});
}
