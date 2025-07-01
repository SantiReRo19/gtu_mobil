import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/ui/routes/providers/route_map_provider.dart';
import 'package:gtu_mobile/ui/routes/providers/stops_provider.dart';

class StopList extends ConsumerWidget {
  const StopList({super.key, required this.routeId});
  final int routeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stops = ref.watch(stopsProvider);

    if (stops.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Text(
            'No hay paradas disponibles',
            style: TextStyle(color: Colors.black54),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final stop = stops[index];

          return ListTile(
            title: Text(stop.name),
            subtitle: Text(
              stop.description,
              style: TextStyle(color: Colors.black.withValues(alpha: .6)),
            ),
            leading: Icon(Icons.bus_alert_rounded),
            trailing: Icon(Icons.location_on_rounded),
            onTap: () {
              ref
                  .read(routeMapProvider)
                  .moveCamera(stop.latitude, stop.longitude);
            },
          );
        }, childCount: stops.length),
      ),
    );
  }
}
