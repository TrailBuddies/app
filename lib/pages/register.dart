import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:trail_buddies/widgets/common/button.dart';
import 'package:trail_buddies/widgets/common/text_input.dart';
import 'package:trail_buddies/user.dart';
import 'package:trail_buddies/widgets/common/text_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  String error = "";

  void login(BuildContext context) async {
    if (email.text.isEmpty || password.text.isEmpty || username.text.isEmpty) {
      return setState(() {
        error = "Please enter a username, email, and password";
      });
    }

    setState(() {
      error = "";
    });

    final response = await post(
      Uri.parse('http://10.0.2.2:3000/api/v1/users/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'user': {
          'username': username.text,
          'email': email.text,
          'password': password.text,
        }
      }),
    ).catchError((e) {
      setState(() {
        error = 'Unexpected error. Please report this incident';
      });
      FlutterError.presentError(
        FlutterErrorDetails(
          exception: e,
          context: ErrorDescription(
            'post() request .catchError callback. Trying to register with ${username.text} and ${email.text} and ${password.text}',
          ),
        ),
      );
    });

    var json = jsonDecode(response.body) as Map<String, dynamic>;

    if (error.isNotEmpty) return;
    if (response.statusCode != 200) {
      return setState(() {
        error = json['error'];
      });
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
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(232, 73, 23, 1),
        ),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextInput(hintText: 'Username', controller: username),
            const SizedBox(height: 16),
            TextInput(hintText: 'Email', controller: email),
            const SizedBox(height: 16),
            TextInput(
              hintText: 'Password',
              obscureText: true,
              controller: password,
            ),
            const SizedBox(height: 30),
            Button(
              text: 'Register',
              backgroundColour: Colors.green.shade400,
              onTap: () => {login(context)},
            ),
            CustomTextButton(
              text: "Already have an account? Log in here!",
              onTap: () => Navigator.pushNamed(context, '/login'),
            ),
            const SizedBox(height: 16),
            Text(
              error,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
