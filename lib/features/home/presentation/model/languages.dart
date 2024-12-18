import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/extenstions/string_extension.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/core/utils/data_picker_options.dart';

enum Languages with DataPickerOptions {
  ru,
  en;

  @override
  String toString() {
    return '${AppStrings.supportedLanguages}.$name';
  }

  Locale get locale => Locale(name);

  @override
  Color? color(BuildContext context) => context.themeData.colorScheme.primary;

  @override
  Widget? icon(BuildContext context) => Text(
        context.tr('${AppStrings.supportedFalgs}.$name').toFlagEmojy(),
        style: context.themeData.textTheme.headlineSmall,
      );
}
