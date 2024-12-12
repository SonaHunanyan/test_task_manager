import 'package:get_it/get_it.dart';
import 'package:rest_api/rest_api.dart';
import 'package:test_task_manager/core/constants/constants.dart';
import 'package:test_task_manager/features/tasks/data/repositories/task_repository.dart';
import 'package:test_task_manager/features/tasks/domain/repositories/task_repository.dart';

void setupDependencies() {
  final restApi =
      AppRestApi(baseUrl: Constants.baseUrl, token: Constants.token);
  GetIt.I.registerSingleton<AppRestApi>(restApi);
  GetIt.I.registerSingleton<ITaskRepository>(TaskRepository(restApi.taskApi));
}
