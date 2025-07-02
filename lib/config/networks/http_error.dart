import 'package:dio/dio.dart';

/// Representa un error HTTP personalizado que implementa la interfaz [Exception].
///
/// Contiene información sobre el código de estado HTTP, un mensaje descriptivo
/// y datos adicionales opcionales relacionados con el error.
///
/// [statusCode]: El código de estado HTTP asociado al error.
/// [message]: Un mensaje descriptivo del error.
/// [data]: Información adicional opcional sobre el error.
class HttpError implements Exception {
  final int statusCode;
  final String message;
  final dynamic data;

  HttpError({required this.statusCode, required this.message, this.data});

  @override
  String toString() => message;
}

/// Enumera los posibles estados de una respuesta HTTP, asociando cada estado con su código numérico correspondiente.
///
/// Los valores incluyen estados comunes como éxito (`ok`), errores del cliente (`badRequest`, `unauthorized`, etc.),
/// errores del servidor (`internalServerError`, `serviceUnavailable`, etc.), y estados especiales como `cancelled` y `unknown`.
///
/// Cada valor tiene un campo `code` que representa el código HTTP asociado.
///
/// Ejemplo de uso:
/// ```dart
/// if (response.statusCode == HttpResponseStatus.ok.code) {
///   // Manejar respuesta exitosa
/// }
/// ```
enum HttpResponseStatus {
  cancelled(-2, 'Solicitud cancelada'),
  unknown(
    -1,
    'No se puedo procesar la solicitud, verifique su conexión a internet',
  ),
  ok(200, 'Solicitud exitosa'),
  created(201, 'Recurso creado exitosamente'),
  accepted(202, 'Solicitud aceptada, pero no procesada aún'),
  noContent(204, 'No hay contenido para mostrar'),
  badRequest(400, 'Solicitud incorrecta'),
  unauthorized(401, 'No autorizado'),
  forbidden(403, 'Prohibido'),
  notFound(404, 'No encontrado'),
  conflict(409, 'Conflicto en la solicitud'),
  internalServerError(500, 'Error interno del servidor'),
  notImplemented(501, 'No implementado'),
  badGateway(502, 'Puerta de enlace incorrecta'),
  serviceUnavailable(503, 'Servicio no disponible'),
  gatewayTimeout(504, 'Tiempo de espera agotado');

  final int code;
  final String description;
  const HttpResponseStatus(this.code, [this.description = '']);
}

HttpError handleDioError(DioException e) {
  if (e.type == DioExceptionType.cancel) {
    return HttpError(
      statusCode: HttpResponseStatus.cancelled.code,
      message: HttpResponseStatus.cancelled.description,
    );
  }

  String message = HttpResponseStatus.unknown.description;

  if (e.response?.data is Map) {
    message =
        e.response!.data['message'] ?? e.response!.data['error'] ?? message;
  } else if (HttpResponseStatus.values.any(
    (status) => status.code == e.response?.statusCode,
  )) {
    message = HttpResponseStatus.values
        .firstWhere((status) => status.code == e.response?.statusCode)
        .description;
  } else if (e.response?.data is String) {
    message = e.response!.data;
  }

  return HttpError(
    statusCode: e.response?.statusCode ?? HttpResponseStatus.unknown.code,
    message: message,
    data: e.response?.data,
  );
}
