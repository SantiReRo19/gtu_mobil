import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gtu_mobile/ui/auth/screens/login_screen.dart';

final appRouteProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRouterName.login,
    routes: [
      GoRoute(
        path: AppRouterName.login,
        name: AppRouterName.login,
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
});

sealed class AppRouterName {
  static const login = '/login';
  static const register = 'register';
}
