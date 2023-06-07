import 'dart:convert';

import 'package:easyfood/models/cart_customers_model.dart';
import 'package:easyfood/models/carts_model.dart';
import 'package:easyfood/url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartsService {
  String url = URL().getURL();

  Future<CartsModel> fetchCountCarts() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var customersId = preferences.getString("id");
      var response =
          await http.get(Uri.parse("$url/carts/customer/$customersId"));
      var result = jsonDecode(response.body)['data'];

      CartsModel cartsModel = CartsModel.fromJson(result);
      return cartsModel;
    } catch (e) {
      rethrow;
    }
  }

  fetchCartCustomers() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var customersId = preferences.getString("id");
      var response =
          await http.get(Uri.parse("$url/carts/customer/$customersId"));
      List<dynamic> result = jsonDecode(response.body)['data']['carts'];

      List<dynamic> cartCustomer = result.map((e) {
        return CartCustomersModel.fromJson(e as Map<String, dynamic>);
      }).toList();

      return cartCustomer;
    } catch (e) {
      rethrow;
    }
  }
}
