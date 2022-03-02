import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trail_buddies/user_changenotifier.dart';
import 'package:trail_buddies/widgets/common/button.dart';
import 'package:trail_buddies/widgets/common/text_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  String error = "";

  void login(BuildContext context) async {
    if (emailController.text.isEmpty || passController.text.isEmpty) {
      return setState(() {
        error = "Please enter your email and password";
      });
    }

    setState(() {
      error = "";
    });

    final response = await post(
      Uri.parse('http://10.0.2.2:3000/api/v1/users/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'user': {
          'email': emailController.text,
          'password': passController.text,
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
            'post() request .catchError callback. Trying to log in with ${emailController.text} and ${passController.text}',
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

      Provider.of<CurrentUser>(context).setAll(
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
    emailController.dispose();
    passController.dispose();
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
            TextInput(hintText: "Email", controller: emailController),
            const SizedBox(height: 16),
            TextInput(
              hintText: "Password",
              obscureText: true,
              controller: passController,
            ),
            const SizedBox(height: 30),
            Button(
              text: 'Login',
              backgroundColour: Colors.green.shade400,
              textColour: Colors.white,
              onTap: () => {login(context)},
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
