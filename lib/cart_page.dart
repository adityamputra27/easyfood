import 'package:easyfood/cubit/cart_customers_cubit.dart';
import 'package:easyfood/cubit/carts_cubit.dart';
import 'package:easyfood/models/cart_customers_model.dart';
import 'package:easyfood/widgets/carts_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    context.read<CartsCubit>().fetchCountCarts();
    context.read<CartCustomersCubit>().fetchCartCustomers();
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
