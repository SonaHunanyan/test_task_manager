import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_manager/features/tasks/domain/entities/task.dart';
import 'package:test_task_manager/features/tasks/domain/entities/task_result.dart';
import 'package:test_task_manager/features/tasks/domain/repositories/task_repository.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_event.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc({required this.taskRepository})
      : super(const TasksState$Initial()) {
    on<TasksEvent>((event, emit) => switch (event) {
          TasksEvent$Get() => _get(event, emit),
          TasksEvent$CreateTask() => _create(event, emit),
        });

    add(const TasksEvent$Get());
  }

  final ITaskRepository taskRepository;

  Future<void> _get(TasksEvent$Get event, Emitter<TasksState> emit) async {
    emit(TasksState$Loading(tasks: state.tasks));
    final tasksResult = await taskRepository.getTasks();
    switch (tasksResult) {
      case TaskResult$Success<List<Task>>():
        emit(TasksState$Data(tasks: tasksResult.data));
      case TaskResult$Failure<List<Task>>():
        emit(const TasksState$FailToGet());
    }
  }

  Future<void> _create(
      TasksEvent$CreateTask event, Emitter<TasksState> emit) async {
    emit(TasksState$Loading(tasks: state.tasks));
    final taskResult = await taskRepository.createTask(
      projectId: event.projectId,
      content: event.content,
    );
    switch (taskResult) {
      case TaskResult$Success<Task>():
        final tasks = state.tasks..add(taskResult.data);
        emit(TasksState$Data(tasks: tasks));
      case TaskResult$Failure<Task>():
        emit(TasksState$FailToCreate(tasks: state.tasks));
    }
  }
}
