import 'package:easyfood/cart_page.dart';
import 'package:easyfood/cubit/carts_cubit.dart';
import 'package:easyfood/cubit/categories_cubit.dart';
import 'package:easyfood/cubit/foods_cubit.dart';
import 'package:easyfood/models/categories_model.dart';
import 'package:easyfood/models/foods_model.dart';
import 'package:easyfood/user_page.dart';
import 'package:easyfood/widgets/categories_card.dart';
import 'package:easyfood/widgets/popular_menus_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<FoodsCubit>().fetchFoods();
    context.read<CategoriesCubit>().fetchCategories();
    context.read<CartsCubit>().fetchCountCarts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(
          left: 25,
          right: 25,
          top: 35,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find Your\nFavorite Food',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff09051C),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                );
              },
              child: badges.Badge(
                badgeContent: SizedBox(
                  width: 15,
                  height: 15,
                  child: BlocConsumer<CartsCubit, CartsState>(
                    listener: (context, state) {
                      if (state is CartsFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.redAccent,
                            content: Text(state.error),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is CartsSuccess) {
                        return Center(
                          child: Text(
                            state.carts.total,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
                child: const Icon(
                  Icons.shopping_cart,
                  size: 40,
                  color: Color.fromARGB(255, 47, 182, 99),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget filters() {
      return Container(
        margin: const EdgeInsets.only(
          top: 18,
          left: 25,
          right: 25,
        ),
        width: double.infinity,
        child: Column(
          children: [
            TextField(
              style: GoogleFonts.roboto(
                color: const Color.fromARGB(255, 232, 153, 104),
                letterSpacing: 0.5,
              ),
              decoration: InputDecoration(
                hintText: 'What do you want to order?',
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 232, 153, 104),
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 241, 226),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Color(0xffF4F4F4),
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Color(0xffF4F4F4),
                    width: 1,
                  ),
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 232, 153, 104),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget categories() {
      return BlocConsumer<CategoriesCubit, CategoriesState>(
        listener: (context, state) {
          if (state is CategoriesFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CategoriesSuccess) {
            return Container(
              margin: const EdgeInsets.only(
                top: 30,
                left: 25,
                right: 25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff09051C),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          state.categories.map((CategoriesModel category) {
                        return CategoriesCard(category);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: Container(
              margin: const EdgeInsets.only(
                top: 30,
              ),
              child: const CircularProgressIndicator(
                color: Color.fromARGB(255, 47, 182, 99),
              ),
            ),
          );
        },
      );
    }

    Widget menus() {
      return BlocConsumer<FoodsCubit, FoodsState>(
        listener: (context, state) {
          if (state is FoodsFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is FoodsSuccess) {
            return Container(
              margin: const EdgeInsets.only(
                top: 30,
                left: 25,
                right: 25,
                bottom: 90,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Popular Menu',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff09051C),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  StaggeredGrid.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: state.foods.map((FoodsModel food) {
                      return PopularMenusCard(food);
                    }).toList(),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: Container(
              margin: const EdgeInsets.only(
                top: 30,
              ),
              child: const CircularProgressIndicator(
                color: Color.fromARGB(255, 47, 182, 99),
              ),
            ),
          );
        },
      );
    }

    return ListView(
      children: [
        header(),
        filters(),
        categories(),
        menus(),
      ],
    );
  }
}
