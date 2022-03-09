import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../user.dart';
import '../home.dart';
import '../landing.dart';
import '../login.dart';

class CheckLogin extends StatefulWidget {
  const CheckLogin({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CheckLogin();
}

class _CheckLogin extends State<CheckLogin> {
  bool isLoggedIn = false;
  String token = '';

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final prefsToken = prefs.getString('token');
    return prefsToken;
  }

  Future<bool> verifyToken(String token) async {
    final response = await get(
      Uri.parse('http://10.0.2.2:3000/api/v1/users/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    var json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      setState(() {
        isLoggedIn = false;
      });
    } else {
      final user = Provider.of<User>(context, listen: false);
      user.setAll(
        newToken: token,
        newId: json['id'],
        newUsername: json['username'],
        newEmail: json['email'],
        newVerified: json['verified'],
        newAdmin: json['admin'],
      );
      return true;
    }
    return false;
  }

  Future<bool> checkIfLoggedIn() async {
    final token = await getToken();
    if (token == null || token.isEmpty) return false;
    final isValidToken = await verifyToken(token);
    return isValidToken;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkIfLoggedIn(),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data == true ? const HomePage() : const LandingPage();
        } else if (snapshot.hasError) {
          Fluttertoast.showToast(
            msg:
                'Failed to validate token. Please report this incident to matievisthekat@gmail.com',
          );
          FlutterError.presentError(FlutterErrorDetails(
            exception: snapshot.error ?? {},
            context:
                ErrorDescription('Error while validating token in _CheckLogin'),
          ));
          return const LoginPage();
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
