import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/di/di.dart';
import 'package:test_task_manager/core/router/app_router.dart';
import 'package:test_task_manager/core/theme/light_theme.dart';
import 'package:test_task_manager/core/utils/bloc_observer.dart';

class AppIntialize {
  static Future<void> execute() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    setupDependencies();
    Bloc.observer = AppBlocObserver();
    runApp(
      const TaskManagerApp(),
    );
  }
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter();
    return ScreenUtilInit(
      designSize: const Size(375, 813),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (_, __) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
        theme: lightTheme,
        routerConfig: router.config(),
      ),
    );
  }
}
