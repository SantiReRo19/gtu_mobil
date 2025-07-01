import 'package:gtu_mobile/domain/entities/driver_assignment.dart';
import 'package:gtu_mobile/infraestructure/models/driver_assignment_model.dart';

sealed class DriverAssignmentMapper {
  static DriverAssignment toEntity(DriverAssignmentModel model) {
    return DriverAssignment(
      id: model.id,
      driverId: model.driverId,
      routeId: model.routeId,
      currentStopId: model.currentStopId,
      latestStopId: model.latestStopId,
      nextStopId: model.nextStopId,
    );
  }

  static DriverAssignmentModel toModel(DriverAssignment entity) {
    return DriverAssignmentModel(
      id: entity.id,
      driverId: entity.driverId,
      routeId: entity.routeId,
      currentStopId: entity.currentStopId,
      latestStopId: entity.latestStopId,
      nextStopId: entity.nextStopId,
    );
  }
}
