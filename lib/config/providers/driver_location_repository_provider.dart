import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/config/constants/api.dart';
import 'package:gtu_mobile/config/providers/dio_provider.dart';
import 'package:gtu_mobile/domain/repositories/driver_location_repository.dart';
import 'package:gtu_mobile/infraestructure/datasources/api/driver_assigments_remote.dart';
import 'package:gtu_mobile/infraestructure/datasources/ws/driver_location_ws.dart';
import 'package:gtu_mobile/infraestructure/repositories/driver_location_repository_impl.dart';

final driverLocationRepositoryProvider = Provider<DriverLocationRepository>((
  ref,
) {
  final driverLocationWs = DriverLocationWs(Api.baseWs);
  final dio = ref.watch(dioProvider);

  return DriverLocationRepositoryImpl(
    driverLocationWs,
    DriverAssigmentsRemote(dio),
  );
});
