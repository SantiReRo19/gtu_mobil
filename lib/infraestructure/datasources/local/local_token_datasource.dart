import 'dart:convert';

import 'package:gtu_mobile/config/constants/app_config.dart';
import 'package:gtu_mobile/infraestructure/models/user_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalTokenDataSource {
  late SharedPreferences _preferences;
  LocalTokenDataSource() {
    init();
  }

  void init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> clearToken() {
    return _preferences.remove(AppConfig.accessToken);
  }

  Future<String?> getToken() async {
    return _preferences.getString(AppConfig.accessToken);
  }

  Future<void> saveToken(String token) async {
    await _preferences.setString(AppConfig.accessToken, token);
  }

  Future<UserModel?> getUserData() async {
    final userJson = _preferences.getString(AppConfig.userData);
    if (userJson != null) {
      return UserModel.fromJson(json.decode(userJson));
    }
    return null;
  }

  Future<void> saveUserData(UserModel user) async {
    await _preferences.setString(
      AppConfig.userData,
      json.encode(user.toJson()),
    );
  }

  Future<void> clearUserData() async {
    await _preferences.remove(AppConfig.userData);
  }
}
