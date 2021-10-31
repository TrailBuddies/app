import 'package:flutter/widgets.dart';
import 'package:trail_buddies/widgets/common/background_image.dart';
import 'package:trail_buddies/widgets/landing_page/lets_go_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BackgroundImage(
      children: [
        LetsGoButton(center: true),
      ],
    );
  }
}
