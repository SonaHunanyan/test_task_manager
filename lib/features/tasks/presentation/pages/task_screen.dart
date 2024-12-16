import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/core/ui/widgets/buttons/primary_back_button.dart';
import 'package:test_task_manager/core/ui/widgets/buttons/primary_button.dart';
import 'package:test_task_manager/features/tasks/domain/entities/task.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_event.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_state.dart';
import 'package:test_task_manager/features/tasks/presentation/widgets/delete_task_button.dart';
import 'package:test_task_manager/features/tasks/presentation/widgets/editable_task_field.dart';

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
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contentController.text = _task.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.themeData.colorScheme.onSurface,
      appBar: AppBar(
        leading: const PrimaryBackButton(),
        leadingWidth: 100.w,
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
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PrimaryButton(
                      title: AppStrings.startTimer,
                      enabled: _task.due?.datetime == null,
                    ),
                    PrimaryButton(
                      title: AppStrings.stopTimer,
                      enabled: _task.due?.datetime != null,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                EditableTaskField(
                  title: AppStrings.content,
                  controller: _contentController,
                  onCancelEditing: () {
                    _contentController.text = _task.content;
                  },
                  onEdit: () {
                    context.read<TasksBloc>().add(TasksEvent$Update(
                        taskId: _task.id, content: _contentController.text));
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
