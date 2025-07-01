import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/config/providers/driver_location_repository_provider.dart';
import 'package:gtu_mobile/domain/entities/driver_assignment.dart';
import 'package:gtu_mobile/domain/entities/driver_location.dart';
import 'package:gtu_mobile/domain/repositories/driver_location_repository.dart';
import 'package:gtu_mobile/ui/common/handlers/process_handler.dart';
import 'package:gtu_mobile/ui/common/providers/process_handler_provider.dart';

final driverTrackingProvider =
    StateNotifierProvider<DriverTrackingNotifier, Set<DriverLocation>>((ref) {
      final driverLocationRepository = ref.watch(
        driverLocationRepositoryProvider,
      );
      final processHandler = ref.watch(processHandlerProvider);
      return DriverTrackingNotifier(
        <DriverLocation>{},
        driverLocationRepository,
        processHandler,
      );
    });

class DriverTrackingNotifier extends StateNotifier<Set<DriverLocation>> {
  DriverTrackingNotifier(
    super.state,
    this._driverLocationRepository,
    this._processHandler,
  );
  final Map<String, DriverLocation> _driverLocations = {};

  final DriverLocationRepository _driverLocationRepository;
  late final StreamSubscription<DriverLocation> _driverLocationStream;
  final ProcessHandler _processHandler;
  final List<DriverAssignment> _assigments = [];

  void init() async {
    try {
      _processHandler.showProgressDialog();
      await _driverLocationRepository.connect();
      final assigments = await _driverLocationRepository
          .getDriversAssignments();
      _assigments.addAll(assigments);
      _processHandler.dismissProgressDialog();
      _driverLocationStream = _driverLocationRepository
          .getDriverLocationStream()
          .listen(updateLocation);
    } catch (e) {
      _processHandler.dismissProgressDialog();
      _processHandler.openModalDialogAlert(
        title: 'Estamos teniendo problemas',
        message:
            'No podemos actualizar la ubicación de los conductores en este momento. Por favor, inténtalo más tarde.',
      );
    }
  }

  void updateLocation(DriverLocation driver) async {
    if (!_assigments.any((e) => e.driverId == driver.id)) {
      return;
    }

    _driverLocations[driver.id.toString()] = driver;
    state = _driverLocations.values.toSet();
  }

  @override
  void dispose() async {
    await _driverLocationRepository.disconnect();
    _driverLocationStream.cancel();
    super.dispose();
  }

  DriverAssignment? getAssigmentByDriverId(int driverId) {
    final assignment = _assigments.where((e) => e.driverId == driverId);
    if (assignment.isNotEmpty) {
      return assignment.first;
    }
    return null;
  }
}
