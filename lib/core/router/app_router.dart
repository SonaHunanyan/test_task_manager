import 'package:auto_route/auto_route.dart';
import 'package:test_task_manager/core/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(initial: true, page: HomeRoute.page, children: [
          AutoRoute(
            initial: true,
            page: TasksRouter.page,
            children: [
              AutoRoute(
                initial: true,
                page: TasksRoute.page,
              ),
            ],
          ),
        ]),
      ];
}

@RoutePage(name: 'TasksRouter')
class TasksRouterPage extends AutoRouter {
  const TasksRouterPage({super.key});
}
