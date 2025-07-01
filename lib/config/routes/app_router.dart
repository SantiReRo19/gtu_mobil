import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gtu_mobile/domain/entities/bus_route.dart';
import 'package:gtu_mobile/ui/auth/screens/screens.dart';
import 'package:gtu_mobile/ui/home/screen/home_screen.dart';
import 'package:gtu_mobile/ui/common/screens/splash_screen.dart';
import 'package:gtu_mobile/ui/profile/screens/profile_screen.dart';
import 'package:gtu_mobile/ui/profile/screens/update_password_screen.dart';
import 'package:gtu_mobile/ui/routes/screens/route_details.dart';
import 'package:gtu_mobile/ui/routes/screens/routes_screen.dart';
import 'package:gtu_mobile/ui/tracking/screens/bus_fleet_screen.dart';
import 'package:gtu_mobile/ui/tracking/screens/nearby_route_screen.dart';

final appRouteProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRouterName.splash,
    routes: [
      GoRoute(
        path: AppRouterName.splash,
        name: AppRouterName.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: AppRouterName.login,
        name: AppRouterName.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRouterName.register,
        name: AppRouterName.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRouterName.resetPassword,
        name: AppRouterName.resetPassword,
        builder: (context, state) => const ResetPasswordScreen(),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouterName.busFleet,
                name: AppRouterName.busFleet,
                builder: (context, state) => const BusFleetScreen(),
                routes: [
                  GoRoute(
                    path: AppRouterName.nearbyRoutes,
                    name: AppRouterName.nearbyRoutes,
                    builder: (context, state) {
                      final args = state.extra as List<double>?;
                      return NearbyRouteScreen(
                        latitude: args?[0],
                        longitude: args?[1],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouterName.routes,
                name: AppRouterName.routes,
                builder: (context, state) => const RoutesScreen(),
                routes: [
                  GoRoute(
                    path: AppRouterName.routesDetail,
                    name: AppRouterName.routesDetail,
                    builder: (context, state) {
                      final route = state.extra as BusRoute;
                      return RouteDetails(route: route);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouterName.profile,
                name: AppRouterName.profile,
                builder: (context, state) => const ProfileScreen(),
                routes: [
                  GoRoute(
                    path: AppRouterName.updatePassword,
                    name: AppRouterName.updatePassword,
                    builder: (context, state) {
                      return const UpdatePasswordScreen();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

sealed class AppRouterName {
  static const splash = '/';
  static const busFleet = '/bus-fleet';
  static const nearbyRoutes = 'nearby-routes';

  // Routes
  static const routes = '/routes';
  static const routesDetail = 'details';

  // Profile
  static const profile = '/profile';
  static const updatePassword = 'update-password';

  // Authentication routes
  static const login = '/login';
  static const register = '/register';
  static const resetPassword = '/reset-password';
}
