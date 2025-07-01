import 'package:gtu_mobile/domain/entities/user.dart';
import 'package:gtu_mobile/domain/repositories/token_repositoy.dart';
import 'package:gtu_mobile/infraestructure/datasources/local/local_token_datasource.dart';
import 'package:gtu_mobile/infraestructure/mappers/user_mapper.dart';

class TokenRepositoryImpl implements TokenRepository {
  final LocalTokenDataSource _localDataSource;
  TokenRepositoryImpl(this._localDataSource);

  @override
  Future<void> deleteToken() async {
    await _localDataSource.clearToken();
  }

  @override
  Future<String> getToken() async {
    return await _localDataSource.getToken() ?? '';
  }

  @override
  Future<bool> hasToken() async {
    final token = await _localDataSource.getToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> saveToken(String token) async {
    await _localDataSource.saveToken(token);
  }

  @override
  Future<User?> getUserData() async {
    final userModel = await _localDataSource.getUserData();
    if (userModel != null) {
      return UserMapper.toEntity(userModel);
    }
    return null;
  }

  @override
  Future<void> saveUserData(User user) async {
    final userModel = UserMapper.toModel(user);
    await _localDataSource.saveUserData(userModel);
  }

  @override
  Future<void> clearUserData() {
    return _localDataSource.clearUserData();
  }
}
