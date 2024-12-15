import 'package:flutter/material.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';

enum TaskStatus {
  queue,
  inProgress,
  done,
}

extension TaskStatusExtention on TaskStatus {
  String get title => switch (this) {
        TaskStatus.queue => AppStrings.queue,
        TaskStatus.inProgress => AppStrings.inProgress,
        TaskStatus.done => AppStrings.done,
      };

  Color columnColor(BuildContext context) => switch (this) {
        TaskStatus.queue => context.themeData.secondaryHeaderColor,
        TaskStatus.inProgress => context.themeData.primaryColor,
        TaskStatus.done => context.themeData.primaryColorDark,
      };
}
