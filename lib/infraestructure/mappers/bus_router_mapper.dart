import 'package:gtu_mobile/domain/entities/bus_route.dart';
import 'package:gtu_mobile/infraestructure/models/route_response.dart';

sealed class BusRouterMapper {
  static BusRoute toEntity(RouteModel busRouteModel) {
    return BusRoute(
      id: busRouteModel.id,
      name: busRouteModel.name,
      description: busRouteModel.description,
      startTime: _parseDate(busRouteModel.startTime),
      endTime: _parseDate(busRouteModel.endTime),
      neighborhoods: busRouteModel.neighborhoodIds,
      stops: busRouteModel.stops,
    );
  }

  static RouteModel toModel(BusRoute busRoute) {
    return RouteModel(
      id: busRoute.id,
      name: busRoute.name,
      description: busRoute.description,
      startTime:
          '${busRoute.startTime.hour.toString().padLeft(2, '0')}:${busRoute.startTime.minute.toString().padLeft(2, '0')}',
      endTime:
          '${busRoute.endTime.hour.toString().padLeft(2, '0')}:${busRoute.endTime.minute.toString().padLeft(2, '0')}',
      neighborhoodIds: busRoute.neighborhoods,
      stops: busRoute.stops,
    );
  }

  static DateTime _parseDate(String dateString) {
    // 00:00 - 23:59
    final parts = dateString.split(':');
    final date = DateTime.now();
    return DateTime(
      date.year,
      date.month,
      date.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }
}
