abstract class UserRepository {
  Future<void> updatePassword(String oldPassword, String newPassword);
}
