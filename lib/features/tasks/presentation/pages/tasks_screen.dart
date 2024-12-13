import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/core/ui/widgets/buttons/primary_button.dart';
import 'package:test_task_manager/core/ui/widgets/snackbars/error_snack_bar.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_state.dart';
import 'package:test_task_manager/features/tasks/presentation/widgets/create_task_widget.dart';

@RoutePage()
class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  void _onAddTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) => const CreateTaskWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksState>(
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
                onTap: () => _onAddTask(context),
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
    );
  }
}
