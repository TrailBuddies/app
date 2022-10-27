import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:trail_buddies/user.dart';
import 'package:trail_buddies/widgets/login_register_pages/layout.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      infoWanted: const ["email", "password"],
      customButtonText: "Don't have an account yet? Register here",
      customButtonPath: '/register',
      onSubmit: (
        BuildContext context,
        String? username,
        String? email,
        String? password,
        void Function(String err) setError,
      ) async {
        if (email == null || password == null) return;
        if (email.isEmpty || password.isEmpty) {
          return setError("Please enter your email and password");
        }

        final response = await post(
          Uri.parse('http://10.0.2.2:3000/api/v1/users/login'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'user': {
              'email': email,
              'password': password,
            }
          }),
        );

        var json = jsonDecode(response.body) as Map<String, dynamic>;
        ;
        if (response.statusCode != 200) {
          return setError(json['error']);
        } else {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', json['auth']['token']);

          Provider.of<User>(context, listen: false).setAll(
            newToken: json['auth']['token'],
            newId: json['user']['id'],
            newUsername: json['user']['username'],
            newEmail: json['user']['email'],
            newVerified: json['user']['verified'],
            newAdmin: json['user']['admin'],
          );

          Navigator.pushReplacementNamed(context, '/');
        }
      },
    );
  }
}
