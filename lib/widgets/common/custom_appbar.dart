import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({Key? key}) : super(key: key);
  
  @override
  Color? get backgroundColor => super.backgroundColor ?? Colors.orange.shade900;
}
