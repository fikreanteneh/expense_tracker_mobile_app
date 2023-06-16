import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String username;
  final String passwrod;
  final String token;

  User({required this.username, required this.passwrod, required this.token});

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      passwrod: map["password"] ?? '',
      username: map["username"] ?? '',
      token: map["token"] ?? '',
    );
  }

  static User empty = User(username: '', passwrod: '', token: '');

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "password": passwrod,
      "token": token,
    };
  }

  static Future<void> save(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toMap());
    prefs.setString("user", userJson);
  }

  static Future<User> load() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString("user") ?? '';
    if (userJson.isNotEmpty) {
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      final user = User.fromJson(userMap);
      return user;
    } else {
      return User.empty;
    }
  }
}
