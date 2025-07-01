import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  const MapView({super.key, this.onMapCreated, this.markers = const {}});
  final ValueChanged<GoogleMapController>? onMapCreated;
  final Set<Marker> markers;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Map(markers: markers, onMapCreated: onMapCreated),
    );
  }
}

class Map extends StatefulWidget {
  const Map({super.key, this.onMapCreated, this.markers = const {}});
  final ValueChanged<GoogleMapController>? onMapCreated;
  final Set<Marker> markers;

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(4.087412954516211, -76.19711538495747),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      compassEnabled: false,
      zoomControlsEnabled: false,

      cameraTargetBounds: CameraTargetBounds(
        LatLngBounds(
          southwest: LatLng(4.0309215071821995, -76.26404625637556),
          northeast: LatLng(4.143657524644851, -76.14080411226234),
        ),
      ),
      markers: widget.markers,
      onMapCreated: widget.onMapCreated,
      minMaxZoomPreference: const MinMaxZoomPreference(13.0, 19.0),
    );
  }
}
