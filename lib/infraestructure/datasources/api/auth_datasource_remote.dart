import 'package:dio/dio.dart';
import 'package:gtu_mobile/config/constants/api.dart';
import 'package:gtu_mobile/config/networks/http_error.dart';
import 'package:gtu_mobile/infraestructure/models/user_response.dart';

class AuthDatasourceRemote {
  final Dio _dio;
  AuthDatasourceRemote(this._dio);

  Future<UserModel> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        Api.login,
        data: {'email': email, 'password': password},
      );
      return UserResponse.fromJson(response.data).data;
    } catch (e) {
      if (e is DioException) {
        throw handleDioError(e);
      }
      rethrow;
    }
  }

  Future<void> signOut() {
    throw UnimplementedError();
  }

  Future<UserModel> signUp(String name, String email, String password) async {
    try {
      final response = await _dio.post(
        Api.register,
        data: {'name': name, 'email': email, 'password': password},
      );
      return UserResponse.fromJson(response.data).data;
    } catch (e) {
      if (e is DioException) {
        throw handleDioError(e);
      }
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _dio.post(Api.resetPassword, queryParameters: {'email': email});
    } catch (e) {
      if (e is DioException) {
        throw handleDioError(e);
      }
      rethrow;
    }
  }
}
