import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final TextEditingController controller;
  final TextStyle style;
  final String hintText;
  final bool obscureText;

  const TextInput({
    Key? key,
    this.obscureText = false,
    this.style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      style: widget.style,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(32.0),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );
  }
}
