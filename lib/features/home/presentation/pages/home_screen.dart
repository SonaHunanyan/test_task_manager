import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/core/router/app_router.gr.dart';
import 'package:test_task_manager/features/tasks/domain/repositories/task_repository.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_bloc.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final routes = const [
    TasksRouter(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TasksBloc>(
      create: (context) =>
          TasksBloc(taskRepository: GetIt.I.get<ITaskRepository>()),
      child: AutoTabsScaffold(
        routes: routes,
        bottomNavigationBuilder: (context, tabsRouter) => BottomNavigationBar(
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
          iconSize: 0,
          backgroundColor: context.themeData.primaryColorLight,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: tabsRouter.activeIndex,
          onTap: (index) {
            tabsRouter.setActiveIndex.call(index);
          },
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: _BottomBarItem(
                icon: Icons.task,
                isSelected: false,
                label: AppStrings.tasks,
              ),
              activeIcon: _BottomBarItem(
                icon: Icons.task,
                isSelected: true,
                label: AppStrings.tasks,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: _BottomBarItem(
                icon: Icons.task,
                isSelected: false,
                label: AppStrings.tasks,
              ),
              activeIcon: _BottomBarItem(
                icon: Icons.task,
                isSelected: true,
                label: AppStrings.tasks,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  const _BottomBarItem({
    required this.icon,
    required this.isSelected,
    required this.label,
  });
  final IconData icon;
  final bool isSelected;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.h,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? context.themeData.colorScheme.primaryContainer
                  : Colors.transparent,
            ),
            child: Icon(
              icon,
              size: 18.h,
              color: isSelected
                  ? context.themeData.colorScheme.primary
                  : context.themeData.colorScheme.secondaryFixed,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: context.themeData.textTheme.bodySmall?.copyWith(
              color: isSelected
                  ? context.themeData.colorScheme.primary
                  : context.themeData.colorScheme.secondaryFixed,
            ),
          )
        ],
      ),
    );
  }
}
