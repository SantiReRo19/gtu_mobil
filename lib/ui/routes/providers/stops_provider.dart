import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/config/providers/bus_route_repository_provider.dart';
import 'package:gtu_mobile/domain/entities/stop.dart';
import 'package:gtu_mobile/domain/repositories/bus_route_repository.dart';
import 'package:gtu_mobile/ui/common/handlers/process_handler.dart';
import 'package:gtu_mobile/ui/common/providers/process_handler_provider.dart';

final stopsProvider =
    StateNotifierProvider.autoDispose<StopsNotifer, List<Stop>>((ref) {
      final busRouteRepository = ref.watch(busRouteRepositoryProvider);
      final processHandler = ref.watch(processHandlerProvider);
      return StopsNotifer(busRouteRepository, processHandler);
    });

class StopsNotifer extends StateNotifier<List<Stop>> {
  final BusRouteRepository _busRouteRepository;
  final ProcessHandler _processHandler;

  StopsNotifer(this._busRouteRepository, this._processHandler) : super([]);

  void init(int routeId) async {
    try {
      _processHandler.showProgressDialog();
      final stops = await _busRouteRepository.getStopsByRouteId(routeId);
      state = stops;
      _processHandler.dismissProgressDialog();
    } catch (e) {
      _processHandler.dismissProgressDialog();
      _processHandler.openModalDialogAlert(
        title: '¡Ups!',
        message: 'Algo salió mal al cargar las paradas. Inténtalo más tarde.',
      );
    }
  }
}
