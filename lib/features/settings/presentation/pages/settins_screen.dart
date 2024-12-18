import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/core/ui/widgets/snackbars/error_snack_bar.dart';
import 'package:test_task_manager/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:test_task_manager/features/settings/presentation/bloc/theme_state.dart';
import 'package:test_task_manager/features/settings/presentation/model/theme_error.dart';
import 'package:test_task_manager/features/settings/presentation/widgets/language_widget.dart';
import 'package:test_task_manager/features/settings/presentation/widgets/theme_switch.dart';

@RoutePage()
class SettinsScreen extends StatelessWidget {
  const SettinsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.themeData.colorScheme.onSurface,
      appBar: AppBar(
        title: Text(
          context.tr(AppStrings.settings),
          style: context.themeData.textTheme.bodyLarge?.copyWith(
            color: context.themeData.colorScheme.primary,
          ),
        ),
      ),
      body: Center(
        child: BlocListener<ThemeBloc, ThemeState>(
          listener: (context, state) {
            if (state is! ThemeState$Error) {
              return;
            }
            final errorMessage = switch (state.error) {
              ThemeError$FailToGet() => AppStrings.failToGetTheme,
              ThemeError$FailToSet() => AppStrings.failToSetTheme,
            };
            ScaffoldMessenger.of(context).showSnackBar(
              ErrorSnackBar(context, text: context.tr(errorMessage)),
            );
          },
          child: Column(
            children: [
              SizedBox(height: 20.h),
              const LanguageWidget(),
              SizedBox(height: 20.h),
              const ThemeSwitch(),
            ],
          ),
        ),
      ),
    );
  }
}
