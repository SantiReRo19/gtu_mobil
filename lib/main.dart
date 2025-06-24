import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/config/routes/app_router.dart';
import 'package:gtu_mobile/config/themes/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'GTU Movil',
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(appRouteProvider),
      theme: ref.watch(appThemeProvider),
    );
  }
}
