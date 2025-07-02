import 'package:gtu_mobile/domain/repositories/token_repositoy.dart';
import 'package:gtu_mobile/infraestructure/datasources/local/local_token_datasource.dart';

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
}
