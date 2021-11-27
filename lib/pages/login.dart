import 'package:flutter/material.dart';
import 'package:trail_buddies/widgets/common/button.dart';
import 'package:trail_buddies/widgets/common/text_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(232, 73, 23, 1),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextInput(hintText: "Email"),
              const SizedBox(height: 16),
              const TextInput(hintText: "Password"),
              const SizedBox(height: 30),
              Button(
                text: 'Login',
                backgroundColour: Colors.green.shade400,
                textColour: Colors.white,
                onTap: () => {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
