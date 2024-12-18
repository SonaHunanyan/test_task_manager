import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';

class Validator {
  static String? required(BuildContext context, String? value) {
    final v = value;
    if (v == null || v.isEmpty) {
      return context.tr(AppStrings.theFieldIsRequired);
    }
    return null;
  }
}
