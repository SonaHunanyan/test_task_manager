import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_manager/features/tasks/domain/entities/task.dart';
import 'package:test_task_manager/features/tasks/domain/entities/task_result.dart';
import 'package:test_task_manager/features/tasks/domain/repositories/task_repository.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_event.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_state.dart';
import 'package:test_task_manager/features/tasks/presentation/model/tasks_error.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc({required this.taskRepository})
      : super(const TasksState$Initial()) {
    on<TasksEvent>((event, emit) => switch (event) {
          TasksEvent$Get() => _get(event, emit),
          TasksEvent$CreateTask() => _create(event, emit),
          TasksEvent$Update() => _update(event, emit),
          TasksEvent$Delete() => _delete(event, emit),
        });

    add(const TasksEvent$Get());
  }

  final ITaskRepository taskRepository;

  Future<void> _get(TasksEvent$Get event, Emitter<TasksState> emit) async {
    emit(TasksState$Processing(tasks: state.tasks));
    final tasksResult = await taskRepository.getTasks();
    switch (tasksResult) {
      case TaskResult$Success<List<Task>>():
        emit(TasksState$Data(tasks: tasksResult.data));
      case TaskResult$Failure<List<Task>>():
        emit(TasksState$Error(
            tasks: state.tasks, error: const TasksError$FailToGet()));
    }
  }

  Future<void> _delete(
      TasksEvent$Delete event, Emitter<TasksState> emit) async {
    emit(TasksState$Loading(tasks: state.tasks));
    final tasks = state.tasks;
    tasks.removeWhere((e) => e.id == event.taskId);
    final deleteResult = await taskRepository.deleteTask(id: event.taskId);
    switch (deleteResult) {
      case TaskResult$Success<void>():
        emit(TasksState$Deleted(tasks: tasks));
      case TaskResult$Failure<void>():
        emit(TasksState$Error(
            tasks: state.tasks, error: const TasksError$FailToDelete()));
    }
  }

  Future<void> _create(
      TasksEvent$CreateTask event, Emitter<TasksState> emit) async {
    emit(TasksState$Processing(tasks: state.tasks));
    final taskResult = await taskRepository.createTask(
      projectId: event.projectId,
      content: event.content,
    );
    switch (taskResult) {
      case TaskResult$Success<Task>():
        final tasks = state.tasks..add(taskResult.data);
        emit(TasksState$Data(tasks: tasks));
      case TaskResult$Failure<Task>():
        emit(TasksState$Error(
            tasks: state.tasks, error: const TasksError$FailToCreate()));
    }
  }

  Future<void> _update(
      TasksEvent$Update event, Emitter<TasksState> emit) async {
    final initialTasks = [...state.tasks];
    final tasks = state.tasks;
    final index = tasks.indexWhere((e) => e.id == event.taskId);
    tasks[index] = tasks[index].copyWith(
      priority: event.priority,
      content: event.content,
      description: event.description,
    );
    emit(TasksState$Processing(tasks: tasks));
    final taskResult = await taskRepository.updateTask(
      id: event.taskId,
      priority: event.priority,
      content: event.content,
      description: event.description,
    );
    switch (taskResult) {
      case TaskResult$Success<Task>():
        emit(TasksState$Data(tasks: tasks));
      case TaskResult$Failure<Task>():
        emit(TasksState$Error(
            tasks: initialTasks, error: const TasksError$FailToUpdate()));
    }
  }
}
