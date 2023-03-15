import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:toolmart/models/core/cart_item.dart';
import 'package:toolmart/models/core/item.dart';
import 'package:toolmart/models/core/review.dart';
import 'package:toolmart/models/core/transaction.dart';
import 'package:toolmart/models/core/transaction_item.dart';
import 'package:toolmart/models/core/user.dart';
import 'package:toolmart/models/services/api_service.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper._();

  static final _helper = ApiHelper._();
  static ApiHelper get helper => _helper;

  static const _timeout = Duration(seconds: 15);

  Future<dynamic> getCartItems() async {
    final service = ApiService.service;
    late final http.Response result;

    try {
      result = await service.getCartItems().timeout(_timeout);
      if (result.statusCode != 200) throw "";
    } on TimeoutException {
      return 'The process timed out. Please check your internet connection.';
    } catch (e) {
      return "There was an error getting this item.";
    }

    final data = jsonDecode(result.body);
    final items = <CartItem>[];

    for (final item in data) {
      items.add(CartItem.fromJson(item));
    }

    return items;
  }

  Future<dynamic> deleteCartItem(CartItem cartItem) async {
    final service = ApiService.service;
    late final http.Response result;

    try {
      result = await service.deleteCartItem(cartItem).timeout(_timeout);
      if (result.statusCode < 200 || result.statusCode > 299) throw "";
    } on TimeoutException {
      return 'The process timed out. Please check your internet connection.';
    } catch (e) {
      return "There was an error making this request.";
    }

    return;
  }

  Future<dynamic> deleteCartItems() async {
    final service = ApiService.service;
    late final http.Response result;

    try {
      result = await service.deleteCartItems().timeout(_timeout);
      if (result.statusCode < 200 || result.statusCode > 299) throw "";
    } on TimeoutException {
      return 'The process timed out. Please check your internet connection.';
    } catch (e) {
      return "There was an error making this request.";
    }

    return;
  }

  Future<dynamic> patchCartItem(CartItem cartItem) async {
    final service = ApiService.service;
    late final http.Response result;

    try {
      result = await service.patchCartItemQuantity(cartItem).timeout(_timeout);
      if (result.statusCode < 200 || result.statusCode > 299) throw "";
    } on TimeoutException {
      return 'The process timed out. Please check your internet connection.';
    } catch (e) {
      return "There was an error making this request.";
    }

    return;
  }

  Future<dynamic> postCartItem(CartItem cartItem) async {
    final service = ApiService.service;
    late final http.Response result;

    try {
      result = await service.postCartItem(cartItem).timeout(_timeout);
      if (result.statusCode < 200 || result.statusCode > 299) throw "";
    } on TimeoutException {
      return 'The process timed out. Please check your internet connection.';
    } catch (e) {
      return "There was an error getting this item.";
    }

    return;
  }

  Future<dynamic> getItems() async {
    final service = ApiService.service;
    late final http.Response result;

    try {
      result = await service.getItems().timeout(_timeout);
      if (result.statusCode != 200) throw "";
    } on TimeoutException {
      return 'The process timed out. Please check your internet connection.';
    } catch (e) {
      return "There was an error getting this item.";
    }

    final data = jsonDecode(result.body);
    final items = <Item>[];

    for (final item in data) {
      items.add(Item.fromJson(item));
    }

    return items;
  }

  Future<dynamic> getItemById(String id) async {
    final service = ApiService.service;
    late final http.Response result;

    try {
      result = await service.getItemById(id).timeout(_timeout);
      if (result.statusCode != 200) throw "";
    } on TimeoutException {
      return 'The process timed out. Please check your internet connection.';
    } catch (e) {
      return "There was an error getting this item.";
    }

    final data = jsonDecode(result.body);
    final item = Item.fromJson(data);

    return item;
  }

  Future<dynamic> getUserByEmail(String email) async {
    final service = ApiService.service;
    late final http.Response response;

    try {
      response = await service.getUserByEmail(email).timeout(_timeout);
      if (response.statusCode != 200) throw "";
    } on TimeoutException {
      return 'The process timed out. Please check your internet connection.';
    } catch (e) {
      return "There was an error getting the user by email.";
    }

    final data = jsonDecode(response.body);
    final user = User.fromJson(data);

    return user;
  }

  Future<dynamic> getTransactions() async {
    final service = ApiService.service;
    late final http.Response response;

    try {
      response = await service.getTransactions().timeout(_timeout);
      if (response.statusCode != 200) throw "";
    } on TimeoutException {
      return 'The process timed out. Please check your internet connection.';
    } catch (e) {
      return 'There was an error retrieving transactions.';
    }

    final data = jsonDecode(response.body);

    if (data is! List) {
      return 'There was an error in processing the transactions';
    }

    final transactions =
        data.map<Transaction>((e) => Transaction.fromJson(e)).toList();

    return transactions;
  }

  Future<dynamic> postTransaction(
    Transaction transaction,
    List<CartItem> items,
  ) async {
    final service = ApiService.service;
    final c = HttpClient();
    late final http.Response result0;
    late final http.Response result1;

    try {
      result0 = await service
          .postTransaction(transaction, client: c)
          .timeout(_timeout);
      if (result0.statusCode < 200 || result0.statusCode > 299) throw "";
    } on TimeoutException {
      return 'The process timed out. Please check your internet connection.';
    } catch (e) {
      return "There was an error making the transaction.";
    }

    final data = jsonDecode(result0.body);
    final toReturn = Transaction.fromJson(data);

    try {
      final transactionItems = items
          .map<TransactionItem>(
            (e) => TransactionItem(
              transactionId: toReturn.id,
              itemColor: e.itemColor,
              itemId: e.itemId,
              itemQuantity: e.itemQuantity,
            ),
          )
          .toList();

      result1 = await service
          .postTransactionItems(transactionItems, client: c)
          .timeout(_timeout);
      if (result1.statusCode < 200 || result1.statusCode > 299) throw "";
    } on TimeoutException {
      return 'The process timed out. Please check your internet connection.';
    } catch (e) {
      return "There was an error in processing transaction items.";
    }

    c.close();

    return toReturn;
  }

  Future<dynamic> getTransactionItems(String id) async {
    final service = ApiService.service;
    final c = http.Client();
    late final http.Response result;

    try {
      result =
          await service.getTransactionItems(id, client: c).timeout(_timeout);
      if (result.statusCode != 200) throw '';
    } on TimeoutException {
      return 'The process timed out. Please check your internet connection.';
    } catch (e) {
      return 'There was an error in retrieving transaction items.';
    }

    final data = jsonDecode(result.body);

    if (data is! List) {
      return 'There was an error in processing transaction items.';
    }

    final toReturn =
        data.map<TransactionItem>((e) => TransactionItem.fromJson(e)).toList();

    try {
      for (final transaction in toReturn) {
        final result = await service
            .getItemById(transaction.itemId!, client: c)
            .timeout(_timeout);
        if (result.statusCode != 200) throw '';

        final resultData = jsonDecode(result.body);
        final item = Item.fromJson(resultData);

        transaction.itemName = item.name;
        transaction.itemPrice = item.price;
      }
    } on TimeoutException {
      return 'The process timed out. Please check your internet connection.';
    } catch (e) {
      return 'There was an error in finalizing transaction items.';
    }

    c.close();

    return toReturn;
  }

  Future<dynamic> postReview(int rating, String message, String itemId) async {
    final service = ApiService.service;
    late final http.Response result;

    try {
      final review =
          Review(itemId: itemId, userComment: message, userRating: rating);
      result = await service.postReview(review).timeout(_timeout);
      if (result.statusCode < 200 || result.statusCode > 299) throw '';
    } on TimeoutException {
      return 'The process timed out. Please check your internet connection';
    } catch (e) {
      return 'There was an error making the review.';
    }
  }
}
