import 'package:test_task_manager/features/tasks/domain/entities/due.dart';

class Task {
  const Task({
    required this.id,
    required this.content,
    required this.description,
    required this.commentCount,
    required this.isCompleted,
    required this.order,
    required this.priority,
    required this.projectId,
    required this.labels,
    required this.creatorId,
    required this.createdAt,
    this.due,
    this.sectionId,
    this.parentId,
    this.assigneeId,
    this.assignerId,
  });
  final String id;
  final String content;
  final String description;
  final int commentCount;
  final int isCompleted;
  final int order;
  final int priority;
  final String projectId;
  final List<String> labels;
  final Due? due;
  final String? sectionId;
  final String? parentId;
  final String creatorId;
  final DateTime createdAt;
  final String? assigneeId;
  final String? assignerId;
}
