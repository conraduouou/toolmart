import 'package:flutter/material.dart';
import 'package:toolmart/models/core/user.dart';
import 'package:toolmart/models/helpers/api_helper.dart';
import 'package:toolmart/models/helpers/storage.dart';

class LandingProvider with ChangeNotifier {
  bool _isDisposed = false;
  bool _inAsync = false;

  String _password = '';
  String _email = '';

  String? _errorMessage;

  bool get inAsync => _inAsync;

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
    toggleInAsync();
    _errorMessage = null;

    final helper = ApiHelper.helper;
    final response = await helper.getUserByEmail(_email);

    if (response is! User) {
      _errorMessage = "No user was found with that email.";
      toggleInAsync();
      return false;
    }

    if (password.compareTo(response.password!) != 0) {
      _errorMessage = "Incorrect password.";
      toggleInAsync();
      return false;
    }

    // TODO: add Name field in Users collection
    await Storage.instance.write(key: "email", value: _email);
    await Storage.instance.write(key: "userId", value: response.id);

    toggleInAsync();
    return true;
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
