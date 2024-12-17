import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/extenstions/date_time_extension.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/core/ui/widgets/data_picker/primary_data_picker.dart';
import 'package:test_task_manager/features/comments/domain/entities/comment.dart';
import 'package:test_task_manager/features/comments/presentation/bloc/comments_bloc.dart';
import 'package:test_task_manager/features/comments/presentation/bloc/comments_event.dart';
import 'package:test_task_manager/features/comments/presentation/model/comment_action.dart';
import 'package:test_task_manager/features/comments/presentation/widgets/comment_bubble_widget.dart';

class CommentItemWidget extends StatelessWidget {
  const CommentItemWidget({
    required this.comment,
    required this.prevCommentDate,
    required this.onEdit,
    super.key,
  });
  final Comment comment;
  final DateTime? prevCommentDate;
  final VoidCallback onEdit;
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
        GestureDetector(
          onLongPressDown: (details) {
            final commentsBloc = context.read<CommentsBloc>();
            showModalBottomSheet(
                context: context,
                useRootNavigator: true,
                builder: (context) {
                  return PrimaryDataPicker<CommentAction>(
                    onPick: (item) {
                      switch (item) {
                        case CommentAction.update:
                          onEdit();
                        case CommentAction.delete:
                          commentsBloc
                              .add(CommentsEvent$Delete(commentId: comment.id));
                      }
                    },
                    items: CommentAction.values,
                  );
                });
          },
          child: CommentBubbleWidget(comment: comment),
        )
      ],
    );
  }
}
