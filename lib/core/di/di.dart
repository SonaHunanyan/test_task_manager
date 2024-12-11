import 'package:get_it/get_it.dart';
import 'package:rest_api/rest_api.dart';
import 'package:test_task_manager/core/constants/constants.dart';

void setupDependencies() {
  final restApi =
      AppRestApi(baseUrl: Constants.baseUrl, token: Constants.token);
  GetIt.I.registerSingleton<AppRestApi>(restApi);
}
