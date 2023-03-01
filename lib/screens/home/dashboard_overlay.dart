import 'package:flutter/material.dart';
import 'package:toolmart/components/toolmart_navbar.dart';
import 'package:toolmart/screens/home/home_screen.dart';
import 'package:toolmart/screens/user/user_screen.dart';

class DashboardOverlay extends StatefulWidget {
  const DashboardOverlay({super.key});

  static const id = '/dashboard';

  @override
  State<DashboardOverlay> createState() => _DashboardOverlayState();
}

class _DashboardOverlayState extends State<DashboardOverlay> {
  int activePage = 0;

  final pages = <Widget>[
    const HomeScreen(),
    const UserScreen(),
  ];

  void setPage(int index) => setState(() => activePage = index);

  Future<bool> _onWillPop() async {
    final navigator = Navigator.of(context);

    if (navigator.canPop()) {
      if (activePage != 0) {
        setState(() {
          activePage = 0;
        });
        return false;
      }

      navigator.maybePop();
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        bottomNavigationBar: ToolMartNavBar(
          activePage: activePage,
          onHomeTap: () => setPage(0),
          onUserTap: () => setPage(1),
        ),
        body: IndexedStack(
          index: activePage,
          children: pages,
        ),
      ),
    );
  }
}
