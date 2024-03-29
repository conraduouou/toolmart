import 'package:flutter/material.dart';
import 'package:toolmart/models/core/cart_item.dart';
import 'package:toolmart/models/core/item.dart';
import 'package:toolmart/models/core/transaction.dart';
import 'package:toolmart/screens/cart/cart_screen.dart';
import 'package:toolmart/screens/cart/checkout_screen.dart';
import 'package:toolmart/screens/cart/payment_success_screen.dart';
import 'package:toolmart/screens/home/home_overlay.dart';
import 'package:toolmart/screens/home/home_screen.dart';
import 'package:toolmart/screens/item/item_screen.dart';
import 'package:toolmart/screens/transaction/transaction_screen.dart';
import 'package:toolmart/screens/user/user_screen.dart';
import 'package:toolmart/toolmart_app.dart';
import 'package:provider/provider.dart';

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({
    super.key,
    this.initialRoute,
  });

  final String? initialRoute;

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    late Widget page;

    switch (settings.name) {
      case '/':
      case '/dashboard':
        return null;
      case HomeScreen.id:
        page = const HomeOverlay(initialPage: 0);
        break;
      case UserScreen.id:
        page = const HomeOverlay(initialPage: 1);
        break;
      case ItemScreen.id:
        final args = settings.arguments as Item;
        page = ItemScreen(itemDetails: args);
        break;
      case CartScreen.id:
        page = const CartScreen();
        break;
      case CheckoutScreen.id:
        final args = settings.arguments as List<CartItem>;
        page = CheckoutScreen(cartItems: args);
        break;
      case PaymentSuccessScreen.id:
        final args = settings.arguments as Transaction;
        page = PaymentSuccessScreen(transactionId: args.id!);
        break;
      case TransactionScreen.id:
        final args = settings.arguments as Transaction;
        page = TransactionScreen(transaction: args);
        break;
    }

    return MaterialPageRoute(
      builder: (context) => page,
      settings: settings,
    );
  }

  Future<bool> _onWillPop() async {
    final context = homeNavKey.currentContext!;
    final notifier = context.read<ValueNotifier<int>>(); // home page notifier
    final navigator = Navigator.of(context);

    if (navigator.canPop()) {
      navigator.maybePop();
      return false;
    }

    if (notifier.value != 0) {
      notifier.value = 0;
      return false;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // page notifier for HomeOverlay
      create: (context) => ValueNotifier<int>(0),
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Navigator(
          key: homeNavKey,
          onGenerateRoute: onGenerateRoute,
          initialRoute: HomeScreen.id,
        ),
      ),
    );
  }
}
