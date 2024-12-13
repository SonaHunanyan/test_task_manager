import 'package:test_task_manager/core/constants/app_strings.dart';

enum MainEntity {
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
}
