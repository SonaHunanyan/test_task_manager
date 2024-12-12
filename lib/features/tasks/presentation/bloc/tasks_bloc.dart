import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_manager/features/tasks/domain/entities/task.dart';
import 'package:test_task_manager/features/tasks/domain/entities/task_result.dart';
import 'package:test_task_manager/features/tasks/domain/repositories/task_repository.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_event.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc({required this.taskRepository}) : super(const TasksState()) {
    on<TasksEvent>((event, emit) => switch (event) {
          TasksEvent$Get() => _get(event, emit),
        });

    add(TasksEvent$Get());
  }

  final ITaskRepository taskRepository;

  Future<void> _get(TasksEvent$Get event, Emitter<TasksState> emit) async {
    final tasksResult = await taskRepository.getTasks();
    switch (tasksResult) {
      case TaskResult$Success<List<Task>>():
        emit(TasksState(tasks: tasksResult.data ?? []));
      case TaskResult$Failure<List<Task>>():
        emit(TasksState$FailToGet());
    }
  }
}
