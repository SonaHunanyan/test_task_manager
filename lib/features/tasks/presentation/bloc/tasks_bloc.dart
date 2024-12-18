import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_manager/features/tasks/domain/entities/complete_task.dart';
import 'package:test_task_manager/features/tasks/domain/entities/due.dart';
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
          TaskEvent$UpdateDueTime() => _updateDueTime(event, emit),
          TasksEvent$IncreaseCommentsCount() =>
            _increaseCommentsCount(event, emit),
          TasksEvent$GetCompleteTasks() => _getCompleteTasks(event, emit),
          TasksEvent$UpdateCompleteStatus() =>
            _updateCompleteStatus(event, emit),
        });

    add(const TasksEvent$Get());
    add(const TasksEvent$GetCompleteTasks());
  }

  final ITaskRepository taskRepository;

  Future<void> _increaseCommentsCount(
      TasksEvent$IncreaseCommentsCount event, Emitter<TasksState> emit) async {
    emit(TasksState$Processing(
      tasks: state.tasks,
      completeTasks: state.completeTasks,
    ));
    final index = state.tasks.indexWhere((e) => e.id == event.taskId);
    final task = state.tasks[index];
    state.tasks[index] = task.copyWith(commentCount: task.commentCount + 1);
    emit(TasksState$Data(
      tasks: state.tasks,
      completeTasks: state.completeTasks,
    ));
  }

  Future<void> _getCompleteTasks(
      TasksEvent$GetCompleteTasks event, Emitter<TasksState> emit) async {
    emit(TasksState$Loading(
      tasks: state.tasks,
      completeTasks: state.completeTasks,
    ));
    final completeTasksResult = await taskRepository.getCompleteTasks();
    if (completeTasksResult is TaskResult$Success<List<CompleteTask>>) {
      emit(TasksState$Data(
        tasks: state.tasks,
        completeTasks: completeTasksResult.data,
      ));
    }
  }

  Future<void> _get(TasksEvent$Get event, Emitter<TasksState> emit) async {
    emit(TasksState$Loading(
      tasks: state.tasks,
      completeTasks: state.completeTasks,
    ));

    final tasksResult = await taskRepository.getTasks();
    switch (tasksResult) {
      case TaskResult$Success<List<Task>>():
        emit(TasksState$Data(
          tasks: tasksResult.data,
          completeTasks: state.completeTasks,
        ));
      case TaskResult$Failure<List<Task>>():
        emit(TasksState$Error(
          tasks: state.tasks,
          error: const TasksError$FailToGet(),
          completeTasks: state.completeTasks,
        ));
    }
  }

  Future<void> _delete(
      TasksEvent$Delete event, Emitter<TasksState> emit) async {
    emit(TasksState$Loading(
      tasks: state.tasks,
      completeTasks: state.completeTasks,
    ));
    final tasks = state.tasks;
    tasks.removeWhere((e) => e.id == event.taskId);
    final deleteResult = await taskRepository.deleteTask(id: event.taskId);
    switch (deleteResult) {
      case TaskResult$Success<void>():
        emit(TasksState$Deleted(
          tasks: tasks,
          completeTasks: state.completeTasks,
        ));
      case TaskResult$Failure<void>():
        emit(TasksState$Error(
          tasks: state.tasks,
          error: const TasksError$FailToDelete(),
          completeTasks: state.completeTasks,
        ));
    }
  }

  Future<void> _create(
      TasksEvent$CreateTask event, Emitter<TasksState> emit) async {
    emit(TasksState$Processing(
      tasks: state.tasks,
      completeTasks: state.completeTasks,
    ));
    final taskResult = await taskRepository.createTask(
      projectId: event.projectId,
      content: event.content,
    );
    switch (taskResult) {
      case TaskResult$Success<Task>():
        final tasks = state.tasks..add(taskResult.data);
        emit(TasksState$Data(
          tasks: tasks,
          completeTasks: state.completeTasks,
        ));
      case TaskResult$Failure<Task>():
        emit(TasksState$Error(
          tasks: state.tasks,
          error: const TasksError$FailToCreate(),
          completeTasks: state.completeTasks,
        ));
    }
  }

  Future<void> _update(
      TasksEvent$Update event, Emitter<TasksState> emit) async {
    final initialTasks = [...state.tasks];
    final tasks = state.tasks;
    final index = tasks.indexWhere((e) => e.id == event.taskId);
    final task = tasks[index];
    final prevPriority = task.priority;
    tasks[index] = task.copyWith(
      priority: event.priority,
      content: event.content,
      description: event.description,
    );
    emit(TasksState$Processing(
      tasks: tasks,
      completeTasks: state.completeTasks,
    ));
    final taskResult = await taskRepository.updateTask(
      id: event.taskId,
      priority: event.priority,
      content: event.content,
      description: event.description,
    );
    switch (taskResult) {
      case TaskResult$Success<Task>():
        final priority = event.priority;
        if (priority != null) {
          add(TasksEvent$UpdateCompleteStatus(
              prevPriority: prevPriority,
              priority: priority,
              taskId: event.taskId));
        }
        emit(TasksState$Data(
          tasks: tasks,
          completeTasks: state.completeTasks,
        ));
      case TaskResult$Failure<Task>():
        emit(TasksState$Error(
          tasks: initialTasks,
          error: const TasksError$FailToUpdate(),
          completeTasks: state.completeTasks,
        ));
    }
  }

  Future<void> _updateCompleteStatus(
      TasksEvent$UpdateCompleteStatus event, Emitter<TasksState> emit) async {
    if (event.priority == 3) {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final completeTask =
          CompleteTask(completeTimestamp: timestamp, taskId: event.taskId);
      await taskRepository.completeTask(id: event.taskId, timestamp: timestamp);
      final completeTasks = [...state.completeTasks, completeTask];
      emit(TasksState$Data(tasks: state.tasks, completeTasks: completeTasks));
      return;
    }
    if (event.prevPriority == 3) {
      final completeTasks = state.completeTasks;
      completeTasks.removeWhere((e) => e.taskId == event.taskId);
      await taskRepository.reopenTask(id: event.taskId);
      emit(TasksState$Data(tasks: state.tasks, completeTasks: completeTasks));
    }
  }

  Future<void> _updateDueTime(
      TaskEvent$UpdateDueTime event, Emitter<TasksState> emit) async {
    final initialTasks = [...state.tasks];
    final tasks = state.tasks;
    final index = tasks.indexWhere((e) => e.id == event.taskId);
    final task = tasks[index];
    final prevDueTime = task.due?.datetime;
    final due = task.due;
    tasks[index] = task.copyWith(
      due: due == null
          ? Due(datetime: event.dateTime)
          : due.copyWith(
              datetime: () => event.dateTime,
            ),
      duration: task.realDuration,
    );

    emit(TasksState$Processing(
      tasks: tasks,
      completeTasks: state.completeTasks,
    ));
    final taskResult = await taskRepository.updateTaskDueTime(
      id: event.taskId,
      dueTime: event.dateTime,
      prevDueTime: prevDueTime,
      prevDuration: task.duration,
    );
    switch (taskResult) {
      case TaskResult$Success<Task>():
        emit(TasksState$Data(
          tasks: tasks,
          completeTasks: state.completeTasks,
        ));
      case TaskResult$Failure<Task>():
        emit(TasksState$Error(
          tasks: initialTasks,
          error: const TasksError$FailToUpdate(),
          completeTasks: state.completeTasks,
        ));
    }
  }
}
