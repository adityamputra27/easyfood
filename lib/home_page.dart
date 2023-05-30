import 'package:easyfood/items/bottom_navigation_item.dart';
import 'package:easyfood/widgets/categories_card.dart';
import 'package:easyfood/widgets/popular_menus_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoriesCard(),
                  CategoriesCard(),
                  CategoriesCard(),
                  CategoriesCard(),
                ],
              ),
            ),
          ],
        ),
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

    Widget bottomNavigation() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                spreadRadius: 0.5,
                blurRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          margin: const EdgeInsets.only(
            bottom: 15,
            left: 25,
            right: 25,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomNavigationItem(
                imageUrl: 'assets/icon_home.png',
              ),
              BottomNavigationItem(
                imageUrl: 'assets/icon_cart.png',
              ),
              BottomNavigationItem(
                imageUrl: 'assets/icon_user.png',
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
          ListView(
            children: [
              header(),
              filters(),
              categories(),
              menus(),
            ],
          ),
          bottomNavigation(),
        ],
      ),
    );
  }
}
