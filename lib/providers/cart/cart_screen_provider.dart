import 'package:flutter/material.dart';
import 'package:toolmart/models/core/cart_item.dart';
import 'package:toolmart/models/core/debouncer.dart';
import 'package:toolmart/models/core/item.dart';
import 'package:toolmart/models/helpers/api_helper.dart';

class CartScreenProvider with ChangeNotifier {
  bool _isDisposed = false;
  bool _inAsync = false;
  String? _errorMessage;
  final Debouncer _debouncer = Debouncer(milliseconds: 300);

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

  void onMinusTap(int index) {
    // ideally, I should log this in some error logger and figure out why this is
    // null at this time. For now, I'm going to assume it will always have a value,
    // which it typically will.
    if (_cartItems[index].itemQuantity == null) return;

    if (_cartItems[index].itemQuantity! > 1) {
      // weird syntax because of nullable int type but it'll do
      _cartItems[index].itemQuantity = _cartItems[index].itemQuantity! - 1;
      if (!_isDisposed) notifyListeners(); // update UI immediately

      _debouncer.run(() async {
        final helper = ApiHelper.helper;
        final result = await helper.patchCartItem(_cartItems[index]);

        if (result is String) {
          _errorMessage = result;
          if (!_isDisposed) notifyListeners();
        }
      });
    }
  }

  void onPlusTap(int index) {
    // same comment from onMinusTap
    if (_cartItems[index].itemQuantity == null) return;

    _cartItems[index].itemQuantity = _cartItems[index].itemQuantity! + 1;
    if (!_isDisposed) notifyListeners(); // update UI immediately

    _debouncer.run(() async {
      final helper = ApiHelper.helper;
      final result = await helper.patchCartItem(_cartItems[index]);

      if (result is String) {
        _errorMessage = result;
        if (!_isDisposed) notifyListeners();
      }
    });
  }

  void onDeleteTap(int index) async {
    final cartItem = _cartItems[index];
    _cartItems.remove(cartItem);

    // remove immediately and update UI. if delete request fails, add it back to list.
    if (!_isDisposed) notifyListeners();

    final helper = ApiHelper.helper;
    final result = await helper.deleteCartItem(cartItem);

    if (result is String) {
      _cartItems.insert(index, cartItem);
      _errorMessage = result;
      if (!_isDisposed) notifyListeners();
    }
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
