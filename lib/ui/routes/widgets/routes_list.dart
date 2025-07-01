import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gtu_mobile/config/routes/app_router.dart';
import 'package:gtu_mobile/domain/entities/bus_route.dart';
import 'package:gtu_mobile/ui/routes/widgets/route_item.dart';

class RouteList extends StatelessWidget {
  const RouteList({super.key, required this.routes});
  final List<BusRoute> routes;

  @override
  Widget build(BuildContext context) {
    if (routes.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Text(
            'Aún no hay rutas disponibles',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final route = routes[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: RouteItem(
            totalStops: route.stops.length,
            totalNeighborhoods: route.neighborhoods.length,
            description: route.description,
            title: route.name,
            timeRange: _formatTimeRange(route.startTime, route.endTime),
            onTap: () {
              context.pushNamed(AppRouterName.routesDetail, extra: route);
            },
          ),
        );
      }, childCount: routes.length),
    );
  }

  String _formatTimeRange(DateTime start, DateTime end) {
    final startTime =
        '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}';
    final endTime =
        '${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}';
    return '$startTime - $endTime';
  }
}
