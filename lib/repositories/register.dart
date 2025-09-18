import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:zybo_test/constants/secure_storage.dart';
import 'package:zybo_test/models/registermodel.dart';

class RegisterUserRepository {
  final String baseUrl = "https://skilltestflutter.zybotechlab.com/api";

  Future<RegisterUserModel> registerUser(
      String phoneNumber, String firstName) async {
    final url = Uri.parse("$baseUrl/login-register/");
    final response = await http.post(url, body: {
      "phone_number": phoneNumber,
      "first_name": firstName,
    });
    log('register status : ${response.statusCode}');
    log('register body : ${response.body}');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final registerModel = RegisterUserModel.fromJson(decoded);
      final storage = SecureStorageService();
      await storage.saveToken(registerModel.token.access);
      log(registerModel.token.access);
      return registerModel;
    } else {
      throw Exception("Login failed: ${response.body}");
    }
  }
}
