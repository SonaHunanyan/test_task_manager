import 'package:flutter/material.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';

class PrimarySnackbar extends SnackBar {
  PrimarySnackbar(
    BuildContext context, {
    required String text,
    super.backgroundColor,
    super.key,
  }) : super(
          content: Text(
            text,
            style: context.themeData.textTheme.bodyMedium?.copyWith(
              color: context.themeData.colorScheme.primary,
            ),
          ),
        );
}
