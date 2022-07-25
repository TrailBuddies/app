import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({Key? key, Widget? title}) : super(key: key, title: title);

  @override
  Color? get backgroundColor => super.backgroundColor ?? Colors.orange.shade900;
}
