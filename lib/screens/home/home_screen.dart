import 'package:flutter/material.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/toolmart_navbar.dart';
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
        bottomNavigationBar: const ToolMartNavBar(),
        body: const HomeBody(),
      ),
    );
  }
}
