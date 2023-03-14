import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ToolMartStorage {
  ToolMartStorage._();

  static const _instance = FlutterSecureStorage();
  static FlutterSecureStorage get instance => _instance;
}
