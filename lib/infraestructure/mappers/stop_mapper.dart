import 'package:gtu_mobile/domain/entities/stop.dart';
import 'package:gtu_mobile/infraestructure/models/stop_response.dart';

sealed class StopMapper {
  static Stop toEntity(StopModel stopModel) {
    return Stop(
      id: stopModel.id,
      name: stopModel.name,
      description: stopModel.description,
      latitude: stopModel.latitude,
      longitude: stopModel.longitude,
      neighborhood: stopModel.neighborhoodId,
    );
  }

  static StopModel toModel(Stop stop) {
    return StopModel(
      id: stop.id,
      name: stop.name,
      description: stop.description,
      latitude: stop.latitude,
      longitude: stop.longitude,
      neighborhoodId: stop.neighborhood,
    );
  }
}
