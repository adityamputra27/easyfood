import 'package:easyfood/cubit/page_cubit.dart';
import 'package:easyfood/home_page.dart';
import 'package:easyfood/items/bottom_navigation_item.dart';
import 'package:easyfood/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildContent(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return const HomePage();
        case 1:
          return const HomePage();
        case 2:
          return const UserPage();
        default:
          return const MainPage();
      }
    }

    Widget bottomNavigation(int currentIndex) {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomNavigationItem(
                imageUrl: 'assets/icon_home.png',
                index: 0,
                currentIndex: currentIndex,
              ),
              BottomNavigationItem(
                imageUrl: 'assets/icon_cart.png',
                index: 1,
                currentIndex: currentIndex,
              ),
              BottomNavigationItem(
                imageUrl: 'assets/icon_user.png',
                index: 2,
                currentIndex: currentIndex,
              ),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<PageCubit, int>(
      builder: (context, state) {
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
              buildContent(state),
              bottomNavigation(state),
            ],
          ),
        );
      },
    );
  }
}
