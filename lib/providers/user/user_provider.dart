import 'package:flutter/material.dart';
import 'package:toolmart/constants.dart';
import 'package:toolmart/models/core/transaction.dart';
import 'package:toolmart/models/helpers/api_helper.dart';

class UserProvider with ChangeNotifier {
  bool _isDisposed = false;
  bool _inAsync = false;
  String? _errorMessage;

  bool get inAsync => _inAsync;
  String? get errorMessage => _errorMessage;

  UserProvider() {
    getTransactions();
  }

  final transactions = <Transaction>[];

  Future<void> getTransactions() async {
    toggleInAsync();
    _errorMessage = null;

    final helper = ApiHelper.helper;
    final response = await helper.getTransactions();

    if (response is! List<Transaction>) {
      _errorMessage = 'There was an error retrieving transactions.';
      toggleInAsync();
      return;
    }

    transactions.addAll(response);
    toggleInAsync();
  }

  DateTime? modifiedParse(String date) {
    final parsedDate = parseDate(date);

    if (parsedDate == null) {
      _errorMessage = 'There was an error parsing transaction date.';
      if (!_isDisposed) notifyListeners();
      return null;
    }

    return parsedDate;
  }

  void toggleInAsync() {
    _inAsync = !_inAsync;
    if (_isDisposed) return;
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
