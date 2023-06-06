import 'dart:convert';

import 'package:easyfood/models/foods_model.dart';
import 'package:easyfood/models/user_model.dart';
import 'package:easyfood/url.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DetailMenu extends StatefulWidget {
  final FoodsModel food;
  const DetailMenu(this.food, {Key? key}) : super(key: key);

  @override
  State<DetailMenu> createState() => _DetailMenuState();
}

class _DetailMenuState extends State<DetailMenu> {
  String url = URL().getURL();

  Future<dynamic> getPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    UserModel users = UserModel(
      id: preferences.getString("id"),
      fullname: preferences.getString("fullname"),
      phone: preferences.getString("phone"),
      address: preferences.getString("address"),
    );

    return users;
  }

  addToCarts(String customersId) async {
    try {
      var response = await http.post(Uri.parse("$url/carts/create"), body: {
        "foods_id": widget.food.id,
        "customers_id": customersId,
        "quantity": "1",
      });
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
    Widget backgroundImage() {
      return Container(
        width: double.infinity,
        height: 350,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.food.image),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    Widget detail() {
      return FutureBuilder<dynamic>(
          future: getPreference(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return const Text('error');
            }
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.food.name,
                  style: GoogleFonts.sourceSansPro(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff09051C),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.food.description,
                  style: GoogleFonts.sourceSansPro(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff000000),
                    height: 1.5,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp. ',
                    decimalDigits: 0,
                  ).format(
                    double.parse(widget.food.price),
                  ),
                  style: GoogleFonts.sourceSansPro(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff09051C),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 57,
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
                      addToCarts(snapshot.data.id);
                    },
                    child: Text(
                      'Add To Cart',
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
    }

    Widget content() {
      return Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 300,
              ),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 30,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  45,
                ),
              ),
              child: detail(),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            backgroundImage(),
            content(),
          ],
        ),
      ),
    );
  }
}
