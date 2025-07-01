import 'package:gtu_mobile/domain/entities/driver_assignment.dart';
import 'package:gtu_mobile/domain/entities/driver_location.dart';
import 'package:gtu_mobile/domain/repositories/driver_location_repository.dart';
import 'package:gtu_mobile/infraestructure/datasources/api/driver_assigments_remote.dart';
import 'package:gtu_mobile/infraestructure/datasources/ws/driver_location_ws.dart';
import 'package:gtu_mobile/infraestructure/mappers/driver_assignment_mapper.dart';
import 'package:gtu_mobile/infraestructure/mappers/driver_location_mapper.dart';
import 'package:gtu_mobile/infraestructure/models/driver_location_model.dart';

class DriverLocationRepositoryImpl implements DriverLocationRepository {
  final DriverLocationWs _driverLocationWs;
  final DriverAssigmentsRemote _assigmentsRemote;

  DriverLocationRepositoryImpl(this._driverLocationWs, this._assigmentsRemote);

  @override
  Stream<DriverLocation> getDriverLocationStream() {
    return _driverLocationWs.messages.map((data) {
      return DriverLocationMapper.toEntity(driverLocationFromJson(data));
    });
  }

  @override
  Future<void> connect() async {
    _driverLocationWs.connect();
  }

  @override
  Future<void> disconnect() async {
    _driverLocationWs.disconnect();
  }

  @override
  Future<List<DriverAssignment>> getDriversAssignments() async {
    final response = await _assigmentsRemote.getDriversAssignments();
    return response.map(DriverAssignmentMapper.toEntity).toList();
  }

  @override
  Future<DriverAssignment> getDriverAssigmentById(int id) async {
    final respose = await _assigmentsRemote.getDriverAssigmentById(id);
    return DriverAssignmentMapper.toEntity(respose);
  }
}
