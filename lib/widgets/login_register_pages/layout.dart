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

class Layout extends StatefulWidget {
  final List<String> infoWanted;
  final String customButtonText;
  final String customButtonPath;
  final String submitButtonText;
  final Future<void> Function(
    BuildContext context,
    String? username,
    String? email,
    String? password,
    void Function(String err) setError,
  ) onSubmit;

  const Layout({
    Key? key,
    required this.onSubmit,
    required this.customButtonText,
    required this.customButtonPath,
    this.infoWanted = const ["email", "username", "password"],
    this.submitButtonText = "Submit",
  }) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
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

  void submit(BuildContext context) async {
    Future<void> Function(
      BuildContext context,
      String? username,
      String? email,
      String? password,
      void Function(String err) setError,
    ) onSubmit = widget.onSubmit;

    setState(() => {error = ''});

    onSubmit(
      context,
      username.text,
      email.text,
      password.text,
      setError,
    ).catchError((e) {
      setError("Unexpected error. Please report this incident");
      FlutterError.presentError(
        FlutterErrorDetails(
          exception: e,
          context: ErrorDescription(
            "post() request .catchError callback. Trying to submit with username: '${username.text}'\nemail: '${email.text}'\npassword: '${password.text}'",
          ),
        ),
      );
    });
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
    username.dispose();
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
              if (widget.infoWanted.contains("username")) ...[
                TextInput(hintText: 'Username', controller: username),
                const SizedBox(height: 16),
              ],
              if (widget.infoWanted.contains("email")) ...[
                TextInput(hintText: 'Email', controller: email),
                const SizedBox(height: 16),
              ],
              if (widget.infoWanted.contains("password")) ...[
                TextInput(
                  hintText: 'Password',
                  obscureText: true,
                  controller: password,
                ),
                const SizedBox(height: 30),
              ],
              Button(
                text: widget.submitButtonText,
                backgroundColour: Colors.green.shade400,
                onTap: () => {submit(context)},
              ),
              CustomTextButton(
                text: widget.customButtonText,
                onTap: () =>
                    Navigator.pushNamed(context, widget.customButtonPath),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
