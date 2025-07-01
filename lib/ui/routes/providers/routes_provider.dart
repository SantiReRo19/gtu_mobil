import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/config/providers/bus_route_repository_provider.dart';
import 'package:gtu_mobile/domain/entities/bus_route.dart';
import 'package:gtu_mobile/domain/entities/neighborhood.dart';
import 'package:gtu_mobile/domain/entities/stop.dart';
import 'package:gtu_mobile/domain/repositories/bus_route_repository.dart';
import 'package:gtu_mobile/ui/common/handlers/process_handler.dart';
import 'package:gtu_mobile/ui/common/providers/process_handler_provider.dart';

final routesProvider = StateNotifierProvider<RoutesNotifier, List<BusRoute>>(
  (ref) => RoutesNotifier(
    ref.watch(busRouteRepositoryProvider),
    ref.watch(processHandlerProvider),
  ),
);

class RoutesNotifier extends StateNotifier<List<BusRoute>> {
  RoutesNotifier(this._busRouteRepository, this._processHandler) : super([]) {
    _init();
  }
  final List<BusRoute> _routes = [];
  get routes => _routes;
  final BusRouteRepository _busRouteRepository;
  final ProcessHandler _processHandler;

  void _init() async {
    try {
      final routes = await _busRouteRepository.getAllRoutes();
      _routes.addAll(routes);
      state = _routes;
    } catch (e) {
      _processHandler.openModalDialogAlert(
        title: 'Algo salió mal',
        message: 'No se pudieron cargar las rutas. Inténtalo más tarde.',
      );
      state = [];
    }
  }

  void onFilterRoutesNeighborhood(Neighborhood? neighborhood) {
    if (neighborhood == null) {
      state = _routes;
      return;
    }
    final filteredRoutes = _routes
        .where((route) => route.neighborhoods.contains(neighborhood.id))
        .toList();
    state = filteredRoutes;
  }

  Future<List<Stop>> getStopsByRouteId(int routeId) async {
    try {
      final stops = await _busRouteRepository.getStopsByRouteId(routeId);
      return stops;
    } catch (e) {
      _processHandler.openModalDialogAlert(
        title: 'Error al obtener paradas',
        message: 'No se pudieron cargar las paradas de la ruta.',
      );
      return [];
    }
  }
}
