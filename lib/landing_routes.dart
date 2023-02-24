import 'package:flutter/material.dart';
import 'package:toolmart/screens/home/home_screen.dart';
import 'package:toolmart/screens/landing/landing_screen.dart';

class LandingRoutes {
  static Map<String, Widget Function(BuildContext context)> routes = {
    LandingScreen.id: (context) => const LandingScreen(),
    HomeScreen.id: (context) => const HomeScreen(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // final name = settings.name ?? '';

    // switch-case for screens here

    return null;
  }
}
