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
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) => (states.contains(MaterialState.pressed)
              ? backgroundColour.withOpacity(0.5)
              : backgroundColour),
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) => (states.contains(MaterialState.pressed)
              ? textColour.withOpacity(0.5)
              : textColour),
        ),
        alignment: Alignment.center,
        shape: MaterialStateProperty.all<OutlinedBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        style: TextStyle(
          color: textColour,
          fontFamily: 'Poiret One',
          fontSize: 24,
          letterSpacing: 0,
          fontWeight: FontWeight.bold,
          height: 1,
        ),
      ),
    );
  }
}
