import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trail_buddies/user_changenotifier.dart';

import './pages/landing.dart';
import './pages/login.dart';
import './pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const CheckLogin(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}

class CheckLogin extends StatefulWidget {
  const CheckLogin({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CheckLogin();
}

class _CheckLogin extends State<CheckLogin> {
  bool isLoggedIn = false;
  String token = '';

  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final prefsToken = prefs.getString('token');
    if (prefsToken != null) {
      setState(() {
        token = prefsToken;
      });
    }
  }

  verifyToken() async {
    if (token.isNotEmpty) {
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
        final user = Provider.of<CurrentUser>(context, listen: false);
        user.setAll(
          newToken: token,
          newId: json['id'],
          newUsername: json['username'],
          newEmail: json['email'],
          newVerified: json['verified'],
          newAdmin: json['admin'],
        );
        setState(() {
          isLoggedIn = true;
        });
      }
    }
  }

  Future<bool> checkIfLoggedIn() async {
    await getToken();
    await verifyToken();
    return isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkIfLoggedIn(),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data == true ? const HomePage() : const LoginPage();
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
