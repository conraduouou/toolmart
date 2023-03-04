import 'package:flutter/material.dart';
import 'package:toolmart/models/core/cart_item.dart';
import 'package:toolmart/models/core/item.dart';
import 'package:toolmart/models/helpers/api_helper.dart';

class ItemProvider with ChangeNotifier {
  final Item item;

  ItemProvider(this.item) {
    item.toOrder = 1;
  }

  bool _isDisposed = false;
  bool _inAsync = false;

  String? _errorMessage;

  bool get inAsync => _inAsync;
  String? get errorMessage => _errorMessage;

  Future<bool> postCartItem() async {
    toggleInAsync();
    _errorMessage = null;

    final helper = ApiHelper.helper;
    final cartItem = CartItem(
      itemId: item.id,
      itemColor: item.colors?[0],
      itemQuantity: item.toOrder,
    );

    final result = await helper.postCartItem(cartItem);

    if (result is String) {
      _errorMessage = "There was an error adding this item to cart.";
      toggleInAsync();
      return false;
    }

    toggleInAsync();
    return true;
  }

  void onMinusTap() {
    if (item.toOrder == 1) return;
    item.toOrder--;
    notifyListeners();
  }

  void onPlusTap() {
    item.toOrder++;
    notifyListeners();
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
