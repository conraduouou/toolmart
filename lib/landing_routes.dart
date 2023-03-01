import 'package:flutter/material.dart';
import 'package:toolmart/screens/home/home_navigator.dart';
import 'package:toolmart/screens/home/home_overlay.dart';
import 'package:toolmart/screens/home/home_screen.dart';
import 'package:toolmart/screens/landing/landing_screen.dart';

class LandingRoutes {
  static Map<String, Widget Function(BuildContext context)> routes = {
    LandingScreen.id: (context) => const LandingScreen(),
    HomeScreen.id: (context) => const HomeNavigator(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final name = settings.name ?? '';

    if (name.startsWith(HomeOverlay.id)) {
      final subRoute = name.substring(HomeOverlay.id.length);

      return MaterialPageRoute(
        builder: (context) => HomeNavigator(initialRoute: subRoute),
        settings: settings,
      );
    }

    return null;
  }
}
