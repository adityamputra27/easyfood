import 'dart:convert';

import 'package:easyfood/models/tables_model.dart';
import 'package:easyfood/url.dart';
import 'package:http/http.dart' as http;

class TablesService {
  String url = URL().getURL();
  fetchTables() async {
    try {
      var response = await http.get(Uri.parse("$url/tables"));
      List<dynamic> result = jsonDecode(response.body)['data'];

      List<dynamic> categories = result.map((e) {
        return TablesModel.fromJson(e as Map<String, dynamic>);
      }).toList();

      return categories;
    } catch (e) {
      rethrow;
    }
  }
}
