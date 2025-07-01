import 'package:dio/dio.dart';
import 'package:gtu_mobile/config/constants/api.dart';
import 'package:gtu_mobile/infraestructure/models/driver_assignment_model.dart';

class DriverAssigmentsRemote {
  final Dio _dio;

  DriverAssigmentsRemote(this._dio);

  Future<List<DriverAssignmentModel>> getDriversAssignments() async {
    try {
      final response = await _dio.get(Api.driverAssigments);
      return DriverAssigneResponde.fromJson(response.data).data;
    } catch (e) {
      rethrow;
    }
  }

  Future<DriverAssignmentModel> getDriverAssigmentById(int id) async {
    try {
      final response = await _dio.get('${Api.driverAssigments}/$id');
      return DriverAssignmentModel.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }
}
