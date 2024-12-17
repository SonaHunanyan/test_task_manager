// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  const Comment({
    required this.content,
    required this.id,
    required this.postedAt,
    required this.taskId,
    this.projectId,
  });

  final String content;
  final String id;
  final DateTime postedAt;
  final String? projectId;
  final String taskId;

  factory Comment.fake({required String content, required String taskId}) {
    return Comment(
      content: content,
      id: '${DateTime.now().microsecondsSinceEpoch}',
      postedAt: DateTime.now(),
      taskId: taskId,
    );
  }

  Comment copyWith({
    String? content,
    String? id,
    DateTime? postedAt,
    String? projectId,
    String? taskId,
  }) =>
      Comment(
        content: content ?? this.content,
        id: id ?? this.id,
        postedAt: postedAt ?? this.postedAt,
        taskId: taskId ?? this.taskId,
      );

  @override
  List<Object?> get props => [id];
}
