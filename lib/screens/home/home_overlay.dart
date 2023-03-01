import 'package:flutter/material.dart';
import 'package:toolmart/components/toolmart_navbar.dart';
import 'package:toolmart/screens/home/home_screen.dart';
import 'package:toolmart/screens/user/user_screen.dart';
import 'package:provider/provider.dart';

class HomeOverlay extends StatefulWidget {
  const HomeOverlay({
    super.key,
    required this.initialPage,
  });

  static const id = '/dashboard';

  final int initialPage;

  @override
  State<HomeOverlay> createState() => _HomeOverlayState();
}

class _HomeOverlayState extends State<HomeOverlay> {
  late final List<Widget> pages;

  @override
  void initState() {
    pages = [
      const HomeScreen(),
      const UserScreen(),
    ];

    super.initState();
  }

  void setPage(int index, ValueNotifier<int> notifier) =>
      notifier.value = index;

  Future<bool> _onWillPop(ValueNotifier<int> notifier) async {
    final navigator = Navigator.of(context);

    if (navigator.canPop()) {
      if (notifier.value != 0) {
        notifier.value = 0;
        return false;
      }

      navigator.maybePop();
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final activePageNotifier = context.watch<ValueNotifier<int>>();

    return WillPopScope(
      onWillPop: () => _onWillPop(activePageNotifier),
      child: Scaffold(
        bottomNavigationBar: ToolMartNavBar(
          activePage: activePageNotifier.value,
          onHomeTap: () => setPage(0, activePageNotifier),
          onUserTap: () => setPage(1, activePageNotifier),
        ),
        body: IndexedStack(
          index: activePageNotifier.value,
          children: pages,
        ),
      ),
    );
  }
}
