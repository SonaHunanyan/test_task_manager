import 'package:equatable/equatable.dart';
import 'package:test_task_manager/features/tasks/domain/entities/task.dart';

class TasksState extends Equatable {
  const TasksState({this.tasks = const []});
  final List<Task> tasks;

  @override
  List<Object?> get props => tasks;
}

class TasksState$FailToGet extends TasksState {
  const TasksState$FailToGet();
}

class TasksState$FailToCreate extends TasksState {
  const TasksState$FailToCreate({required super.tasks});
}
