import 'package:easyfood/cubit/carts_cubit.dart';
import 'package:easyfood/cubit/categories_cubit.dart';
import 'package:easyfood/cubit/foods_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    context.read<FoodsCubit>().fetchFoods();
    context.read<CategoriesCubit>().fetchCategories();
    context.read<CartsCubit>().fetchCountCarts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget carts() {
      return Container(
        margin: const EdgeInsets.only(
          top: 50,
          left: 25,
          right: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Carts',
              style: GoogleFonts.sourceSansPro(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xff09051C),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 20,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          spreadRadius: 0.5,
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
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/food.jpg',
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
                                'LEMPER',
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
                                NumberFormat.currency(
                                  locale: 'id',
                                  symbol: 'Rp. ',
                                  decimalDigits: 0,
                                ).format(
                                  200000,
                                ),
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
                        Container(
                          child: Icon(
                            Icons.delete,
                            size: 30,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
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
        ],
      ),
    );
  }
}
