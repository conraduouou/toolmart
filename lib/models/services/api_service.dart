import 'package:http/http.dart' as http;

class ApiService {
  static const _apiURL = '10.0.2.2:5023';

  ApiService._();

  static final ApiService _instance = ApiService._();
  static ApiService get service => _instance;

  Future<http.Response> getTodoById(int id) async {
    Uri getUrl = Uri.http(_apiURL, '/api/todoitems/$id');
    http.Response response = await http.get(getUrl);
    return response;
  }
}
