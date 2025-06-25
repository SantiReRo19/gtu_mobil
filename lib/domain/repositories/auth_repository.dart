import 'package:gtu_mobile/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<void> signUp(User user);
}
