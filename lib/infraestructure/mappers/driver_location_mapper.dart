import 'package:gtu_mobile/domain/entities/driver_location.dart';
import 'package:gtu_mobile/infraestructure/models/driver_location_model.dart';

sealed class DriverLocationMapper {
  static DriverLocationModel toModel(DriverLocation entity) {
    return DriverLocationModel(
      driverId: entity.id,
      name: entity.name,
      location: Location(
        latitude: entity.latitude,
        longitude: entity.longitude,
      ),
      speed: entity.speed,
    );
  }

  static DriverLocation toEntity(DriverLocationModel model) {
    return DriverLocation(
      id: model.driverId,
      name: model.name,
      speed: model.speed,
      latitude: model.location.latitude,
      longitude: model.location.longitude,
    );
  }
}
