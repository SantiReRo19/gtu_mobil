import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gtu_mobile/config/routes/app_router.dart';
import 'package:gtu_mobile/ui/common/views/map_view.dart';
import 'package:gtu_mobile/ui/home/widgets/search_route.dart';
import 'package:gtu_mobile/ui/tracking/providers/driver_tracking_provider.dart';

class BusFleetScreen extends ConsumerStatefulWidget {
  const BusFleetScreen({super.key});

  @override
  ConsumerState<BusFleetScreen> createState() => _BusFleetScreenState();
}

class _BusFleetScreenState extends ConsumerState<BusFleetScreen> {
  BitmapDescriptor? _bitmapDescriptor;

  @override
  void initState() {
    super.initState();
    getBitmapDescriptor();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(driverTrackingProvider.notifier).init();
    });
  }

  Future<Uint8List> loadImageBytes() async {
    final ByteData byteData = await rootBundle.load('assets/bus.png');
    return byteData.buffer.asUint8List();
  }

  void getBitmapDescriptor() async {
    final Uint8List imageBytes = await loadImageBytes();
    _bitmapDescriptor = BitmapDescriptor.bytes(
      imageBytes,
      width: 64,
      height: 64,
    );
  }

  @override
  Widget build(BuildContext context) {
    final driverLocations = ref.watch(driverTrackingProvider);
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,

          height: (MediaQuery.sizeOf(context).height * .85) + 10,
          child: MapView(
            markers: ref.watch(driverTrackingProvider).map((driverLocation) {
              return Marker(
                markerId: MarkerId(driverLocation.id.toString()),
                position: LatLng(
                  driverLocation.latitude,
                  driverLocation.longitude,
                ),
                rotation: 1,
                icon:
                    _bitmapDescriptor ??
                    BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue,
                    ),
                infoWindow: InfoWindow(
                  title: driverLocation.name,
                  snippet:
                      'Vel. aprox. ${driverLocation.speed.toStringAsFixed(2)} km/h',
                ),
              );
            }).toSet(),
          ),
        ),
        const SearchRoute(),
        DraggableScrollableSheet(
          minChildSize: .25,
          maxChildSize: .85,
          builder: (BuildContext context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: Colors.white,
              ),
              clipBehavior: Clip.antiAlias,
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    floating: true,
                    pinned: true,
                    snap: true,

                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    surfaceTintColor: Colors.white,
                    title: const Text(
                      'Flotas en movimiento',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(
                          Icons.gps_fixed_rounded,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          context.pushNamed(
                            AppRouterName.nearbyRoutes,
                            extra: null,
                          );
                        },
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final driverLocation = driverLocations.elementAt(index);
                      return ListTile(
                        title: Text(driverLocation.name),
                        subtitle: Text(
                          'Proxima parada: ${ref.read(driverTrackingProvider.notifier).getAssigmentByDriverId(driverLocation.id)?.nextStopId ?? 'N/A'}',
                        ),
                      );
                    }, childCount: driverLocations.length),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class TitleValue extends StatelessWidget {
  const TitleValue({super.key, required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
