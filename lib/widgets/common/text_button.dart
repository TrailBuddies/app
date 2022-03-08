import 'package:flutter/material.dart';

class TextButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final Color textColour;

  const TextButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.textColour = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      text: text,
      onTap: onTap,
      textColour: textColour,
    );
  }
}
