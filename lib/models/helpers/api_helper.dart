import 'dart:convert';

import 'package:toolmart/models/core/cart_item.dart';
import 'package:toolmart/models/core/item.dart';
import 'package:toolmart/models/core/transaction.dart';
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

  Future<dynamic> postTransaction(Transaction transaction) async {
    final service = ApiService.service;
    late final http.Response result;

    try {
      result = await service.postTransaction(transaction);
      if (result.statusCode < 200 || result.statusCode > 299) throw "";
    } catch (e) {
      return "There was an error making this request.";
    }

    return;
  }
}
