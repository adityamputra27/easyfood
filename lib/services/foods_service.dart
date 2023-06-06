import 'dart:convert';

import 'package:easyfood/models/foods_model.dart';
import 'package:easyfood/url.dart';
import 'package:http/http.dart' as http;

class FoodsService {
  String url = URL().getURL();
  fetchFoods() async {
    try {
      var response = await http.get(Uri.parse("$url/foods"));
      List<dynamic> result = jsonDecode(response.body)['data'];

      List<dynamic> foods = result.map((e) {
        return FoodsModel.fromJson(e as Map<String, dynamic>);
      }).toList();

      return foods;
    } catch (e) {
      rethrow;
    }
  }
}
