import 'dart:convert';

import 'package:easyfood/cubit/cart_customers_cubit.dart';
import 'package:easyfood/models/cart_customers_model.dart';
import 'package:easyfood/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CartsCard extends StatefulWidget {
  final CartCustomersModel cart;
  const CartsCard(
    this.cart, {
    super.key,
  });

  @override
  State<CartsCard> createState() => _CartsCardState();
}

class _CartsCardState extends State<CartsCard> {
  @override
  Widget build(BuildContext context) {
    String url = URL().getURL();

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

    void deleteCart(String id) async {
      try {
        var response = await http.delete(Uri.parse("$url/carts/delete/$id"));
        var result = json.decode(response.body);

        if (result['status'] == false) {
          _showMyDialog(result['message'], 'Mengerti', () {
            Navigator.pop(context);
          });
        } else {
          _showMyDialog(result['message'], 'OK', () {
            Navigator.pop(context);
            context.read<CartCustomersCubit>().fetchCartCustomers();
          });
        }
      } catch (e) {
        print(e);
      }
    }

    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 20,
        bottom: 10,
      ),
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 0.75,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 75,
            margin: const EdgeInsets.only(
              right: 15,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(
                  widget.cart.foodImage,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.cart.foodName,
                  style: GoogleFonts.sourceSansPro(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff09051C),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "x ${widget.cart.quantity}",
                  style: GoogleFonts.sourceSansPro(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xff3B3B3B),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              deleteCart(widget.cart.id);
            },
            child: const Icon(
              Icons.delete,
              size: 30,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
