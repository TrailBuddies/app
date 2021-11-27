import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final Color textColour;
  final Color backgroundColour;
  final double width;
  final double height;

  const Button({
    Key? key,
    required this.text,
    required this.onTap,
    this.textColour = Colors.white,
    this.backgroundColour = Colors.grey,
    this.width = 136,
    this.height = 46,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 136,
        height: 46,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 4),
              blurRadius: 4,
            )
          ],
          color: backgroundColour,
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            style: TextStyle(
              color: textColour,
              fontFamily: 'Ruda',
              fontSize: 24,
              letterSpacing: 0,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}
