
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Create storage instance
  final _storage = const FlutterSecureStorage();

  // Keys
  static const _tokenKey = 'jwt_token';

  // Save token
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  // Get token
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // Delete token (logout)
  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }
}
