import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './declarations.dart';

class User extends ChangeNotifier {
  late String id;
  late String username;
  late String email;
  late DateTime createdAt;
  late DateTime updatedAt;
  late String verified;
  late bool admin;

  User({
    required this.id,
    required this.username,
    required this.email,
    required String createdAt,
    required String updatedAt,
    required this.verified,
    required this.admin,
  }) {
    this.createdAt =
        createdAt.isNotEmpty ? DateTime.parse(createdAt) : DateTime.now();
    this.updatedAt =
        createdAt.isNotEmpty ? DateTime.parse(updatedAt) : DateTime.now();
  }

  void setAll({
    required String newToken,
    required String newId,
    required String newUsername,
    required String newEmail,
    required String newVerified,
    required bool newAdmin,
  }) {
    id = newId;
    username = newUsername;
    email = newEmail;
    verified = newVerified;
    admin = newAdmin;
    notifyListeners();
  }

  void setId(String v) {
    id = v;
    notifyListeners();
  }

  void setUsername(String v) {
    username = v;
    notifyListeners();
  }

  void setEmail(String v) {
    email = v;
    notifyListeners();
  }

  void setVerified(String v) {
    verified = v;
    notifyListeners();
  }

  void setAdmin(bool v) {
    admin = v;
    notifyListeners();
  }

  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();

    final response = await post(
      Uri.parse('$baseUrl/api/v1/users/logout'),
      headers: {
        'Authorization': 'Bearer ${prefs.get('token')}',
        'Content-Type': 'application/json',
      },
    );
    final json = jsonDecode(response.body);

    if (response.statusCode == 200 && json['success'] == true) {
      await prefs.remove('token');
      return true;
    } else {
      return false;
    }
  }

  static Future<User?> fetch(String identifier) async {
    final response = await get(
      Uri.parse('$baseUrl/api/v1/users/$identifier'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw json['error'];
    } else {
      return User(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        verified: json['verified'],
        admin: json['admin'],
      );
    }
  }
}
