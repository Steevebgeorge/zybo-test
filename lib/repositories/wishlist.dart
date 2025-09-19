import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:zybo_test/models/products_model.dart';

class WishlistRepository {
  final String baseUrl =
      "https://skilltestflutter.zybotechlab.com/api/wishlist/";
  final _storage = const FlutterSecureStorage();

  Future<String?> _getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  Future<List<ProductModel>> fetchWishlist() async {
    final token = await _getToken();
    if (token == null) throw Exception("User not authenticated");

    final uri = Uri.parse(baseUrl);
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );

    print("Wishlist response: ${response.body}");

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      final List<dynamic> productsJson =
          decoded is List ? decoded : decoded['wishlist'] ?? [];

      final products = productsJson
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return products;
    } else {
      throw Exception("Failed to fetch wishlist: ${response.body}");
    }
  }

  Future<void> toggleWishlist(int productId) async {
    final token = await _getToken();
    if (token == null) throw Exception("User not authenticated");

    final uri = Uri.parse(baseUrl);
    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"product_id": productId}),
    );

    print("Toggle Wishlist response: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Failed to update wishlist: ${response.body}");
    }
  }
}
