import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/core/ui/widgets/text_field/primary_text_field.dart';
import 'package:test_task_manager/features/comments/presentation/bloc/comments_bloc.dart';
import 'package:test_task_manager/features/comments/presentation/bloc/comments_event.dart';

class CommentsTextField extends StatefulWidget {
  const CommentsTextField({super.key});
  @override
  State<CommentsTextField> createState() => _CommentsTextFieldState();
}

class _CommentsTextFieldState extends State<CommentsTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryTextField(
            controller: _controller,
            placeholder: '${AppStrings.comment}...',
          ),
        ),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: () {
            if (_controller.text.isEmpty) {
              return;
            }
            context
                .read<CommentsBloc>()
                .add(CommentsEvent$Create(content: _controller.text));
          },
          child: Icon(
            Icons.send,
            color: context.themeData.colorScheme.secondary,
          ),
        )
      ],
    );
  }
}
