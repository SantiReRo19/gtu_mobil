import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gtu_mobile/config/providers/bus_route_repository_provider.dart';
import 'package:gtu_mobile/config/routes/app_router.dart';
import 'package:gtu_mobile/domain/entities/bus_route.dart';
import 'package:gtu_mobile/domain/repositories/bus_route_repository.dart';
import 'package:gtu_mobile/ui/common/handlers/process_handler.dart';
import 'package:gtu_mobile/ui/common/providers/location_provider.dart';
import 'package:gtu_mobile/ui/common/providers/process_handler_provider.dart';

final nearbyRouteProvider =
    StateNotifierProvider.autoDispose<NearbyRouteProvider, List<BusRoute>?>((
      ref,
    ) {
      final busRouteRepository = ref.watch(busRouteRepositoryProvider);
      final location = ref.watch(locationServiceProvider);
      final processHandler = ref.watch(processHandlerProvider);
      final goRouter = ref.watch(appRouteProvider);
      return NearbyRouteProvider(
        busRouteRepository,
        processHandler,
        location,
        goRouter,
      );
    });

class NearbyRouteProvider extends StateNotifier<List<BusRoute>?> {
  final BusRouteRepository _busRouteRepository;
  final LocationService _locationProvider;
  final ProcessHandler _processHandler;
  final GoRouter _goRouter;

  NearbyRouteProvider(
    this._busRouteRepository,
    this._processHandler,
    this._locationProvider,
    this._goRouter,
  ) : super(null);
  late double latitude;
  late double longitude;

  void init(double? lat, double? long) async {
    try {
      if (lat != null && long != null) {
        latitude = lat;
        longitude = long;
      } else {
        _processHandler.showProgressDialog();

        final data = await _locationProvider.getLocation();
        latitude = data.latitude ?? 0.0;
        longitude = data.longitude ?? 0.0;
        _processHandler.dismissProgressDialog();
      }
      getNearbyRoutes();
    } catch (e) {
      _processHandler.dismissProgressDialog();
      _processHandler.openModalDialogAlert(
        title: 'Error',
        message: 'No se pudo inicializar la ubicación.',
      );
    }
  }

  Future<void> getNearbyRoutes() async {
    try {
      if (latitude == 0.0 || longitude == 0.0) {
        throw Exception('Invalid coordinates');
      }
      final routes = await _busRouteRepository.getNearbyBusRoutes(
        latitude,
        longitude,
      );
      state = routes;
    } catch (e) {
      _processHandler.openModalDialogAlert(
        title: '¡Ups!',
        message:
            'No se pudieron obtener las rutas cercanas. Por favor, inténtalo de nuevo más tarde.',
        onConfirm: _goRouter.pop,
      );
      state = [];
    }
  }
}
