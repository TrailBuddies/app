import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final Color? textColour;
  final ButtonStyle? style;

  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.textColour,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: style,
      child: Text(
        text,
        style: TextStyle(color: textColour ?? Colors.blue.shade400),
      ),
    );
  }
}
