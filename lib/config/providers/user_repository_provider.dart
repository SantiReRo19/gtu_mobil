import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/config/providers/dio_provider.dart';
import 'package:gtu_mobile/domain/repositories/user_repository.dart';
import 'package:gtu_mobile/infraestructure/datasources/api/user_datasource_remote.dart';
import 'package:gtu_mobile/infraestructure/datasources/local/local_token_datasource.dart';
import 'package:gtu_mobile/infraestructure/repositories/user_repository_impl.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final userDatasource = UserDatasourceRemote(ref.watch(dioProvider));
  return UserRepositoryImpl(userDatasource, LocalTokenDataSource());
});
