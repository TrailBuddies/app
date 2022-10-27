import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:trail_buddies/user.dart';
import 'package:trail_buddies/widgets/login_register_pages/layout.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      customButtonText: 'Already have an account? Login here',
      customButtonPath: '/login',
      onSubmit: (
        BuildContext context,
        String? username,
        String? email,
        String? password,
        void Function(String err) setError,
      ) async {
        if (username == null || email == null || password == null) return;
        if (email.isEmpty || password.isEmpty || username.isEmpty) {
          return setError("Please enter a username, email, and password");
        }

        final response = await post(
          Uri.parse('http://10.0.2.2:3000/api/v1/users/register'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'user': {
              'username': username,
              'email': email,
              'password': password,
            }
          }),
        );

        var json = jsonDecode(response.body) as Map<String, dynamic>;

        if (response.statusCode != 200) {
          setError(json['error']);
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

          Navigator.pushReplacementNamed(context, '/home');
        }
      },
    );
  }
}
