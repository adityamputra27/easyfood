import 'package:easyfood/cubit/page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationItem extends StatelessWidget {
  final String imageUrl;
  final int currentIndex;
  final int index;

  const BottomNavigationItem({
    super.key,
    required this.imageUrl,
    required this.currentIndex,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<PageCubit>().setPage(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(),
          Image.asset(
            imageUrl,
            width: 24,
            height: 24,
            color: currentIndex == index
                ? const Color.fromARGB(255, 47, 182, 99)
                : const Color(0xffA8F3C4),
          ),
        ],
      ),
    );
  }
}
