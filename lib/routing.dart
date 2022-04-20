import 'package:flutter/material.dart';
import 'package:trail_buddies/pages/hike.dart';

import './declarations.dart';
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

  if (RegExp('^/hike/$uuidRegex').hasMatch(name)) {
    final uri = Uri.parse(name);
    final uuid = uri.pathSegments.last;

    return HikePage(id: uuid);
  }

  return const CheckLogin();
}

MaterialPageRoute getPage(String name) {
  return MaterialPageRoute(builder: (_) => getPageWidget(name));
}
