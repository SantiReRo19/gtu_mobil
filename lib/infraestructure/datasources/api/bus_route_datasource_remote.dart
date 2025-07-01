import 'package:dio/dio.dart';
import 'package:gtu_mobile/config/constants/api.dart';
import 'package:gtu_mobile/infraestructure/models/neighborhood_response.dart';
import 'package:gtu_mobile/infraestructure/models/route_response.dart';
import 'package:gtu_mobile/infraestructure/models/stop_response.dart';

class BusRouteDatasourceRemote {
  final Dio _dio;
  BusRouteDatasourceRemote(this._dio);

  Future<List<NeighborhoodModel>> getAllNeighborhoods() async {
    try {
      final response = await _dio.get(Api.neighborhoods);
      return NeighborhoodResponse.fromJson(response.data).data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NeighborhoodModel>> getNeighborhoodsSearch(String query) async {
    try {
      final response = await _dio.get(
        Api.neighborhoods,
        queryParameters: {'search': query},
      );
      return NeighborhoodResponse.fromJson(response.data).data;
    } catch (e) {
      rethrow;
    }
  }

  Future<NeighborhoodModel> getNeighborhoodById(int id) async {
    try {
      final response = await _dio.get('${Api.neighborhoods}/$id');
      return NeighborhoodModel.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<StopModel>> getAllStops() async {
    try {
      final response = await _dio.get(Api.stops);
      return StopResponse.fromJson(response.data).data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<StopModel>> getStopsSearch(String query) async {
    try {
      final response = await _dio.get(
        Api.stops,
        queryParameters: {'search': query},
      );
      return StopResponse.fromJson(response.data).data;
    } catch (e) {
      rethrow;
    }
  }

  Future<StopModel> getStopById(int id) async {
    try {
      final response = await _dio.get('${Api.stops}/$id');
      return StopModel.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RouteModel>> getAllRoutes() async {
    try {
      final response = await _dio.get(Api.busRoute);
      return RouteResponse.fromJson(response.data).data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RouteModel>> getRoutesSearch(String query) async {
    try {
      final response = await _dio.get(
        '${Api.busRoute}/search',
        queryParameters: {'name': query},
      );
      return RouteResponse.fromJson(response.data).data;
    } catch (e) {
      rethrow;
    }
  }

  Future<RouteModel> getRouteById(int id) async {
    try {
      final response = await _dio.get('${Api.busRoute}/$id');
      return RouteModel.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }
}
