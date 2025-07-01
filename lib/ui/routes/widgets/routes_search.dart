import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gtu_mobile/config/routes/app_router.dart';
import 'package:gtu_mobile/domain/entities/bus_route.dart';
import 'package:gtu_mobile/ui/routes/providers/routes_provider.dart';

class RoutesSearch extends ConsumerWidget {
  const RoutesSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
      onPressed: () {
        RouteSearchDelegate.search(
          context,
          ref.read(routesProvider.notifier).routes,
        );
      },
    );
  }
}

class RouteSearchDelegate extends SearchDelegate {
  RouteSearchDelegate(this.routes)
    : super(
        searchFieldLabel: 'Buscar rutas',
        textInputAction: TextInputAction.search,
      );
  final List<BusRoute> routes;

  static void search(BuildContext context, List<BusRoute> routes) {
    showSearch(context: context, delegate: RouteSearchDelegate(routes));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredRoutes = routes
        .where(
          (route) =>
              route.name.toLowerCase().contains(query.toLowerCase()) ||
              route.description.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    if (filteredRoutes.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No se encontraron rutas que coincidan con "$query".',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredRoutes.length,
      itemBuilder: (context, index) {
        final route = filteredRoutes[index];
        return ListTile(
          title: Text(route.name),
          subtitle: Text(route.description),
          leading: Icon(Icons.timeline_rounded),
          onTap: () {
            query = route.name;
            context.pushNamed(AppRouterName.routesDetail, extra: route);
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredRoutes = routes
        .where(
          (route) =>
              route.name.toLowerCase().contains(query.toLowerCase()) ||
              route.description.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    return ListView.builder(
      itemCount: filteredRoutes.length,
      itemBuilder: (context, index) {
        final route = filteredRoutes[index];
        return ListTile(
          title: Text(route.name),
          subtitle: Text(route.description),
          onTap: () {
            context.pushNamed(AppRouterName.routesDetail, extra: route);
          },
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }
}
