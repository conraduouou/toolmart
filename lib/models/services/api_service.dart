import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:toolmart/models/core/cart_item.dart';
import 'package:toolmart/models/core/transaction.dart';
import 'package:toolmart/models/helpers/storage.dart';

class ApiService {
  static const _apiURL = 'toolmart-db.herokuapp.com';

  ApiService._();

  static final ApiService _instance = ApiService._();
  static ApiService get service => _instance;

  // TODO: make methods depend on userId for simple auth

  Future<http.Response> getCartItems() async {
    final userId = await Storage.instance.read(key: "userId");
    Uri getUrl = Uri.https(_apiURL, '/api/cartitems/$userId');
    http.Response response = await http.get(getUrl);
    return response;
  }

  Future<http.Response> deleteCartItem(CartItem cartItem) async {
    final userId = await Storage.instance.read(key: "userId");
    final id = cartItem.id;
    Uri deleteUrl = Uri.https(_apiURL, '/api/cartitems/one/$id/$userId');
    http.Response response = await http.delete(deleteUrl);
    return response;
  }

  Future<http.Response> deleteCartItems() async {
    final userId = await Storage.instance.read(key: "userId");
    Uri deleteUrl = Uri.https(_apiURL, '/api/cartitems/$userId');
    http.Response response = await http.delete(deleteUrl);
    return response;
  }

  Future<http.Response> patchCartItemQuantity(CartItem cartItem) async {
    final userId = await Storage.instance.read(key: "userId");
    final id = cartItem.id;
    final quantity = cartItem.itemQuantity;

    Uri patchUrl =
        Uri.https(_apiURL, '/api/cartitems/quantity/$id/$userId/$quantity');

    http.Response response = await http.patch(patchUrl);
    return response;
  }

  Future<http.Response> postCartItem(CartItem cartItem) async {
    Uri postUrl = Uri.https(_apiURL, '/api/cartitems');
    final userId = await Storage.instance.read(key: "userId");

    cartItem.userId = userId;

    HttpClient client = HttpClient();
    HttpClientRequest request = await client.postUrl(postUrl);
    request.headers.set('content-type', 'application/json');

    request.add(utf8.encode(jsonEncode(cartItem.toJson())));
    HttpClientResponse httpResponse = await request.close();
    client.close();

    final responseBody = await httpResponse.transform(utf8.decoder).join();
    final statusCode = httpResponse.statusCode;
    final reasonPhrase = httpResponse.reasonPhrase;

    return http.Response(responseBody, statusCode, reasonPhrase: reasonPhrase);
  }

  /// Get items of length 24
  Future<http.Response> getItems() async {
    Uri getUrl = Uri.https(_apiURL, '/api/items');
    http.Response response = await http.get(getUrl);
    return response;
  }

  /// Get item by id of length 24
  Future<http.Response> getItemById(String id) async {
    Uri getUrl = Uri.https(_apiURL, '/api/items/$id');
    http.Response response = await http.get(getUrl);
    return response;
  }

  /// Get user by email
  Future<http.Response> getUserByEmail(String email) async {
    Uri getUrl = Uri.https(_apiURL, '/api/users/email/$email');
    http.Response response = await http.get(getUrl);
    return response;
  }

  Future<http.Response> postTransaction(Transaction transaction) async {
    final userId = await Storage.instance.read(key: 'userId');
    if (userId == null) return http.Response('Unauthorized', 401);

    Uri postUrl = Uri.https(_apiURL, '/api/transactions');

    HttpClient client = HttpClient();
    HttpClientRequest request = await client.postUrl(postUrl);
    request.headers.set('content-type', 'application/json');

    request.add(utf8.encode(jsonEncode(transaction.toJson())));
    HttpClientResponse httpResponse = await request.close();
    client.close();

    final responseBody = await httpResponse.transform(utf8.decoder).join();
    final statusCode = httpResponse.statusCode;
    final reasonPhrase = httpResponse.reasonPhrase;

    return http.Response(responseBody, statusCode, reasonPhrase: reasonPhrase);
  }
}
