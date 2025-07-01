import 'package:gtu_mobile/domain/entities/driver_assignment.dart';
import 'package:gtu_mobile/domain/entities/driver_location.dart';

abstract class DriverLocationRepository {
  Future<void> connect();
  Future<void> disconnect();
  Stream<DriverLocation> getDriverLocationStream();
  Future<List<DriverAssignment>> getDriversAssignments();
  Future<DriverAssignment> getDriverAssigmentById(int id);
}
