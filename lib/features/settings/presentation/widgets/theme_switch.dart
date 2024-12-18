import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:test_task_manager/features/settings/presentation/bloc/theme_event.dart';
import 'package:test_task_manager/features/settings/presentation/bloc/theme_state.dart';
import 'package:test_task_manager/features/settings/presentation/model/theme.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.tr(AppStrings.darkMode),
            style: context.themeData.textTheme.bodyLarge
                ?.copyWith(color: context.themeData.colorScheme.primary),
          ),
          SizedBox(width: 20.w),
          CupertinoSwitch(
            thumbColor: context.themeData.colorScheme.secondaryFixed,
            trackColor: context.themeData.disabledColor,
            value: state.themeType.isDark,
            onChanged: (v) {
              context.read<ThemeBloc>().add(
                    ThemeEvent$Set(
                        themeType: switch (v) {
                      true => ThemeType.dark,
                      false => ThemeType.light,
                    }),
                  );
            },
            activeColor: context.themeData.colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}
