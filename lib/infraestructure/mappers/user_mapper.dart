import 'package:gtu_mobile/domain/entities/user.dart';
import 'package:gtu_mobile/infraestructure/models/user_response.dart';

sealed class UserMapper {
  static UserModel toModel(User user) {
    return UserModel(name: user.name, email: user.email, userId: user.id);
  }

  static User toEntity(UserModel userModel) {
    return User(userModel.userId, userModel.name, userModel.email);
  }
}
