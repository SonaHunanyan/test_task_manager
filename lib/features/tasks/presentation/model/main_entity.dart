import 'package:flutter/material.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/core/utils/data_picker_options.dart';

enum MainEntity with DataPickerOptions {
  task,
  project;

  @override
  String toString() {
    switch (this) {
      case MainEntity.task:
        return AppStrings.task;
      case MainEntity.project:
        return AppStrings.project;
    }
  }

  @override
  Color? color(BuildContext context) => context.themeData.colorScheme.primary;

  @override
  Widget? icon(BuildContext context) => Icon(
        Icons.check_circle_outline,
        color: color(context),
      );
}
