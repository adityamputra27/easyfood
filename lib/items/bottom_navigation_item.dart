import 'package:flutter/material.dart';

class BottomNavigationItem extends StatelessWidget {
  final String imageUrl;

  const BottomNavigationItem({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(),
          Image.asset(
            imageUrl,
            width: 24,
            height: 24,
          ),
        ],
      ),
    );
  }
}
