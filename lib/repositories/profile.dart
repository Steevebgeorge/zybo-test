import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zybo_test/constants/secure_storage.dart';

class ProfileRepository {
  final SecureStorageService _storageService = SecureStorageService();

  Future<Map<String, dynamic>?> fetchUserData() async {
    try {
      final token = await _storageService.getToken();

      if (token == null) return null;

      final response = await http.get(
        Uri.parse("https://skilltestflutter.zybotechlab.com/api/user-data/"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception("Failed to load user data: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
