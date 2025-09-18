import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zybo_test/models/banner_model.dart';

Future<List<BannerModel>> fetchBanners() async {
  final response = await http.get(
    Uri.parse("https://skilltestflutter.zybotechlab.com/api/banners/"),
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((item) => BannerModel.fromJson(item)).toList();
  } else {
    throw Exception("Failed to load banners");
  }
}
