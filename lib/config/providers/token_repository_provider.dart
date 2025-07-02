import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gtu_mobile/domain/repositories/token_repositoy.dart';
import 'package:gtu_mobile/infraestructure/datasources/local/local_token_datasource.dart';
import 'package:gtu_mobile/infraestructure/repositories/token_repository_impl.dart';

final tokenRepositoryProvider = Provider<TokenRepository>((ref) {
  final tokenRepository = LocalTokenDataSource();
  return TokenRepositoryImpl(tokenRepository);
});
