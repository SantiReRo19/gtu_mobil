import 'package:gtu_mobile/domain/entities/bus_route.dart';
import 'package:gtu_mobile/domain/entities/neighborhood.dart';
import 'package:gtu_mobile/domain/entities/stop.dart';
import 'package:gtu_mobile/domain/repositories/bus_route_repository.dart';
import 'package:gtu_mobile/infraestructure/datasources/api/bus_route_datasource_remote.dart';
import 'package:gtu_mobile/infraestructure/mappers/bus_router_mapper.dart';
import 'package:gtu_mobile/infraestructure/mappers/neighborhood_mapper.dart';
import 'package:gtu_mobile/infraestructure/mappers/stop_mapper.dart';
import 'package:gtu_mobile/utils/distance.dart';

class BusRouteRepositoryImpl implements BusRouteRepository {
  final BusRouteDatasourceRemote _busRouteDatasourceRemote;
  BusRouteRepositoryImpl(this._busRouteDatasourceRemote);
  final List<Neighborhood> _neighborhoodsCache = [];
  final List<Stop> _stopsCache = [];

  @override
  Future<List<BusRoute>> getAllRoutes() async {
    try {
      final routes = await _busRouteDatasourceRemote.getAllRoutes();

      return routes.map(BusRouterMapper.toEntity).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Neighborhood>> getNeighborhoodsByRouteId(int routeId) async {
    try {
      final route = await _busRouteDatasourceRemote.getRouteById(routeId);
      final List<Neighborhood> neighborhoods = [];
      for (var neighborhood in route.neighborhoodIds) {
        final neighborhoodExists = _neighborhoodsCache.any(
          (n) => n.id == neighborhood,
        );

        if (neighborhoodExists) {
          neighborhoods.add(
            _neighborhoodsCache.firstWhere((n) => n.id == neighborhood),
          );
        } else {
          final neighborhoodData = await _busRouteDatasourceRemote
              .getNeighborhoodById(neighborhood);
          neighborhoods.add(NeighborhoodMapper.toEntity(neighborhoodData));
        }
      }
      return neighborhoods;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BusRoute> getRouteById(int routeId) async {
    try {
      final route = await _busRouteDatasourceRemote.getRouteById(routeId);
      return BusRouterMapper.toEntity(route);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Stop>> getStopsByRouteId(int routeId) async {
    try {
      final route = await _busRouteDatasourceRemote.getRouteById(routeId);
      final List<Stop> stops = [];
      for (var stop in route.stops) {
        final stopExists = _stopsCache.any((s) => s.id == stop);
        if (stopExists) {
          stops.add(_stopsCache.firstWhere((s) => s.id == stop));
        } else {
          final stopData = await _busRouteDatasourceRemote.getStopById(stop);
          stops.add(StopMapper.toEntity(stopData));
        }
      }
      return stops;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<BusRoute>> searchRoutes(String query) async {
    try {
      final routes = await _busRouteDatasourceRemote.getRoutesSearch(query);
      return routes.map(BusRouterMapper.toEntity).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<BusRoute>> getNearbyBusRoutes(
    double latitude,
    double longitude,
  ) async {
    try {
      _stopsCache.clear();
      final stops = await _busRouteDatasourceRemote.getAllStops();
      _stopsCache.addAll(stops.map(StopMapper.toEntity));
      /*  stops.sort(
        (a, b) => haversineMeters(latitude, longitude, b.latitude, b.longitude)
            .compareTo(
              haversineMeters(latitude, longitude, a.latitude, a.longitude),
            ),
      );*/

      final filteredStops = stops.where((stop) {
        final dis = haversineMeters(
          latitude,
          longitude,
          stop.latitude,
          stop.longitude,
        );
        return dis < 100;
      });
      final List<int> routesIds = [];
      final routes = await _busRouteDatasourceRemote.getAllRoutes();
      final nearbyRoutes = <BusRoute>[];
      for (var stop in filteredStops) {
        for (var route in routes) {
          if (route.stops.contains(stop.id) && !routesIds.contains(route.id)) {
            routesIds.add(route.id);
            nearbyRoutes.add(BusRouterMapper.toEntity(route));
          }
        }
      }

      return nearbyRoutes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Neighborhood>> getAllNeighborhoods() async {
    try {
      final neighborhoods = await _busRouteDatasourceRemote
          .getAllNeighborhoods();
      _neighborhoodsCache.clear();
      _neighborhoodsCache.addAll(
        neighborhoods.map(NeighborhoodMapper.toEntity),
      );
      return _neighborhoodsCache;
    } catch (e) {
      rethrow;
    }
  }
}
