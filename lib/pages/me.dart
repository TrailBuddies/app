import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trail_buddies/user_changenotifier.dart';
import 'package:trail_buddies/widgets/common/custom_appbar.dart';

class MePage extends StatelessWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);

    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 160),
            Text(user.email),
            Text(user.id),
          ],
        ),
      ),
    );
  }
}
