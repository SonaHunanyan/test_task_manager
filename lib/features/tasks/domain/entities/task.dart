import 'package:equatable/equatable.dart';
import 'package:test_task_manager/features/tasks/domain/entities/due.dart';

class Task extends Equatable {
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
    this.duration,
  });
  final String id;
  final String content;
  final String description;
  final int commentCount;
  final bool isCompleted;
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
  final int? duration;

  @override
  List<Object?> get props => [id, due?.datetime, duration];

  Task copyWith({
    String? id,
    String? content,
    String? description,
    int? commentCount,
    bool? isCompleted,
    int? order,
    int? priority,
    String? projectId,
    List<String>? labels,
    Due? due,
    String? sectionId,
    String? parentId,
    String? creatorId,
    DateTime? createdAt,
    String? assigneeId,
    String? assignerId,
    int? duration,
  }) {
    return Task(
      id: id ?? this.id,
      content: content ?? this.content,
      description: description ?? this.description,
      commentCount: commentCount ?? this.commentCount,
      isCompleted: isCompleted ?? this.isCompleted,
      order: order ?? this.order,
      priority: priority ?? this.priority,
      projectId: projectId ?? this.projectId,
      labels: labels ?? this.labels,
      due: due ?? this.due,
      sectionId: sectionId ?? this.sectionId,
      parentId: parentId ?? this.parentId,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      assigneeId: assigneeId ?? this.assigneeId,
      assignerId: assignerId ?? this.assignerId,
      duration: duration ?? this.duration,
    );
  }

  int get realDuration =>
      (duration ?? 0) +
      DateTime.now().difference(due?.datetime ?? DateTime.now()).inMinutes;
}
