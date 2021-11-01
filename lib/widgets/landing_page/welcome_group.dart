import 'package:flutter/material.dart';

import './lets_go_button.dart';
import './logo.dart';

class WelcomeGroup extends StatelessWidget {
  const WelcomeGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 136,
        height: 250,
        child: Stack(
          alignment: Alignment.topCenter,
          children: const [
            Positioned(
              top: 0,
              child: Logo(),
            ),
            Positioned(
              top: 150,
              child: Hero(
                child: LetsGoButton(),
                tag: 'lets_go',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
