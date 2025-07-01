import 'package:gtu_mobile/domain/entities/user.dart';
import 'package:gtu_mobile/domain/repositories/auth_repository.dart';
import 'package:gtu_mobile/domain/repositories/token_repositoy.dart';
import 'package:gtu_mobile/infraestructure/datasources/api/auth_datasource_remote.dart';
import 'package:gtu_mobile/infraestructure/mappers/user_mapper.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasourceRemote _authDataSource;
  final TokenRepository _tokenRepository;
  AuthRepositoryImpl(this._authDataSource, this._tokenRepository);
  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    final user = await _authDataSource.signInWithEmailAndPassword(
      email,
      password,
    );
    await _tokenRepository.saveToken(user.accessToken);
    await _tokenRepository.saveUserData(UserMapper.toEntity(user));
  }

  @override
  Future<void> signOut() async {
    await _tokenRepository.deleteToken();
    await _tokenRepository.clearUserData();
    return await _authDataSource.signOut();
  }

  @override
  Future<void> signUp(String name, String email, String password) async {
    final userData = await _authDataSource.signUp(name, email, password);
    await _tokenRepository.saveToken(userData.accessToken);
    await _tokenRepository.saveUserData(UserMapper.toEntity(userData));
  }

  @override
  Future<User> getCurrentUser() async {
    final userModel = await _tokenRepository.getUserData();
    if (userModel == null) {
      throw Exception("User not found");
    }
    return userModel;
  }

  @override
  Future<void> resetPassword(String email) async {
    return _authDataSource.resetPassword(email);
  }
}
