import 'package:easy_localization/easy_localization.dart';

class AppStrings {
  static const tasks = 'tasks';
  static const failToGetTasks = 'failToGetTasks';
  static const failToCreateTask = 'failToCreateTask';
  static const failToUpdateTask = 'failToUpdateTask';
  static const failToDeleteTask = 'failToDeleteTask';
  static const add = 'add';
  static const createTask = 'createTask';
  static const createProject = 'createProject';
  static const task = 'task';
  static const project = 'project';
  static const projectName = 'projectName';
  static const theFieldIsRequired = 'theFieldIsRequired';
  static const create = 'create';
  static const content = 'content';
  static const selectProject = 'selectProject';
  static const projectIsRequired = 'projectIsRequired';
  static const notFound = 'notFound';
  static const queue = 'queue';
  static const inProgress = 'inProgress';
  static const done = 'done';
  static const createdAt = 'createdAt';
  static const back = 'back';
  static const startTimer = 'startTimer';
  static const stopTimer = 'stopTimer';
  static const description = 'description';
  static const enterDescription = 'enterDescription';
  static const duration = 'duration';
  static daysTime(int days) =>
      'time.days'.plural(days, namedArgs: {'count': '$days'});
  static hoursTime(int hours) =>
      'time.hours'.plural(hours, namedArgs: {'count': '$hours'});
  static minutesTime(int minutes) =>
      'time.minutes'.plural(minutes, namedArgs: {'count': '$minutes'});
  static const comment = 'comment';
  static const delete = 'delete';
  static const update = 'update';
  static const failToGetComment = 'failToGetComment';
  static const failToCreateComment = 'failToCreateComment';
  static const failToUpdatComment = 'failToUpdateComment';
  static const failToDeletComment = 'failToDeleteComment';
  static const settings = 'settings';
  static const locale = 'locale';
  static const language = 'language';
  static const supportedLanguages = 'supportedLanguages.name';
  static const supportedFalgs = 'supportedLanguages.flags';
  static const flag = 'flag';
}
