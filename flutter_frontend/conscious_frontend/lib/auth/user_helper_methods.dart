import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:conscious_frontend/models/user.dart';
import 'package:conscious_frontend/constants/api_endpoints.dart';
import 'package:conscious_frontend/constants/keys.dart';
import 'package:http/http.dart' as http;

class UserHelperMethods {
  UserHelperMethods._internal();
  static final UserHelperMethods _instance = UserHelperMethods._internal();
  factory UserHelperMethods() {
    return _instance;
  }
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveUserDataFromStorage(String userData) async {
    await _storage.write(key: USER_DATA_KEY, value: userData);
  }

  Future<void> deleteUserDataFromStorage() async {
    await _storage.delete(key: USER_DATA_KEY);
  }

  Future<User?> _getUserDataFromStorage() async {
    String? userData = await _storage.read(key: USER_DATA_KEY);
    if (userData != null) {
      return User.fromJson(jsonDecode(userData));
    }
    return null;
  }

  Future<User?> _fetchUserDataFromServer(String token) async {
    print("Fetching user data from server with token: $token");
    final response = await http.get(
      Uri.parse(USER_DATA_ENDPOINT),
      headers: {CONTENT_TYPE_KEY: CONTENT_TYPE_VALUE, ID_TOKEN_KEY: token},
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return User.fromJson(responseData);
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
    }
    return null;
  }

  Future<User?> getUserDataFromAuthToken(String token) async {
    print("Fetching user data with token: $token");
    User? user = await _getUserDataFromStorage();
    print("User data from storage: ${user?.toJson()}");
    if (user != null) {
      print("User data from storage: ${user.toJson()}");
      return user;
    }
    user = await _fetchUserDataFromServer(token);
    if (user != null) {
      await _storage.write(key: USER_DATA_KEY, value: jsonEncode(user.toJson()));
    }
    return user;
  }
}
