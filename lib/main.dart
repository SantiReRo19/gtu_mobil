import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/config/routes/app_router.dart';
import 'package:gtu_mobile/config/themes/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'GTU Mobile',
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(appRouteProvider),
      theme: ref.watch(appThemeProvider),
    );
  }
}
