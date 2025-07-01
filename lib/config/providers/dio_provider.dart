import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/config/constants/api.dart';
import 'package:gtu_mobile/config/networks/interceptors/auth_interceptor.dart';
import 'package:gtu_mobile/config/providers/token_repository_provider.dart';
import 'package:gtu_mobile/config/routes/app_router.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(baseUrl: Api.baseUrl));

  dio.interceptors.add(
    AuthInterceptor(ref.watch(tokenRepositoryProvider), (err) {
      if (err.response?.statusCode == 401) {
        ref.read(appRouteProvider).goNamed(AppRouterName.login);
      }
    }),
  );

  dio.interceptors.add(
    LogInterceptor(
      request: true,
      responseBody: true,
      requestBody: true,
      error: true,
    ),
  );

  return dio;
});
