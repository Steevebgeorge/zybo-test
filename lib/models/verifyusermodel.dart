class VerifyUserModel {
  final String otp;
  final bool isUser;
  final String? token;

  VerifyUserModel({
    required this.otp,
    required this.isUser,
    this.token,
  });

  factory VerifyUserModel.fromJson(Map<String, dynamic> json) {
    return VerifyUserModel(
      otp: json["otp"],
      isUser: json["user"],
      token: json["user"] ? json["token"]["access"] : null,
    );
  }
}

// verify user