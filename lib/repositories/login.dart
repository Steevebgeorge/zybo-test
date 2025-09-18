import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:zybo_test/constants/secure_storage.dart';
import 'package:zybo_test/models/loginmodel.dart';

class LoginRepository {
  final String baseUrl =
      "https://skilltestflutter.zybotechlab.com/api"; // ✅ use HTTPS

  Future<LoginModel> loginUser(String phoneNumber) async {
    final url = Uri.parse("$baseUrl/login-register/");

    final response = await http.post(
      url,
      body: {
        "phone_number": phoneNumber,
        // API also expects `first_name` when registering
      },
    );

    log("Login Status: ${response.statusCode}");
    log("Login Body: ${response.body}");

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final loginModel = LoginModel.fromJson(decoded);
      final storage = SecureStorageService();
      await storage.saveToken(loginModel.accessToken);
      log(loginModel.accessToken);
      return loginModel;
    } else {
      throw Exception("Login failed: ${response.body}");
    }
  }
}
