import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/config/providers/dio_provider.dart';
import 'package:gtu_mobile/config/providers/token_repository_provider.dart';
import 'package:gtu_mobile/domain/repositories/auth_repository.dart';
import 'package:gtu_mobile/infraestructure/datasources/api/auth_datasource_remote.dart';
import 'package:gtu_mobile/infraestructure/repositories/auth_repository_impl.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final authDatasource = AuthDatasourceRemote(dio);
  final tokenRepository = ref.watch(tokenRepositoryProvider);
  return AuthRepositoryImpl(authDatasource, tokenRepository);
});
