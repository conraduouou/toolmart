import 'package:flutter/material.dart';
import 'package:toolmart/components/error_dialog.dart';
import 'package:toolmart/models/core/cart_item.dart';
import 'package:toolmart/models/core/item.dart';
import 'package:toolmart/models/core/review.dart';
import 'package:toolmart/models/helpers/api_helper.dart';

class ItemProvider with ChangeNotifier {
  final Item item;

  ItemProvider(this.item) {
    item.toOrder = 1;
    getReviews();
  }

  bool _isDisposed = false;
  bool _inAsync = false;
  String? _errorMessage;

  int _stars = 0;
  String _review = '';

  final reviews = <Review>[];

  bool get inAsync => _inAsync;
  String? get errorMessage => _errorMessage;

  int get stars => _stars;
  String get review => _review;

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

  Future<void> getReviews({bool toggle = true}) async {
    if (toggle) toggleInAsync();
    _errorMessage = null;
    reviews.clear();

    final helper = ApiHelper.helper;
    final result = await helper.getReviews(item.id!);

    if (result is String) {
      _errorMessage = result;
      if (toggle) toggleInAsync();
      return;
    }

    reviews.addAll(result);
    if (toggle) toggleInAsync();
  }

  Future<bool> postReview() async {
    toggleInAsync();
    _errorMessage = null;

    final helper = ApiHelper.helper;
    final result = await helper.postReview(_stars, _review, item.id!);

    if (result is String) {
      _errorMessage = result;
      toggleInAsync();
      return false;
    }

    _stars = 0;
    _review = '';

    await getReviews(toggle: false);

    toggleInAsync();
    return true;
  }

  Future<void> showCustomDialog(
    BuildContext context, {
    String? message,
    String? title,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: title, // defaults to error
        message: message, // defaults to error message
      ),
    );
  }

  void onAddTap(BuildContext context) async {
    final navigator = Navigator.of(context);
    final isSuccessful = await postCartItem();

    if (!isSuccessful) {
      // ignore: use_build_context_synchronously
      return showCustomDialog(context, message: errorMessage);
    }

    // ignore: use_build_context_synchronously
    showCustomDialog(
      context,
      title: 'Success!',
      message: 'Successfully added item to cart.',
    );

    navigator.pop();
  }

  void onSendTap(BuildContext context) async {
    final isSuccessful = await postReview();

    if (!isSuccessful) {
      // ignore: use_build_context_synchronously
      return showCustomDialog(context, message: _errorMessage);
    }

    // ignore: use_build_context_synchronously
    return showCustomDialog(
      context,
      title: 'Success!',
      message: 'Successfully made review.',
    );
  }

  void onStarTap(int index) {
    _stars = index + 1;
    if (!_isDisposed) notifyListeners();
  }

  void onReviewChanged(String s) {
    _review = s;
    if (!_isDisposed) notifyListeners();
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
