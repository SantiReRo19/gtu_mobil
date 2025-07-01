class UserResponse {
  String message;
  UserModel data;
  int status;

  UserResponse({
    required this.message,
    required this.data,
    required this.status,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    message: json["message"],
    data: UserModel.fromJson(json["data"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
    "status": status,
  };
}

class UserModel {
  String accessToken;
  int userId;
  String name;
  String email;
  String role;

  UserModel({
    this.accessToken = '',
    required this.userId,
    required this.name,
    required this.email,
    this.role = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    accessToken: json["accessToken"],
    userId: json["userId"],
    name: json["name"],
    email: json["email"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "userId": userId,
    "name": name,
    "email": email,
    "role": role,
  };
}
