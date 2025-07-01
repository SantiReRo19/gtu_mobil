import 'package:flutter/material.dart';

class RouteItem extends StatelessWidget {
  const RouteItem({
    super.key,
    this.onTap,
    required this.totalStops,
    required this.totalNeighborhoods,
    required this.description,
    required this.title,
    required this.timeRange,
  });

  final VoidCallback? onTap;
  final int totalStops;
  final int totalNeighborhoods;
  final String description;
  final String title;
  final String timeRange;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        width: double.infinity,

        constraints: const BoxConstraints(minHeight: 130, maxHeight: 150),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withValues(alpha: .2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ruta: $title',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),
                    Divider(
                      color: Theme.of(context).colorScheme.primary,
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Text(
                              '$totalNeighborhoods Barrio(s)',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.timer_rounded,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Text(
                              timeRange,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 70,
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Paradas',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Icon(
                      Icons.timeline_sharp,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 40,
                    ),
                  ),

                  Text(
                    '$totalStops',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
