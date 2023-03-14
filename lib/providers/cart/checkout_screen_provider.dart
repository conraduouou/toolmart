import 'package:flutter/material.dart';
import 'package:toolmart/models/core/bank_details.dart';
import 'package:toolmart/models/core/cart_item.dart';
import 'package:toolmart/models/core/transaction.dart';
import 'package:toolmart/models/helpers/api_helper.dart';

enum PaymentMethod { cod, bank, gcash }

class CheckoutScreenProvider with ChangeNotifier {
  CheckoutScreenProvider(this.cartItems);

  bool _isDisposed = false;
  bool _inAsync = false;
  String? _errorMessage;

  bool get inAsync => _inAsync;
  String? get errorMessage => _errorMessage;

  final _bankDetails = BankDetails();

  int get bank => _bankDetails.bank;
  set bank(int index) {
    _bankDetails.bank = index;
    _filteredNotify();
  }

  String get userName => _bankDetails.userName;
  set userName(String name) {
    _bankDetails.userName = name;
    _filteredNotify();
  }

  String get cardNumber => _bankDetails.cardNumber;
  set cardNumber(String number) {
    _bankDetails.cardNumber = number;
    _filteredNotify();
  }

  String get expirationDate => _bankDetails.expirationDate;
  set expirationDate(String date) {
    _bankDetails.expirationDate = date;
    _filteredNotify();
  }

  String get securityCode => _bankDetails.securityCode;
  set securityCode(String code) {
    _bankDetails.securityCode = code;
    _filteredNotify();
  }

  final List<CartItem> cartItems;

  PaymentMethod _paymentMethod = PaymentMethod.cod;
  PaymentMethod get paymentMethod => _paymentMethod;
  set paymentMethod(PaymentMethod method) {
    _paymentMethod = method;
    _filteredNotify();
  }

  bool _isAgreed = false;
  bool get isAgreed => _isAgreed;
  set isAgreed(bool b) {
    _isAgreed = b;
    _filteredNotify();
  }

  Future<Transaction?> postTransaction() async {
    toggleInAsync();
    _errorMessage = null;

    final helper = ApiHelper.helper;
    final totalItems = cartItems.fold<int>(0, (p, e) => p + e.itemQuantity!);
    final totalPrice = cartItems.fold<double>(0.0, (p, e) => p + e.price!);

    final result0 = await helper.postTransaction(
      Transaction(
        paymentMethod: paymentMethod.name.toString(),
        totalQuantity: totalItems,
        price: totalPrice,
      ),
    );

    if (result0 is String) {
      _errorMessage = 'There was an error making the transaction.';
      return null;
    }

    final result1 = await helper.deleteCartItems();

    if (result1 is String) {
      _errorMessage = 'There was an error clearing the cart.';
      return null;
    }

    toggleInAsync();
    return result0;
  }

  void toggleInAsync() {
    _inAsync = !_inAsync;
    _filteredNotify();
  }

  void _filteredNotify() => !_isDisposed ? notifyListeners() : null;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
