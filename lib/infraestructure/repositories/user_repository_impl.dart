import 'package:gtu_mobile/domain/repositories/user_repository.dart';
import 'package:gtu_mobile/infraestructure/datasources/api/user_datasource_remote.dart';
import 'package:gtu_mobile/infraestructure/datasources/local/local_token_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasourceRemote _datasource;
  final LocalTokenDataSource _localDataSource;

  UserRepositoryImpl(this._datasource, this._localDataSource);

  @override
  Future<void> updatePassword(String oldPassword, String newPassword) async {
    final userId = await _localDataSource.getUserData();
    if (userId == null) {
      throw Exception("User not found");
    }

    return _datasource.updatePassword(
      oldPassword,
      newPassword,
      userId.userId.toString(),
    );
  }
}
