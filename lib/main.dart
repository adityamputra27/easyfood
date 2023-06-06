import 'package:easyfood/cubit/carts_cubit.dart';
import 'package:easyfood/cubit/categories_cubit.dart';
import 'package:easyfood/cubit/foods_cubit.dart';
import 'package:easyfood/cubit/page_cubit.dart';
import 'package:easyfood/main_page.dart';
import 'package:easyfood/login_page.dart';
import 'package:easyfood/register_page.dart';
import 'package:easyfood/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageCubit(),
        ),
        BlocProvider(
          create: (context) => FoodsCubit(),
        ),
        BlocProvider(
          create: (context) => CategoriesCubit(),
        ),
        BlocProvider(
          create: (context) => CartsCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => const MainPage(),
        },
      ),
    );
  }
}
