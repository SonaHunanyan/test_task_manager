import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rest_api/rest_api.dart';
import 'package:rest_api/src/constants/constants.dart';

class AppRestApi {
  AppRestApi({
    required String baseUrl,
    required String token,
  })  : _baseUrl = baseUrl,
        _token = token {
    final baseOptions = BaseOptions(
      baseUrl: _baseUrl,
      headers: Constants.baseHeader(_token),
    );
    _dio = Dio(
      baseOptions,
    );
    _dio.interceptors.addAll([
      LogInterceptor(
          request: true,
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: true,
          logPrint: (e) {
            log(e.toString());
          }),
    ]);

    taskApi = TaskApi(_dio);
    projectApi = ProjectApi(_dio);
    commentApi = CommentApi(_dio);
  }

  final String _baseUrl;
  final String _token;
  late final Dio _dio;
  late final TaskApi taskApi;
  late final ProjectApi projectApi;
  late final CommentApi commentApi;
}
