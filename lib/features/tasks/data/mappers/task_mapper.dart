import 'package:rest_api/rest_api.dart';
import 'package:test_task_manager/features/tasks/data/mappers/due_mapper.dart';
import 'package:test_task_manager/features/tasks/domain/entities/task.dart';

class TaskMapper {
  static Task toTask(TaskDto dto) {
    final due = dto.due;
    return Task(
      id: dto.id,
      content: dto.content,
      description: dto.description,
      commentCount: dto.commentCount,
      isCompleted: dto.isCompleted,
      order: dto.order,
      priority: dto.priority,
      projectId: dto.projectId,
      labels: dto.labels,
      creatorId: dto.creatorId,
      createdAt: dto.createdAt,
      due: due == null ? null : DueMapper.toDue(due),
      sectionId: dto.sectionId,
      parentId: dto.parentId,
      assigneeId: dto.assigneeId,
      assignerId: dto.assignerId,
    );
  }

  static List<Task> toTasks(List<TaskDto> dtos) {
    return dtos.map(toTask).toList();
  }
}
