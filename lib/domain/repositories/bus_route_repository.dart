import 'package:gtu_mobile/domain/entities/bus_route.dart';
import 'package:gtu_mobile/domain/entities/neighborhood.dart';
import 'package:gtu_mobile/domain/entities/stop.dart';

abstract class BusRouteRepository {
  Future<List<BusRoute>> getAllRoutes();
  Future<BusRoute> getRouteById(int routeId);
  Future<List<BusRoute>> searchRoutes(String query);
  Future<List<Stop>> getStopsByRouteId(int routeId);
  Future<List<Neighborhood>> getNeighborhoodsByRouteId(int routeId);
  Future<List<BusRoute>> getNearbyBusRoutes(double latitude, double longitude);
  Future<List<Neighborhood>> getAllNeighborhoods();
}
