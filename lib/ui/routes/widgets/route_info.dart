import 'package:flutter/material.dart';
import 'package:gtu_mobile/domain/entities/bus_route.dart';

class RouteInfo extends StatelessWidget {
  const RouteInfo({super.key, required this.route});

  final BusRoute route;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              route.name,
              style: TextStyle(
                color: Colors.black.withValues(alpha: .8),
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              route.description,
              style: TextStyle(
                color: Colors.black.withValues(alpha: .6),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Container(
              constraints: BoxConstraints(
                maxWidth:
                    _formatTimeRange(route.startTime, route.endTime).length *
                    14.0,
              ),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: .25),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.access_time_filled_sharp, color: Colors.green),
                    SizedBox(width: 8),
                    Text(
                      _formatTimeRange(route.startTime, route.endTime),
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Divider(height: 16, color: Colors.grey),
          ],
        ),
      ),
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
