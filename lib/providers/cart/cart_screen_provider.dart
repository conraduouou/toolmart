import 'package:flutter/material.dart';
import 'package:toolmart/models/core/cart_item.dart';
import 'package:toolmart/models/core/item.dart';
import 'package:toolmart/models/helpers/api_helper.dart';

class CartScreenProvider with ChangeNotifier {
  bool _isDisposed = false;
  bool _inAsync = false;
  String? _errorMessage;

  final List<CartItem> _cartItems = [];

  bool get inAsync => _inAsync;
  String? get errorMessage => _errorMessage;
  List<CartItem> get cartItems => _cartItems;

  CartScreenProvider() {
    getCartItems();
  }

  Future<void> getCartItems() async {
    toggleInAsync();
    _errorMessage = null;

    final helper = ApiHelper.helper;
    final result = await helper.getCartItems();

    if (result is! List<CartItem>) {
      _errorMessage = 'There was an error retrieving item data.';
      toggleInAsync();
      return;
    }

    for (final cartItem in result) {
      final item = await helper.getItemById(cartItem.itemId!);

      if (item is! Item) {
        _errorMessage = 'There was an error retrieving item data.';
        toggleInAsync();
        return;
      }

      cartItem.name = item.name;
      cartItem.price = item.price;
    }

    _cartItems.addAll(result);
    toggleInAsync();
  }

  void toggleInAsync() {
    _inAsync = !_inAsync;
    if (!_isDisposed) notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
