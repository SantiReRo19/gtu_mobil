import 'package:gtu_mobile/domain/entities/user.dart';

abstract class AuthRepository {
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<void> signUp(String name, String email, String password);
  Future<User> getCurrentUser();
}
