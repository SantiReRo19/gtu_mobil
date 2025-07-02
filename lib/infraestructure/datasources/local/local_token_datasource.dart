import 'package:gtu_mobile/config/constants/app_config.dart';
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
}
