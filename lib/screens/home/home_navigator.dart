import 'package:flutter/material.dart';
import 'package:toolmart/screens/cart/cart_screen.dart';
import 'package:toolmart/screens/cart/checkout_screen.dart';
import 'package:toolmart/screens/cart/payment_success_screen.dart';
import 'package:toolmart/screens/home/home_overlay.dart';
import 'package:toolmart/screens/home/home_screen.dart';
import 'package:toolmart/screens/item/item_screen.dart';
import 'package:toolmart/screens/user/user_screen.dart';
import 'package:toolmart/toolmart_app.dart';
import 'package:provider/provider.dart';

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({
    super.key,
    this.initialRoute,
  });

  final String? initialRoute;

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    late Widget page;

    switch (settings.name) {
      case '/':
      case '/dashboard':
        return null;
      case HomeScreen.id:
        page = const HomeOverlay(initialPage: 0);
        break;
      case UserScreen.id:
        page = const HomeOverlay(initialPage: 1);
        break;
      case ItemScreen.id:
        page = const ItemScreen();
        break;
      case CartScreen.id:
        page = const CartScreen();
        break;
      case CheckoutScreen.id:
        page = const CheckoutScreen();
        break;
      case PaymentSuccessScreen.id:
        page = const PaymentSuccessScreen();
        break;
    }

    return MaterialPageRoute(
      builder: (context) => page,
      settings: settings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // page notifier for HomeOverlay
      create: (context) => ValueNotifier<int>(0),
      child: Navigator(
        key: homeNavKey,
        onGenerateRoute: onGenerateRoute,
        initialRoute: HomeScreen.id,
      ),
    );
  }
}
