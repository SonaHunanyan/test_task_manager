import 'package:easy_localization/easy_localization.dart';

class AppStrings {
  static final tasks = 'tasks'.tr();
  static final failToGetTasks = 'failToGetTasks'.tr();
  static final failToCreateTask = 'failToCreateTask'.tr();
  static final failToUpdateTask = 'failToUpdateTask'.tr();
  static final failToDeleteTask = 'failToDeleteTask'.tr();
  static final add = 'add'.tr();
  static final createTask = 'createTask'.tr();
  static final createProject = 'createProject'.tr();
  static final task = 'task'.tr();
  static final project = 'project'.tr();
  static final projectName = 'projectName'.tr();
  static final theFieldIsRequired = 'theFieldIsRequired'.tr();
  static final create = 'create'.tr();
  static final content = 'content'.tr();
  static final selectProject = 'selectProject'.tr();
  static final projectIsRequired = 'projectIsRequired'.tr();
  static final notFound = 'notFound'.tr();
  static final queue = 'queue'.tr();
  static final inProgress = 'inProgress'.tr();
  static final done = 'done'.tr();
  static final createdAt = 'createdAt'.tr();
  static final back = 'back'.tr();
  static final startTimer = 'startTimer'.tr();
  static final stopTimer = 'stopTimer'.tr();
  static final description = 'description'.tr();
  static final enterDescription = 'enterDescription'.tr();
  static final duration = 'duration'.tr();
  static daysTime(int days) =>
      'time.days'.plural(days, namedArgs: {'count': '$days'});
  static hoursTime(int hours) =>
      'time.hours'.plural(hours, namedArgs: {'count': '$hours'});
  static minutesTime(int minutes) =>
      'time.minutes'.plural(minutes, namedArgs: {'count': '$minutes'});
  static final comment = 'comment'.tr();
  static final delete = 'delete'.tr();
  static final update = 'update'.tr();
  static final failToGetComment = 'failToGetComment'.tr();
  static final failToCreateComment = 'failToCreateComment'.tr();
  static final failToUpdatComment = 'failToUpdateComment'.tr();
  static final failToDeletComment = 'failToDeleteComment'.tr();
}
