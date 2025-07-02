import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/config/constants/app_config.dart';
import 'package:gtu_mobile/config/providers/auth_repository_provider.dart';
import 'package:gtu_mobile/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userProvider = StateProvider<User>((ref) {
  throw UnimplementedError('User provider is not implemented yet');
});

final initialUserProvider = FutureProvider<bool>((ref) async {
  final authRepository = ref.watch(authRepositoryProvider);
  final prefs = await SharedPreferences.getInstance();
  try {
    final user = await authRepository.getCurrentUser();
    ref.watch(userProvider.notifier).state = user;
    prefs.setString(AppConfig.userData, user.toJson());
  } catch (e) {
    final userData = prefs.getString(AppConfig.userData);
    if (userData == null || userData.isEmpty) return false;
    final user = User(0, '', '').fromJson(userData);
    ref.watch(userProvider.notifier).state = user;
  }
  return true;
});

extension _UserJson on User {
  String toJson() {
    return jsonEncode({'id': id, 'name': name, 'email': email});
  }

  User fromJson(String json) {
    final Map<String, dynamic> data = jsonDecode(json);
    return User(
      data['id'] as int,
      data['name'] as String,
      data['email'] as String,
    );
  }
}
