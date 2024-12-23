import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/core/ui/widgets/buttons/primary_back_button.dart';
import 'package:test_task_manager/core/ui/widgets/buttons/primary_button.dart';
import 'package:test_task_manager/core/ui/widgets/loader/primary_loader.dart';
import 'package:test_task_manager/core/utils/validators.dart';
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
  Task? get _task => context.read<TasksBloc>().state.taskById(widget.taskId);
  final _contentController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contentController.text = _task?.content ?? '';
    _descriptionController.text = _task?.description ?? '';
  }

  @override
  void dispose() {
    _contentController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
            taskId: _task?.id ?? '',
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
            return const PrimaryLoader();
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Wrap(
                  spacing: 10.w,
                  runSpacing: 10.h,
                  children: [
                    PrimaryButton(
                      title: context.tr(AppStrings.startTimer),
                      enabled: _task?.due?.datetime == null,
                      onTap: () {
                        final task = _task;
                        if (task == null) {
                          return;
                        }
                        context.read<TasksBloc>().add(TaskEvent$UpdateDueTime(
                              taskId: task.id,
                              dateTime: DateTime.now(),
                            ));
                      },
                    ),
                    PrimaryButton(
                      title: context.tr(AppStrings.stopTimer),
                      enabled: _task?.due?.datetime != null,
                      onTap: () {
                        final task = _task;
                        if (task == null) {
                          return;
                        }
                        context.read<TasksBloc>().add(TaskEvent$UpdateDueTime(
                              taskId: task.id,
                              dateTime: null,
                            ));
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                EditableTaskField(
                  title: context.tr(AppStrings.content),
                  validator: (v) => Validator.required(context, v),
                  controller: _contentController,
                  onCancelEditing: () {
                    _contentController.text = _task?.content ?? '';
                  },
                  onEdit: () {
                    final task = _task;
                    if (task == null) {
                      return;
                    }
                    context.read<TasksBloc>().add(TasksEvent$Update(
                        taskId: task.id, content: _contentController.text));
                  },
                ),
                SizedBox(height: 20.h),
                EditableTaskField(
                  title: context.tr(AppStrings.description),
                  placeholder: context.tr(AppStrings.enterDescription),
                  controller: _descriptionController,
                  maxLines: null,
                  height: 100.h,
                  onCancelEditing: () {
                    _descriptionController.text = _task?.description ?? '';
                  },
                  onEdit: () {
                    final task = _task;
                    if (task == null) {
                      return;
                    }
                    context.read<TasksBloc>().add(TasksEvent$Update(
                        taskId: task.id,
                        description: _descriptionController.text));
                  },
                ),
                SizedBox(height: 20.h),
                Text(
                  '${context.tr(AppStrings.duration)}: ${_task?.realDuration.toDurationString(context)}',
                  style: context.themeData.textTheme.bodyLarge?.copyWith(
                    color: context.themeData.colorScheme.primary,
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

extension on int {
  String toDurationString(BuildContext context) {
    final days = this ~/ (24 * 60);
    final hours = (this % (24 * 60)) ~/ 60;
    final minutes = this % 60;

    final parts = <String>[];

    if (days > 0) parts.add(context.tr(AppStrings.daysTime(days)));
    if (hours > 0) parts.add(context.tr(AppStrings.hoursTime(hours)));
    if (minutes > 0 || parts.isEmpty) {
      parts.add(context.tr(AppStrings.minutesTime(minutes)));
    }

    final result = parts.join(', ');
    return result;
  }
}
