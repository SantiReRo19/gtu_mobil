import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gtu_mobile/ui/auth/screens/screens.dart';
import 'package:gtu_mobile/ui/home/screen/home_screen.dart';
import 'package:gtu_mobile/ui/common/screens/splash_screen.dart';

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
        path: AppRouterName.home,
        name: AppRouterName.home,
        builder: (context, state) => const HomeScreen(),
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
    ],
  );
});

sealed class AppRouterName {
  static const splash = '/';
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const resetPassword = '/reset-password';
}
