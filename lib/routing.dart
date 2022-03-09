import 'package:flutter/material.dart';

import './pages/check_login/widget.dart';
import './pages/login.dart';
import './pages/me.dart';
import './pages/register.dart';

Widget getPageWidget(String name) {
  if (name == '/login') {
    return const LoginPage();
  }

  if (name == '/register') {
    return const RegisterPage();
  }

  if (name == '/me') {
    return const MePage();
  }

  return const CheckLogin();
}
