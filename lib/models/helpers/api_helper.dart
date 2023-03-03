import 'dart:convert';

import 'package:toolmart/models/core/user.dart';
import 'package:toolmart/models/services/api_service.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper._();

  static final _helper = ApiHelper._();
  static ApiHelper get helper => _helper;

  Future<dynamic> getItemById(String id) async {
    final service = ApiService.service;
    late final http.Response result;

    try {
      result = await service.getItemById(id);
      if (result.statusCode != 200) throw "";
    } catch (e) {
      return "There was an error getting this item.";
    }

    return result;
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
}
