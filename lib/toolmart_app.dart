import 'package:flutter/material.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/landing_routes.dart';
import 'package:toolmart/models/services/api_service.dart';
import 'package:toolmart/screens/landing/landing_screen.dart';
import 'package:provider/provider.dart';

final rootNavKey = GlobalKey();
final homeNavKey = GlobalKey();

class ToolMartApp extends StatelessWidget {
  const ToolMartApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: ApiService.service,
      child: MaterialApp(
        key: rootNavKey,
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
        initialRoute: LandingScreen.id,
        routes: LandingRoutes.routes,
        onGenerateRoute: LandingRoutes.onGenerateRoute,
      ),
    );
  }
}
