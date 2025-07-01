import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/ui/routes/providers/routes_provider.dart';
import 'package:gtu_mobile/ui/routes/widgets/neighborhood_list.dart';
import 'package:gtu_mobile/ui/routes/widgets/routes_list.dart';
import 'package:gtu_mobile/ui/routes/widgets/routes_search.dart';

class RoutesScreen extends StatelessWidget {
  const RoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rutas',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.left,
                  ),
                  const RoutesSearch(),
                ],
              ),
            ),
          ),
        ),
        const NeighborhoodList(),
        const SizedBox(height: 16),
        Consumer(
          builder: (context, ref, _) {
            final routes = ref.watch(routesProvider);
            return Expanded(
              child: CustomScrollView(slivers: [RouteList(routes: routes)]),
            );
          },
        ),
      ],
    );
  }
}
