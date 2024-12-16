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
    required this.priority,
  });
  final String taskId;
  final int priority;
}

class TasksEvent$Delete extends TasksEvent {
  const TasksEvent$Delete({required this.taskId});
  final String taskId;
}
