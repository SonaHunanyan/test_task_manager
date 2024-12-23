import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:storage/storage.dart';
import 'package:test_task_manager/core/constants/constants.dart';
import 'package:test_task_manager/core/constants/localization.dart';
import 'package:test_task_manager/core/di/di.dart';
import 'package:test_task_manager/core/router/app_router.dart';
import 'package:test_task_manager/core/utils/bloc_observer.dart';
import 'package:test_task_manager/features/settings/domain/repositories/theme_repository.dart';
import 'package:test_task_manager/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:test_task_manager/features/settings/presentation/bloc/theme_state.dart';
import 'package:test_task_manager/features/settings/presentation/model/theme.dart';

class AppIntialize {
  static Future<void> execute() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    setupDependencies();
    await GetIt.I.get<Store>().init();
    Bloc.observer = AppBlocObserver();
    runApp(
      EasyLocalization(
        supportedLocales: AppLocalization.supportedLocales,
        path: Constants.localizattionPath,
        fallbackLocale: AppLocalization.supportedLocales.first,
        child: const TaskManagerApp(),
      ),
    );
  }
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter();
    return BlocProvider<ThemeBloc>(
      create: (context) =>
          ThemeBloc(themeRepository: GetIt.I.get<IThemeRepository>()),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) => ScreenUtilInit(
          designSize: const Size(375, 813),
          minTextAdapt: true,
          splitScreenMode: true,
          useInheritedMediaQuery: true,
          builder: (_, __) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
            theme: state.themeType.themeData,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            routerConfig: router.config(),
          ),
        ),
      ),
    );
  }
}
