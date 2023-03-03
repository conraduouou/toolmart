import 'package:http/http.dart' as http;

class ApiService {
  static const _apiURL = 'toolmart-db.herokuapp.com';

  ApiService._();

  static final ApiService _instance = ApiService._();
  static ApiService get service => _instance;

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
}
