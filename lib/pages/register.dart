import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trail_buddies/widgets/common/background_image.dart';

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
  late FToast toasts;

  @override
  void initState() {
    super.initState();
    toasts = FToast();
    toasts.init(context);
  }

  void login(BuildContext context) async {
    if (email.text.isEmpty || password.text.isEmpty || username.text.isEmpty) {
      return setError("Please enter a username, email, and password");
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
  }

  void setError(String err) {
    setState(() {
      error = err;
    });
    showErrorToast(err);
  }

  void showErrorToast(String err) {
    Widget toast = Container(
        padding:
            const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 8.0, left: 0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.redAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade800,
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: const Offset(2.0, 3.0),
            ),
          ],
        ),
        child: Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                padding: const EdgeInsets.all(0.0),
                icon: const Icon(Icons.close),
                onPressed: () {
                  toasts.removeCustomToast();
                },
              ),
              Text(err),
            ],
          ),
        ));

    toasts.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 4),
    );
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
      body: BackgroundImage(children: [
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            ]),
          ),
        ),
      ]),
    );
  }
}
