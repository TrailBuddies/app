import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'lets_go',
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(232, 73, 23, 1),
          ),
        ),
      ),
    );
  }
}
