import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:trail_buddies/routing.dart';
import 'package:trail_buddies/user.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<User>(
      create: (_) => User(
        id: '',
        email: '',
        username: '',
        verified: 'pending',
        admin: false,
        updatedAt: '',
        createdAt: '',
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          final name = settings.name ?? '';

          return getPage(name);
        },
      ),
    );
  }
}
