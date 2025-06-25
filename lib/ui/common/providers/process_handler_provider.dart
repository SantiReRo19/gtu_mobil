import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/config/routes/app_router.dart';
import 'package:gtu_mobile/ui/common/handlers/process_handler.dart';

final processHandlerProvider = Provider<ProcessHandler>((ref) {
  final context = ref
      .watch(appRouteProvider)
      .configuration
      .navigatorKey
      .currentContext!;
  return ProcessHandler(context);
});
