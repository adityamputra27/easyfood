import 'package:easyfood/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesCard extends StatelessWidget {
  final CategoriesModel category;
  const CategoriesCard(
    this.category, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 18, left: 5, right: 5),
        width: 130,
        height: 60,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(
              'assets/food.jpg',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              15,
            ),
          ),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            category.name,
            style: GoogleFonts.sourceSansPro(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
