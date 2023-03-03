import 'package:flutter/material.dart';
import 'package:toolmart/models/core/item.dart';
import 'package:toolmart/models/helpers/api_helper.dart';

class HomeProvider with ChangeNotifier {
  bool _isDisposed = false;
  bool _inAsync = false;
  String? _errorMessage;

  final List<Item> _items = [];

  bool get inAsync => _inAsync;
  String? get errorMessage => _errorMessage;

  List<Item> get items => _items;

  HomeProvider() {
    getItems();
  }

  Future<void> getItems() async {
    toggleInAsync();
    _errorMessage = null;

    final helper = ApiHelper.helper;
    final response = await helper.getItems();

    if (response is! List<Item>) {
      _errorMessage = "There was an error retrieving item data.";
      toggleInAsync();
      return;
    }

    _items.addAll(response);
    toggleInAsync();
  }

  void toggleInAsync() {
    _inAsync = !_inAsync;

    if (_isDisposed) return;
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = false;
    super.dispose();
  }
}
