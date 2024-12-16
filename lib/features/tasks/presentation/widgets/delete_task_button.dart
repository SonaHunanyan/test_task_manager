import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_event.dart';

class DeleteTaskButton extends StatelessWidget {
  const DeleteTaskButton({required this.taskId, super.key});
  final String taskId;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: GestureDetector(
        onTap: () {
          context.read<TasksBloc>().add(TasksEvent$Delete(taskId: taskId));
        },
        child: Icon(
          Icons.delete,
          color: context.themeData.colorScheme.error,
        ),
      ),
    );
  }
}
