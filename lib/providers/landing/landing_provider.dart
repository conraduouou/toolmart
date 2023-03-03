import 'package:flutter/material.dart';
import 'package:toolmart/models/core/user.dart';
import 'package:toolmart/models/helpers/api_helper.dart';

class LandingProvider with ChangeNotifier {
  bool _isDisposed = false;
  bool _inAsync = false;

  String _password = '';
  String _email = '';

  String? _errorMessage;

  String get password => _password;
  String get email => _email;

  String? get errorMessage => _errorMessage;

  void passwordOnChanged(String s) => _password = s;

  void emailOnChanged(String s) => _email = s;

  void dismissError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Returns true when there was no error found.
  Future<bool> login() async {
    final helper = ApiHelper.helper;
    final response = helper.getUserByEmail(_email);

    if (response is! User) {
      _errorMessage = "No user was found with that email.";
      notifyListeners();
      return false;
    }

    if (password.compareTo((response as User).password!) != 0) {
      _errorMessage = "Incorrect password.";
      notifyListeners();
      return false;
    }

    return true;
  }

  void toggleInAsync() {
    _inAsync = !_inAsync;
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (_isDisposed) return;
    super.notifyListeners();
  }
}
