import 'package:flutter/material.dart';
import 'package:toolmart/constants.dart';
import 'package:toolmart/models/core/transaction.dart';
import 'package:toolmart/models/core/transaction_item.dart';
import 'package:toolmart/models/helpers/api_helper.dart';

class TransactionProvider with ChangeNotifier {
  bool _isDisposed = false;
  bool _inAsync = false;
  String? _errorMessage;

  bool get inAsync => _inAsync;
  String? get errorMessage => _errorMessage;

  final transactionItems = <TransactionItem>[];
  final Transaction transaction;

  TransactionProvider({required this.transaction}) {
    getItems();
  }

  Future<void> getItems() async {
    toggleInAsync();
    _errorMessage = null;

    final helper = ApiHelper.helper;
    final response = await helper.getTransactionItems(transaction.id!);

    if (response is! List<TransactionItem>) {
      _errorMessage = response;
      toggleInAsync();
      return;
    }

    transactionItems.addAll(response);

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
    if (!_isDisposed) notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
