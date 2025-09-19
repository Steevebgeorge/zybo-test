import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zybo_test/models/products_model.dart';

class ProductRepository {
  final String baseUrl = "https://skilltestflutter.zybotechlab.com/api";

  Future<List<ProductModel>> fetchProducts() async {
    final uri = Uri.parse("$baseUrl/products/");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      return decoded
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
          'Failed to fetch products: ${response.statusCode} ${response.body}');
    }
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    final uri = Uri.parse("$baseUrl/search/?query=$query");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      return decoded
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
          'Failed to search products: ${response.statusCode} ${response.body}');
    }
  }
}
