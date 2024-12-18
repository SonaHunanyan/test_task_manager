import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/core/ui/widgets/buttons/primary_button.dart';
import 'package:test_task_manager/core/ui/widgets/data_picker/primary_data_picker.dart';
import 'package:test_task_manager/core/ui/widgets/loader/primary_loader.dart';
import 'package:test_task_manager/core/ui/widgets/snackbars/error_snack_bar.dart';
import 'package:test_task_manager/features/projects/presentation/bloc/projects_bloc.dart';
import 'package:test_task_manager/features/projects/presentation/widgets/create_project_widget.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_event.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_state.dart';
import 'package:test_task_manager/features/tasks/presentation/model/main_entity.dart';
import 'package:test_task_manager/features/tasks/presentation/model/tasks_error.dart';
import 'package:test_task_manager/features/tasks/presentation/widgets/create_task_widget.dart';
import 'package:test_task_manager/features/tasks/presentation/widgets/kanban_widget.dart';

@RoutePage()
class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  void _showItemPicker(BuildContext context) {
    final projectsBloc = context.read<ProjectsBloc>();
    final tasksBloc = context.read<TasksBloc>();
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return PrimaryDataPicker<MainEntity>(
            onPick: (item) {
              showModalBottomSheet(
                context: context,
                useRootNavigator: true,
                builder: (context) => switch (item) {
                  MainEntity.task => BlocProvider<ProjectsBloc>(
                      create: (_) => projectsBloc,
                      child: CreateTaskWidget(
                        onCreate: (projectId, content) {
                          tasksBloc.add(TasksEvent$CreateTask(
                              content: content, projectId: projectId));
                        },
                      ),
                    ),
                  MainEntity.project => BlocProvider<ProjectsBloc>(
                      create: (_) => projectsBloc,
                      child: const CreateProjectWidget(),
                    ),
                },
              );
            },
            items: MainEntity.values);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.themeData.colorScheme.onSurface,
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: PrimaryButton(
              title: context.tr(AppStrings.add),
              onTap: () => _showItemPicker(context),
            ),
          )
        ],
      ),
      body: Center(
        child: BlocConsumer<TasksBloc, TasksState>(
          listener: (context, state) {
            if (state is! TasksState$Error) {
              return;
            }
            final errorMessage = switch (state.error) {
              TasksError$FailToCreate() => AppStrings.failToCreateTask,
              TasksError$FailToGet() => AppStrings.failToGetTasks,
              TasksError$FailToUpdate() => AppStrings.failToUpdateTask,
              TasksError$FailToDelete() => AppStrings.failToDeleteTask,
            };
            ScaffoldMessenger.of(context).showSnackBar(
              ErrorSnackBar(context, text: context.tr(errorMessage)),
            );
          },
          builder: (context, state) {
            if (state is TasksState$Loading) {
              return const PrimaryLoader();
            }
            return const KanbanWidget();
          },
        ),
      ),
    );
  }
}
