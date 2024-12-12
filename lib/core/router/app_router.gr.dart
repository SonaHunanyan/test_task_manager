// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:test_task_manager/core/router/app_router.dart' as _i2;
import 'package:test_task_manager/features/home/presentation/pages/home_screen.dart'
    as _i1;
import 'package:test_task_manager/features/tasks/presentation/pages/tasks_screen.dart'
    as _i3;

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomeScreen();
    },
  );
}

/// generated route for
/// [_i2.TasksRouterPage]
class TasksRouter extends _i4.PageRouteInfo<void> {
  const TasksRouter({List<_i4.PageRouteInfo>? children})
      : super(
          TasksRouter.name,
          initialChildren: children,
        );

  static const String name = 'TasksRouter';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.TasksRouterPage();
    },
  );
}

/// generated route for
/// [_i3.TasksScreen]
class TasksRoute extends _i4.PageRouteInfo<void> {
  const TasksRoute({List<_i4.PageRouteInfo>? children})
      : super(
          TasksRoute.name,
          initialChildren: children,
        );

  static const String name = 'TasksRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.TasksScreen();
    },
  );
}
