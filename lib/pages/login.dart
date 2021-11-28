import 'package:flutter/material.dart';
import 'package:trail_buddies/widgets/common/button.dart';
import 'package:trail_buddies/widgets/common/text_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController = TextEditingController();

  final String error = "";

  @override
  void dispose() {
    loginController.dispose();
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextInput(hintText: "Email", controller: loginController),
              const SizedBox(height: 16),
              TextInput(hintText: "Password", controller: loginController),
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
