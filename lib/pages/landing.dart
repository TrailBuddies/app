import 'package:flutter/material.dart';

import 'package:trail_buddies/widgets/common/button.dart';
import 'package:trail_buddies/widgets/common/background_image.dart';
import 'package:trail_buddies/widgets/landing_page/logo.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        children: [
          Center(
            child: SizedBox(
              width: 136,
              height: 250,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  const Positioned(
                    top: 0,
                    child: Logo(),
                  ),
                  Positioned(
                    top: 150,
                    child: Button(
                      text: 'Lets Go!',
                      backgroundColour: const Color.fromRGBO(232, 73, 23, 1),
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, '/login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
