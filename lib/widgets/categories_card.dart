import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 18, left: 8, right: 8),
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
              5,
            ),
          ),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            'Cake',
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
