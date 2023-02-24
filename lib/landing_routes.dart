import 'package:flutter/material.dart';
import 'package:toolmart/screens/landing/landing_screen.dart';

class LandingRoutes {
  static Map<String, Widget Function(BuildContext context)> routes = {
    LandingScreen.id: (context) => const LandingScreen(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // final name = settings.name ?? '';

    // switch-case for screens here

    return null;
  }
}
