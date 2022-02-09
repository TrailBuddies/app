import 'dart:convert';

import 'package:http/http.dart';
import './declarations.dart';

class User {
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
    this.createdAt = DateTime.parse(createdAt);
    this.updatedAt = DateTime.parse(updatedAt);
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
