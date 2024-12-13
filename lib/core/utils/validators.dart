import 'package:test_task_manager/core/constants/app_strings.dart';

class Validator {
  static String? required(String? value) {
    final v = value;
    if (v == null || v.isEmpty) {
      return AppStrings.theFieldIsRequired;
    }
    return null;
  }
}
