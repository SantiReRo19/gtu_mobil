import 'package:dio/dio.dart';
import 'package:gtu_mobile/config/constants/api.dart';
import 'package:gtu_mobile/domain/repositories/token_repositoy.dart';

/// Interceptor de autenticación para solicitudes HTTP usando Dio.
///
/// Este interceptor agrega el token de acceso a las cabeceras de autorización
/// en cada solicitud, excepto cuando la ruta corresponde a la identidad (login/refresh).
///
/// Si el token de acceso no está disponible, rechaza la solicitud con un error 401.
///
/// Además, maneja errores 401 intentando refrescar el token de acceso utilizando el refresh token.
/// Si el refresh token es válido, actualiza los tokens almacenados y reintenta la solicitud original.
/// Si falla el refresco del token, rechaza el error y ejecuta el manejador de errores personalizado.
///
/// Parámetros:
/// - [_storageService]: Servicio para leer y escribir tokens en almacenamiento local.
/// - [_dio]: Instancia de Dio para realizar solicitudes HTTP.
/// - [_handleDioError]: Función personalizada para manejar errores de Dio.
class AuthInterceptor extends Interceptor {
  final TokenRepository _tokenRepository;
  final void Function(DioException err)? _handleDioError;

  AuthInterceptor(this._tokenRepository, this._handleDioError);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.path.contains(Api.authApi)) {
      return handler.next(options);
    }

    final accessToken = await _tokenRepository.getToken();

    if (await _tokenRepository.hasToken()) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'No access token',
          response: Response(
            requestOptions: options,
            statusCode: 401,
            statusMessage: 'No access token',
          ),
        ),
      );
    }
    options.headers['Authorization'] = 'Bearer $accessToken';
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await _tokenRepository.deleteToken();
    }
    _handleDioError?.call(err);
    return handler.next(err);
  }
}
