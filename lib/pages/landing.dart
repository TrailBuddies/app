import 'package:flutter/material.dart';
import '../widgets/common/background_image.dart';
import '../widgets/landing_page/welcome_group.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BackgroundImage(
        children: [
          WelcomeGroup(),
          Hero(
            tag: 'lets_go',
            child: Text("test"),
          ),
        ],
      ),
    );
  }
}
