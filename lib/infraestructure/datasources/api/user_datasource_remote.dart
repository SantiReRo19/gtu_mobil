import 'package:dio/dio.dart';
import 'package:gtu_mobile/config/constants/api.dart';
import 'package:gtu_mobile/config/networks/http_error.dart';

class UserDatasourceRemote {
  final Dio _dio;

  UserDatasourceRemote(this._dio);

  Future<void> updatePassword(
    String oldPassword,
    String newPassword,
    String userId,
  ) async {
    try {
      await _dio.put(
        Api.updatePassword.replaceFirst('{id}', userId),
        data: {"currentPassword": oldPassword, "newPassword": newPassword},
      );
    } catch (e) {
      if (e is DioException) {
        throw handleDioError(e);
      }
      rethrow;
    }
  }
}
