import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:conscious_frontend/constants/keys.dart';

class AuthHelperMethods{

  AuthHelperMethods._internal();

  static final AuthHelperMethods _instance = AuthHelperMethods._internal();

  factory AuthHelperMethods() {
    return _instance;
  }

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> saveAuthToken(String token) async {
    await _storage.write(key: AUTH_TOKEN_KEY, value: token);
  }

  Future<void> deleteAuthToken() async {
    await _storage.delete(key: AUTH_TOKEN_KEY);
  }

  Future<String?> getAuthToken() async {
    String? token = await _storage.read(key: AUTH_TOKEN_KEY);
    return token;
  }

}