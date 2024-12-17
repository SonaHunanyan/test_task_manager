import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/extenstions/date_time_extension.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/features/comments/domain/entities/comment.dart';
import 'package:test_task_manager/features/comments/presentation/widgets/comment_bubble_widget.dart';

class CommentItemWidget extends StatelessWidget {
  const CommentItemWidget({
    required this.comment,
    required this.prevCommentDate,
    super.key,
  });
  final Comment comment;
  final DateTime? prevCommentDate;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (prevCommentDate == null ||
            comment.postedAt.difference(prevCommentDate!).inDays > 0)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(
              comment.postedAt.toPrimaryFormat(),
              style: context.themeData.textTheme.bodyLarge
                  ?.copyWith(color: context.themeData.colorScheme.primary),
            ),
          ),
        CommentBubbleWidget(comment: comment)
      ],
    );
  }
}
