import 'package:gtu_mobile/domain/entities/user.dart';

abstract class TokenRepository {
  Future<String> getToken();
  Future<void> saveToken(String token);
  Future<void> deleteToken();
  Future<bool> hasToken();
  Future<User?> getUserData();
  Future<void> saveUserData(User user);
  Future<void> clearUserData();
}
