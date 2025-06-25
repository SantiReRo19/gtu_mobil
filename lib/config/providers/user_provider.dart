import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/config/constants/app_config.dart';
import 'package:gtu_mobile/config/providers/auth_repository_provider.dart';
import 'package:gtu_mobile/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userProvider = StateProvider<User>((ref) {
  throw UnimplementedError('User provider is not implemented yet');
});

final initialUserProvider = FutureProvider<User?>((ref) async {
  final authRepository = ref.watch(authRepositoryProvider);
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = await authRepository.getCurrentUser();
    prefs.setString(AppConfig.userData, '');
    return user;
  } catch (e) {
    return null;
  }
});
