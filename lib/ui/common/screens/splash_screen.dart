import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/config/providers/bus_route_repository_provider.dart';
import 'package:gtu_mobile/config/routes/app_router.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  Future<void> _initializeApp(WidgetRef ref) async {
    try {
      await ref.read(busRouteRepositoryProvider).getAllNeighborhoods();
      ref.read(appRouteProvider).goNamed(AppRouterName.busFleet);
    } catch (e) {
      ref.invalidate(busRouteRepositoryProvider);
      ref.read(appRouteProvider).goNamed(AppRouterName.login);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.microtask(() => _initializeApp(ref));

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text(
              'Bienvenido a GTU Mobile',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
