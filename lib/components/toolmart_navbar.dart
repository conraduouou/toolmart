import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/on_tap_wrapper.dart';
import 'package:toolmart/screens/cart/cart_screen.dart';

class ToolMartNavBar extends StatelessWidget {
  const ToolMartNavBar({
    super.key,
    required this.activePage,
    this.onHomeTap,
    this.onUserTap,
  });

  final int activePage;
  final VoidCallback? onHomeTap;
  final VoidCallback? onUserTap;

  static final _activeFilter = ColorFilter.mode(
    kPrimaryColor.shade60,
    BlendMode.srcATop,
  );

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
          OnTapWrapper(
            onTap: onHomeTap,
            child: SizedBox(
              width: size.width / 3,
              child: SvgPicture.asset(
                'assets/icons/ic-home.svg',
                colorFilter: activePage == 0 ? _activeFilter : null,
              ),
            ),
          ),
          OnTapWrapper(
            onTap: onUserTap,
            child: SizedBox(
              width: size.width / 3,
              child: SvgPicture.asset(
                'assets/icons/ic-user.svg',
                colorFilter: activePage == 1 ? _activeFilter : null,
              ),
            ),
          ),
          OnTapWrapper(
            onTap: () => Navigator.of(context).pushNamed(CartScreen.id),
            child: SizedBox(
              width: size.width / 3,
              child: SvgPicture.asset(
                'assets/icons/ic-cart.svg',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
