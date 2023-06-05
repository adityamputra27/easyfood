import 'dart:convert';

import 'package:easyfood/models/categories_model.dart';
import 'package:easyfood/url.dart';
import 'package:http/http.dart' as http;

class CategoriesService {
  String url = URL().getURL();
  fetchCategories() async {
    try {
      var response = await http.get(Uri.parse("$url/categories"));
      List<dynamic> result = jsonDecode(response.body)['data'];

      List<dynamic> categories = result.map((e) {
        return CategoriesModel.fromJson(e as Map<String, dynamic>);
      }).toList();

      return categories;
    } catch (e) {
      rethrow;
    }
  }
}
