import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:trail_buddies/routing.dart';
import 'package:trail_buddies/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final prefsToken = prefs.getString('token');
    return prefsToken;
  }

  Future<bool> verifyToken(BuildContext ctx, String token) async {
    final response = await get(
      Uri.parse('http://10.0.2.2:3000/api/v1/users/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    var json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      if (mounted) {
        setState(() {
          isLoggedIn = false;
        });
      }
    } else {
      final user = Provider.of<User>(ctx, listen: false);
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

  Future<bool> checkIfLoggedIn(BuildContext ctx) async {
    final token = await getToken();
    if (token == null || token.isEmpty) return false;
    final isValidToken = await verifyToken(ctx, token);
    return isValidToken;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<User>(
      create: (_) => User(
        id: '',
        email: '',
        username: '',
        verified: false,
        admin: false,
        updatedAt: '',
        createdAt: '',
      ),
      builder: (ctx, child) {
        return FutureBuilder(
          future: checkIfLoggedIn(ctx),
          builder: (_, snap) {
            if (snap.hasData) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: snap.data == true ? '/' : '/login',
                onGenerateRoute: (settings) {
                  final name = settings.name ?? '/';

                  return getPage(name);
                },
              );
            }

            if (snap.hasError) {
              Fluttertoast.showToast(
                msg: 'Failed to login with stored credentials',
              );
              FlutterError.presentError(FlutterErrorDetails(
                exception: snap.error ?? {},
                context: ErrorDescription(
                    'Error while validating token in _CheckLogin'),
              ));
            }

            return const CircularProgressIndicator();
            // return Container(
            //   alignment: Alignment.center,
            //   padding: const EdgeInsets.all(32),
            //   child: const CircularProgressIndicator(),
            // );
          },
        );
      },
    );
  }
}
