import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/domain/entities/bus_route.dart';
import 'package:gtu_mobile/ui/common/views/map_view.dart';
import 'package:gtu_mobile/ui/routes/providers/route_map_provider.dart';
import 'package:gtu_mobile/ui/routes/providers/stops_provider.dart';
import 'package:gtu_mobile/ui/routes/widgets/route_info.dart';
import 'package:gtu_mobile/ui/routes/widgets/stop_list.dart';

class RouteDetails extends ConsumerStatefulWidget {
  const RouteDetails({super.key, required this.route});
  final BusRoute route;

  @override
  ConsumerState<RouteDetails> createState() => _RouteDetailsState();
}

class _RouteDetailsState extends ConsumerState<RouteDetails> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(stopsProvider.notifier).init(widget.route.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: (height * .8) + 10,
            child: MapView(
              markers: ref.watch(routeMapProvider).createMarkers((index) {
                final stops = ref.read(stopsProvider);
                return MarkerData(
                  id: stops[index].id.toString(),
                  latitude: stops[index].latitude,
                  longitude: stops[index].longitude,
                  title: stops[index].name,
                  description: stops[index].description,
                );
              }, ref.watch(stopsProvider).length),
              onMapCreated: ref.watch(routeMapProvider).init,
            ),
          ),

          Positioned(
            top: 40,
            left: 10,

            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_sharp),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                iconSize: 30,
              ),
            ),
          ),

          DraggableScrollableSheet(
            minChildSize: .2,
            maxChildSize: .75,
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
                    RouteInfo(route: widget.route),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Paradas de la ruta',
                          style: TextStyle(
                            color: Colors.black.withValues(alpha: .8),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    StopList(routeId: widget.route.id),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
