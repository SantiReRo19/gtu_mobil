import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final routeMapProvider = Provider.autoDispose<RouteMapProvider>((ref) {
  return RouteMapProvider();
});

typedef MarkerBuilder = MarkerData Function(int index);

class RouteMapProvider {
  late final GoogleMapController controller;
  bool isInitialized = false;

  RouteMapProvider();

  void init(GoogleMapController mapController) {
    controller = mapController;
    isInitialized = true;
  }

  void moveCamera(double latitude, double longitude) async {
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 16.0),
      ),
    );
  }

  void centerMapBounds(List<List<double>> coordinates) {
    if (coordinates.isEmpty) return;
    final LatLngBounds bounds = _calculateBounds(coordinates);
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  LatLngBounds _calculateBounds(List<List<double>> coordinates) {
    double? north, south, east, west;
    for (final coord in coordinates) {
      if (coord.length != 2) continue;
      final lat = coord[0];
      final lng = coord[1];
      if (north == null || lat > north) north = lat;
      if (south == null || lat < south) south = lat;
      if (east == null || lng > east) east = lng;
      if (west == null || lng < west) west = lng;
    }
    return LatLngBounds(
      northeast: LatLng(north ?? 0, east ?? 0),
      southwest: LatLng(south ?? 0, west ?? 0),
    );
  }

  Set<Marker> createMarkers(
    MarkerData Function(int index) markerBuilder,
    int count,
  ) {
    final Set<Marker> markers = {};
    for (int i = 0; i < count; i++) {
      markers.add(markerBuilder(i).toMarker());
    }
    return markers;
  }
}

class MarkerData {
  final String id;
  final double latitude;
  final double longitude;
  final String title;
  final String? description;
  final void Function()? onTap;

  MarkerData({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.title,
    this.description,
    this.onTap,
  });

  Marker toMarker() {
    return Marker(
      markerId: MarkerId(id),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(title: title, snippet: description),
      onTap: onTap,
    );
  }
}
