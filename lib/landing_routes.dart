import 'package:flutter/material.dart';
import 'package:toolmart/screens/home/home_screen.dart';
import 'package:toolmart/screens/item/item_screen.dart';
import 'package:toolmart/screens/landing/landing_screen.dart';
import 'package:toolmart/screens/user/user_screen.dart';

class LandingRoutes {
  static Map<String, Widget Function(BuildContext context)> routes = {
    LandingScreen.id: (context) => const LandingScreen(),
    HomeScreen.id: (context) => const HomeScreen(),
    UserScreen.id: (context) => const UserScreen(),
    ItemScreen.id: (context) => const ItemScreen(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // final name = settings.name ?? '';

    // switch-case for screens here

    return null;
  }
}
