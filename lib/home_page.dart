import 'package:easyfood/cubit/categories_cubit.dart';
import 'package:easyfood/models/categories_model.dart';
import 'package:easyfood/widgets/categories_card.dart';
import 'package:easyfood/widgets/popular_menus_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<CategoriesCubit>().fetchCategories();
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
              children: const [
                PopularMenusCard(),
                PopularMenusCard(),
                PopularMenusCard(),
                PopularMenusCard(),
                PopularMenusCard(),
                PopularMenusCard(),
              ],
            ),
          ],
        ),
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
