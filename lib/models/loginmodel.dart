class LoginModel {
  final String accessToken;
  final String userId;
  final String message;

  LoginModel({
    required this.accessToken,
    required this.userId,
    required this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json["token"]["access"] ?? "",
      userId: json["user_id"] ?? "",
      message: json["message"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "token": {
        "access": accessToken,
      },
      "user_id": userId,
      "message": message,
    };
  }
}


//to login user