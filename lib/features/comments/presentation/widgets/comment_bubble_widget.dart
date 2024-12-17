import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/extenstions/date_time_extension.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/features/comments/domain/entities/comment.dart';

class CommentBubbleWidget extends StatelessWidget {
  const CommentBubbleWidget({
    required this.comment,
    super.key,
  });

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: context.themeData.colorScheme.secondary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            comment.content,
            style: context.themeData.textTheme.bodyMedium?.copyWith(
              color: context.themeData.colorScheme.primary,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          comment.postedAt.toCommentFormat(),
          style: context.themeData.textTheme.bodySmall?.copyWith(
            color: context.themeData.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
