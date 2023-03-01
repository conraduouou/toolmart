import 'package:flutter/material.dart';
import 'package:toolmart/screens/cart/cart_screen.dart';
import 'package:toolmart/screens/cart/checkout_screen.dart';
import 'package:toolmart/screens/cart/payment_success_screen.dart';
import 'package:toolmart/screens/home/dashboard_overlay.dart';
import 'package:toolmart/screens/home/home_screen.dart';
import 'package:toolmart/screens/item/item_screen.dart';
import 'package:toolmart/screens/landing/landing_screen.dart';
import 'package:toolmart/screens/user/user_screen.dart';

class LandingRoutes {
  static Map<String, Widget Function(BuildContext context)> routes = {
    LandingScreen.id: (context) => const LandingScreen(),
    HomeScreen.id: (context) => const DashboardOverlay(),
    UserScreen.id: (context) => const UserScreen(),
    ItemScreen.id: (context) => const ItemScreen(),
    CartScreen.id: (context) => const CartScreen(),
    CheckoutScreen.id: (context) => const CheckoutScreen(),
    PaymentSuccessScreen.id: (context) => const PaymentSuccessScreen(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // final name = settings.name ?? '';

    // switch-case for screens here

    return null;
  }
}
