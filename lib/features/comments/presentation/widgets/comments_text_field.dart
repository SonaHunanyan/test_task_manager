import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/core/ui/widgets/text_field/primary_text_field.dart';
import 'package:test_task_manager/features/comments/domain/entities/comment.dart';
import 'package:test_task_manager/features/comments/presentation/bloc/comments_bloc.dart';
import 'package:test_task_manager/features/comments/presentation/bloc/comments_event.dart';

class CommentsTextField extends StatelessWidget {
  const CommentsTextField({
    required this.controller,
    required this.editableComment,
    super.key,
  });
  final TextEditingController controller;
  final ValueNotifier<Comment?> editableComment;

  void _onSend(BuildContext context) {
    final text = controller.text;
    if (text.isEmpty) {
      return;
    }
    final editableCommentValue = editableComment.value;
    controller.clear();
    if (editableCommentValue != null) {
      context.read<CommentsBloc>().add(CommentsEvent$Update(
            content: text,
            commentId: editableCommentValue.id,
          ));
      editableComment.value = null;
      return;
    }
    context.read<CommentsBloc>().add(CommentsEvent$Create(content: text));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: editableComment,
          builder: (context, value, child) => Expanded(
            child: PrimaryTextField(
              controller: controller,
              placeholder: '${context.tr(AppStrings.comment)}...',
              suffix: value == null
                  ? const SizedBox()
                  : GestureDetector(
                      onTap: () {
                        editableComment.value = null;
                        controller.clear();
                      },
                      child: Icon(
                        Icons.close,
                        color: context.themeData.colorScheme.error,
                      ),
                    ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: () => _onSend(context),
          child: Icon(
            Icons.send,
            color: context.themeData.colorScheme.secondary,
          ),
        )
      ],
    );
  }
}
