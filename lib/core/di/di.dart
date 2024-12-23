import 'package:get_it/get_it.dart';
import 'package:rest_api/rest_api.dart';
import 'package:storage/storage.dart';
import 'package:test_task_manager/core/constants/constants.dart';
import 'package:test_task_manager/features/comments/data/repositories/comment_repository.dart';
import 'package:test_task_manager/features/comments/domain/repositories/comment_repository.dart';
import 'package:test_task_manager/features/settings/data/repositories/theme_repository.dart';
import 'package:test_task_manager/features/settings/domain/repositories/theme_repository.dart';
import 'package:test_task_manager/features/projects/data/repositories/project_repository.dart';
import 'package:test_task_manager/features/projects/domain/repositories/project_repository.dart';
import 'package:test_task_manager/features/tasks/data/repositories/task_repository.dart';
import 'package:test_task_manager/features/tasks/domain/repositories/task_repository.dart';

void setupDependencies() {
  final restApi =
      AppRestApi(baseUrl: Constants.baseUrl, token: Constants.token);
  GetIt.I.registerSingleton<AppRestApi>(restApi);
  final Store store = SharedPrefs();
  GetIt.I.registerSingleton<Store>(store);
  GetIt.I.registerSingleton<ITaskRepository>(
      TaskRepository(restApi.taskApi, store: store));
  GetIt.I.registerSingleton<IProjectRepository>(
      ProjectRepository(restApi.projectApi));
  GetIt.I.registerSingleton<ICommentRepository>(
      CommentRepository(restApi.commentApi));
  GetIt.I.registerSingleton<IThemeRepository>(ThemeRepository(store));
}
