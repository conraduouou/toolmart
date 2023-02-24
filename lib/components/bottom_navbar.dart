import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: 80,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 1,
            color: Colors.black.withAlpha((1 / 10 * 255).floor()),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            'assets/icons/ic-home.svg',
          ),
          SvgPicture.asset(
            'assets/icons/ic-user.svg',
          ),
          SvgPicture.asset(
            'assets/icons/ic-cart.svg',
          ),
        ],
      ),
    );
  }
}
