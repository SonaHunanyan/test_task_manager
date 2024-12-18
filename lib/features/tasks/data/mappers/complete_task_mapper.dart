import 'package:test_task_manager/features/tasks/domain/entities/complete_task.dart';

class CompleteTaskMapper {
  static Map<String, dynamic> toJson(CompleteTask completeTask) {
    return {
      'completeTimestamp': completeTask.completeTimestamp,
      'taskId': completeTask.taskId,
    };
  }

  static CompleteTask fromJson(Map<String, dynamic> json) {
    return CompleteTask(
      completeTimestamp: json['completeTimestamp'],
      taskId: json['taskId'],
    );
  }
}
