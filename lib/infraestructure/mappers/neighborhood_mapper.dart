import 'package:gtu_mobile/domain/entities/neighborhood.dart';
import 'package:gtu_mobile/infraestructure/models/neighborhood_response.dart';

sealed class NeighborhoodMapper {
  static Neighborhood toEntity(NeighborhoodModel neighborhoodModel) {
    return Neighborhood(id: neighborhoodModel.id, name: neighborhoodModel.name);
  }

  static NeighborhoodModel toModel(Neighborhood neighborhood) {
    return NeighborhoodModel(id: neighborhood.id, name: neighborhood.name);
  }
}
