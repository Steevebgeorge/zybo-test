import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:zybo_test/models/verifyusermodel.dart';

class VerifyRepository {
  final String baseUrl = "https://skilltestflutter.zybotechlab.com/api";

  Future<VerifyUserModel> verifyUser(String phoneNumber) async {
    final url = Uri.parse("$baseUrl/verify/");

    final response = await http.post(
      url,
      body: {"phone_number": phoneNumber},
    );

    log("Status: ${response.statusCode}");
    log("Body: ${response.body}");

    if (response.statusCode == 200) {
      return VerifyUserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to verify user: ${response.body}");
    }
  }
}
