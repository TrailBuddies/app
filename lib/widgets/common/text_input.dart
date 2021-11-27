import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final TextStyle style;
  final String hintText;
  final bool obscureText;

  const TextInput({
    Key? key,
    this.obscureText = false,
    this.style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
    required this.hintText,
  }) : super(key: key);

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscureText,
      style: widget.style,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );
  }
}
