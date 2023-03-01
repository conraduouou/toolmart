import 'package:flutter/material.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/landing_routes.dart';
import 'package:toolmart/screens/user/user_screen.dart';

class ToolMartApp extends StatelessWidget {
  const ToolMartApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: kPrimaryColor,
      theme: ThemeData(
        splashColor: Colors.transparent,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
            TargetPlatform.values,
            value: (dynamic _) => const CupertinoPageTransitionsBuilder(),
          ),
        ),
      ),
      title: 'ToolMart',
      initialRoute: UserScreen.id,
      routes: LandingRoutes.routes,
      onGenerateRoute: LandingRoutes.onGenerateRoute,
    );
  }
}
