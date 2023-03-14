import 'dart:convert';
import 'dart:io';

import 'package:toolmart/models/core/cart_item.dart';
import 'package:toolmart/models/core/item.dart';
import 'package:toolmart/models/core/transaction.dart';
import 'package:toolmart/models/core/transaction_item.dart';
import 'package:toolmart/models/core/user.dart';
import 'package:toolmart/models/services/api_service.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper._();

  static final _helper = ApiHelper._();
  static ApiHelper get helper => _helper;

  Future<dynamic> getCartItems() async {
    final service = ApiService.service;
    late final http.Response result;

    try {
      result = await service.getCartItems();
      if (result.statusCode != 200) throw "";
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
      result = await service.deleteCartItem(cartItem);
      if (result.statusCode < 200 || result.statusCode > 299) throw "";
    } catch (e) {
      return "There was an error making this request.";
    }

    return;
  }

  Future<dynamic> deleteCartItems() async {
    final service = ApiService.service;
    late final http.Response result;

    try {
      result = await service.deleteCartItems();
      if (result.statusCode < 200 || result.statusCode > 299) throw "";
    } catch (e) {
      return "There was an error making this request.";
    }

    return;
  }

  Future<dynamic> patchCartItem(CartItem cartItem) async {
    final service = ApiService.service;
    late final http.Response result;

    try {
      result = await service.patchCartItemQuantity(cartItem);
      if (result.statusCode < 200 || result.statusCode > 299) throw "";
    } catch (e) {
      return "There was an error making this request.";
    }

    return;
  }

  Future<dynamic> postCartItem(CartItem cartItem) async {
    final service = ApiService.service;
    late final http.Response result;

    try {
      result = await service.postCartItem(cartItem);
      if (result.statusCode < 200 || result.statusCode > 299) throw "";
    } catch (e) {
      return "There was an error getting this item.";
    }

    return;
  }

  Future<dynamic> getItems() async {
    final service = ApiService.service;
    late final http.Response result;

    try {
      result = await service.getItems();
      if (result.statusCode != 200) throw "";
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
      result = await service.getItemById(id);
      if (result.statusCode != 200) throw "";
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
      response = await service.getUserByEmail(email);
      if (response.statusCode != 200) throw "";
    } catch (e) {
      return "There was an error getting the user by email.";
    }

    final data = jsonDecode(response.body);
    final user = User.fromJson(data);

    return user;
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
      result0 = await service.postTransaction(transaction, client: c);
      if (result0.statusCode < 200 || result0.statusCode > 299) throw "";
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

      result1 = await service.postTransactionItems(transactionItems, client: c);
      if (result1.statusCode < 200 || result1.statusCode > 299) throw "";
    } catch (e) {
      return "There was an error in processing transaction items.";
    }

    c.close();

    return toReturn;
  }
}
