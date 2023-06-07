import 'dart:convert';

import 'package:easyfood/cubit/cart_customers_cubit.dart';
import 'package:easyfood/cubit/carts_cubit.dart';
import 'package:easyfood/cubit/tables_cubit.dart';
import 'package:easyfood/models/cart_customers_model.dart';
import 'package:easyfood/models/tables_model.dart';
import 'package:easyfood/url.dart';
import 'package:easyfood/widgets/carts_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<String> foodsId = [];
  late List<String> foodPrice = [];
  late List<String> foodQuantity = [];
  var tablesId = "2";

  String url = URL().getURL();

  @override
  void initState() {
    context.read<CartsCubit>().fetchCountCarts();
    context.read<CartCustomersCubit>().fetchCartCustomers();
    context.read<TablesCubit>().fetchTables();
    super.initState();
  }

  void storeTransactions() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      var payload = {
        "customers_id": preferences.getString("id").toString(),
        "tables_id": tablesId.toString(),
      };

      for (int i = 0; i < foodsId.length; i++) {
        payload.addAll({"foods_id[$i]": foodsId[i]});
      }

      for (int i = 0; i < foodPrice.length; i++) {
        payload.addAll({"price[$i]": foodPrice[i]});
      }

      for (int i = 0; i < foodQuantity.length; i++) {
        payload.addAll({"quantity[$i]": foodQuantity[i]});
      }

      var response = await http.post(
        Uri.parse("$url/transactions/create"),
        body: payload,
      );
      var result = json.decode(response.body);

      if (result['status'] == false) {
        _showMyDialog(result['message'], 'Mengerti', () {
          Navigator.pop(context);
        });
      } else {
        _showMyDialog(result['message'], 'OK', () {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _showMyDialog(
      String text, String subtext, Function() onPressed) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            text.toString(),
            style: GoogleFonts.sourceSansPro(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: onPressed,
              child: Text(
                subtext.toString(),
                style: GoogleFonts.sourceSansPro(
                  fontWeight: FontWeight.w700,
                  color: const Color(
                    0xff15BE77,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget carts() {
      return Container(
        margin: const EdgeInsets.only(
          top: 50,
          left: 25,
          right: 25,
          bottom: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: const Icon(Icons.arrow_back_ios_new),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  'Your Carts',
                  style: GoogleFonts.sourceSansPro(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff09051C),
                  ),
                ),
              ],
            ),
            BlocConsumer<CartCustomersCubit, CartCustomersState>(
              listener: (context, state) {
                if (state is CartCustomersFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(state.error),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is CartCustomersSuccess) {
                  foodsId = state.cartCustomer
                      .map((cartCustomer) => cartCustomer.foodsId)
                      .toList();

                  foodPrice = state.cartCustomer
                      .map((cartCustomer) => cartCustomer.foodPrice)
                      .toList();

                  foodQuantity = state.cartCustomer
                      .map((cartCustomer) => cartCustomer.quantity)
                      .toList();

                  return Expanded(
                    child: ListView(
                      children: state.cartCustomer
                          .map((CartCustomersModel cartCustomer) {
                        return CartsCard(cartCustomer);
                      }).toList(),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      );
    }

    Widget transactions() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: 25,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 20,
                ),
                child: BlocConsumer<TablesCubit, TablesState>(
                  listener: (context, state) {
                    if (state is TablesFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(state.error),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is TablesSuccess) {
                      return DropdownButton(
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        value: tablesId,
                        items: state.tables.map((TablesModel table) {
                          return DropdownMenuItem(
                            value: table.id,
                            child: Text(
                              table.name,
                              style: GoogleFonts.sourceSansPro(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            tablesId = value!;
                          });
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              Container(
                width: double.infinity,
                height: 57,
                margin: const EdgeInsets.only(top: 30),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff15BE77),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                  ),
                  onPressed: () {
                    storeTransactions();
                  },
                  child: Text(
                    'Buat Pesanan',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/pattern2.png'),
                alignment: Alignment.topRight,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          carts(),
          transactions(),
        ],
      ),
    );
  }
}
