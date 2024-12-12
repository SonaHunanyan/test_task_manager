import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/core/ui/widgets/buttons/primary_button.dart';
import 'package:test_task_manager/core/ui/widgets/snackbars/error_snack_bar.dart';
import 'package:test_task_manager/features/tasks/domain/repositories/task_repository.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_state.dart';

@RoutePage()
class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  void _onAddTask() {}

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TasksBloc>(
      create: (context) =>
          TasksBloc(taskRepository: GetIt.I.get<ITaskRepository>()),
      child: BlocConsumer<TasksBloc, TasksState>(
        listener: (context, state) {
          if (state is TasksState$FailToGet) {
            ScaffoldMessenger.of(context).showSnackBar(
              ErrorSnackBar(context, text: AppStrings.failToGetTasks),
            );
          }
        },
        builder: (context, state) => Scaffold(
          backgroundColor: context.themeData.colorScheme.onSurface,
          appBar: AppBar(
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: PrimaryButton(
                  title: AppStrings.add,
                  onTap: _onAddTask,
                ),
              )
            ],
          ),
          body: Center(
            child: ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return Text(
                  task.content,
                  style: context.themeData.textTheme.bodyMedium?.copyWith(
                    color: context.themeData.colorScheme.primary,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
