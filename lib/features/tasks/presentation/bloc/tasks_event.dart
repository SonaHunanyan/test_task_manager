sealed class TasksEvent {
  const TasksEvent();
}

class TasksEvent$Get extends TasksEvent {
  const TasksEvent$Get();
}

class TasksEvent$CreateTask extends TasksEvent {
  const TasksEvent$CreateTask({
    required this.projectId,
    required this.content,
  });
  final String projectId;
  final String content;
}

class TasksEvent$Update extends TasksEvent {
  const TasksEvent$Update({
    required this.taskId,
    this.priority,
    this.content,
    this.description,
  });
  final String taskId;
  final int? priority;
  final String? content;
  final String? description;
}

class TasksEvent$Delete extends TasksEvent {
  const TasksEvent$Delete({required this.taskId});
  final String taskId;
}

class TaskEvent$UpdateDueTime extends TasksEvent {
  const TaskEvent$UpdateDueTime({
    required this.dateTime,
    required this.taskId,
  });
  final String taskId;
  final DateTime? dateTime;
}

class TasksEvent$IncreaseCommentsCount extends TasksEvent {
  const TasksEvent$IncreaseCommentsCount({required this.taskId});
  final String taskId;
}

class TasksEvent$GetCompleteTasks extends TasksEvent {
  const TasksEvent$GetCompleteTasks();
}

class TasksEvent$UpdateCompleteStatus extends TasksEvent {
  const TasksEvent$UpdateCompleteStatus({
    required this.prevPriority,
    required this.priority,
    required this.taskId,
  });
  final int priority;
  final int prevPriority;
  final String taskId;
}
