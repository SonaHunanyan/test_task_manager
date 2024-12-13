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
