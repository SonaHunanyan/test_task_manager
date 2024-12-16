import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/core/ui/widgets/buttons/primary_back_button.dart';
import 'package:test_task_manager/features/tasks/domain/entities/task.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_state.dart';
import 'package:test_task_manager/features/tasks/presentation/widgets/delete_task_button.dart';

@RoutePage()
class TaskScreen extends StatefulWidget {
  const TaskScreen({
    required this.taskId,
    super.key,
  });
  final String taskId;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  Task get _task => context.read<TasksBloc>().state.taskById(widget.taskId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.themeData.colorScheme.onSurface,
      appBar: AppBar(
        leading: const PrimaryBackButton(),
        leadingWidth: 100.w,
        title: Text(
          _task.content,
          style: context.themeData.textTheme.bodyLarge
              ?.copyWith(color: context.themeData.colorScheme.primary),
        ),
        actions: [
          DeleteTaskButton(
            taskId: _task.id,
          )
        ],
      ),
      body: Center(
        child: BlocConsumer<TasksBloc, TasksState>(listener: (context, state) {
          if (state is TasksState$Deleted) {
            context.router.back();
            return;
          }
        }, builder: (context, state) {
          if (state is TasksState$Loading) {
            return LoadingAnimationWidget.progressiveDots(
              color: context.themeData.colorScheme.secondary,
              size: 100.w,
            );
          }
          return Text(
            widget.taskId,
            style: TextStyle(color: Colors.black),
          );
        }),
      ),
    );
  }
}
