import 'package:location/location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService(Location());
});

/// Controlador para manejar la obtención de la ubicación del dispositivo.
///
/// Esta clase utiliza la biblioteca `Location` para obtener la ubicación actual del dispositivo.
/// Se encarga de verificar si el servicio de ubicación está habilitado y si los permisos necesarios
/// han sido otorgados. En caso de que el servicio no esté habilitado o los permisos no hayan sido
/// otorgados, solicita al usuario que los habilite.
///
/// Lanzará una `LocationException` con un mensaje apropiado si el servicio de ubicación no está
/// habilitado o si los permisos no han sido otorgados.
class LocationService {
  final Location _location;

  LocationService(this._location);

  Future<LocationData> getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        throw LocationException('Por favor, habilite el servicio de ubicación');
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw LocationException('Por favor, habilite el permiso de ubicación');
      }
    }

    try {
      return await _location.getLocation();
    } on LocationException {
      rethrow;
    } catch (e) {
      throw LocationException('Error al obtener la ubicación');
    }
  }
}

/// Excepción personalizada para manejar errores relacionados con la ubicación.
///
/// Esta excepción se utiliza para indicar problemas específicos que pueden ocurrir
/// al trabajar con la ubicación en la aplicación.
///
/// Ejemplo de uso:
/// ```dart
/// try {
///   // Código que puede lanzar una LocationException
/// } catch (e) {
///   if (e is LocationException) {
///     print('Error de ubicación: ${e.message}');
///   }
/// }
/// ```
///
/// Propiedades:
/// - `message`: Un mensaje que describe el error de ubicación.
class LocationException implements Exception {
  final String message;
  LocationException(this.message);
}
