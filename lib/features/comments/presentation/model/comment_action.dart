import 'package:flutter/material.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/core/utils/data_picker_options.dart';

enum CommentAction with DataPickerOptions {
  update,
  delete;

  @override
  String toString() {
    switch (this) {
      case CommentAction.update:
        return AppStrings.update;
      case CommentAction.delete:
        return AppStrings.delete;
    }
  }

  @override
  Color? color(BuildContext context) => switch (this) {
        CommentAction.update => context.themeData.colorScheme.primary,
        CommentAction.delete => context.themeData.colorScheme.error,
      };

  @override
  Widget? icon(BuildContext context) => Icon(
        switch (this) {
          CommentAction.update => Icons.edit,
          CommentAction.delete => Icons.delete,
        },
        color: color(context),
      );
}
