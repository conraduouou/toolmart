import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/screens/home/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const id = '/home';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: kSecondaryColor.shade40,
        bottomNavigationBar: const _HomeNavBar(),
        body: const HomeBody(),
      ),
    );
  }
}

class _HomeNavBar extends StatelessWidget {
  const _HomeNavBar();

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
