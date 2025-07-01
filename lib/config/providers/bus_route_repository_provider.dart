import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/config/providers/dio_provider.dart';
import 'package:gtu_mobile/domain/repositories/bus_route_repository.dart';
import 'package:gtu_mobile/infraestructure/datasources/api/bus_route_datasource_remote.dart';
import 'package:gtu_mobile/infraestructure/repositories/bus_route_repository_impl.dart';

final busRouteRepositoryProvider = Provider<BusRouteRepository>((ref) {
  final busRouteDataSource = BusRouteDatasourceRemote(ref.watch(dioProvider));
  return BusRouteRepositoryImpl(busRouteDataSource);
});
