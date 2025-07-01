import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/ui/routes/widgets/routes_list.dart';
import 'package:gtu_mobile/ui/tracking/providers/nearby_route_provider.dart';

class NearbyRouteScreen extends ConsumerStatefulWidget {
  const NearbyRouteScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });
  final double? latitude;
  final double? longitude;

  @override
  ConsumerState<NearbyRouteScreen> createState() => _NearbyRouteScreenState();
}

class _NearbyRouteScreenState extends ConsumerState<NearbyRouteScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref
          .read(nearbyRouteProvider.notifier)
          .init(widget.latitude, widget.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(nearbyRouteProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Rutas Cercanas')),
      body: CustomScrollView(
        slivers: [
          if (state == null)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Buscando rutas cercanas...'),
                  ],
                ),
              ),
            )
          else
            RouteList(routes: state),
        ],
      ),
    );
  }
}
