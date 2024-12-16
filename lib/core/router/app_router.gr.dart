// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:test_task_manager/core/router/app_router.dart' as _i3;
import 'package:test_task_manager/features/home/presentation/pages/home_screen.dart'
    as _i1;
import 'package:test_task_manager/features/tasks/presentation/pages/task_screen.dart'
    as _i2;
import 'package:test_task_manager/features/tasks/presentation/pages/tasks_screen.dart'
    as _i4;

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomeScreen();
    },
  );
}

/// generated route for
/// [_i2.TaskScreen]
class TaskRoute extends _i5.PageRouteInfo<TaskRouteArgs> {
  TaskRoute({
    required String taskId,
    _i6.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          TaskRoute.name,
          args: TaskRouteArgs(
            taskId: taskId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'TaskRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TaskRouteArgs>();
      return _i2.TaskScreen(
        taskId: args.taskId,
        key: args.key,
      );
    },
  );
}

class TaskRouteArgs {
  const TaskRouteArgs({
    required this.taskId,
    this.key,
  });

  final String taskId;

  final _i6.Key? key;

  @override
  String toString() {
    return 'TaskRouteArgs{taskId: $taskId, key: $key}';
  }
}

/// generated route for
/// [_i3.TasksRouterPage]
class TasksRouter extends _i5.PageRouteInfo<void> {
  const TasksRouter({List<_i5.PageRouteInfo>? children})
      : super(
          TasksRouter.name,
          initialChildren: children,
        );

  static const String name = 'TasksRouter';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.TasksRouterPage();
    },
  );
}

/// generated route for
/// [_i4.TasksScreen]
class TasksRoute extends _i5.PageRouteInfo<void> {
  const TasksRoute({List<_i5.PageRouteInfo>? children})
      : super(
          TasksRoute.name,
          initialChildren: children,
        );

  static const String name = 'TasksRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.TasksScreen();
    },
  );
}
