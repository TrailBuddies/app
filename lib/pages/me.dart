import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:trail_buddies/widgets/common/custom_appbar.dart';
import 'package:trail_buddies/user.dart';

class MePage extends StatelessWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        margin: const EdgeInsets.only(top: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                user.email ?? 'unknown',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: user.id));
                  Fluttertoast.showToast(
                    msg: "Copied your user id to clipboard",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    fontSize: 16.0,
                  );
                },
                child: Text(user.id),
              ),
              Container(
                margin: const EdgeInsets.only(top: 100),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    final success =
                        await Provider.of<User>(context, listen: false)
                            .logout();
                    if (success) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false);
                    } else {
                      Fluttertoast.showToast(
                        msg:
                            'Failed to logout. Please report this incident to matievisthekat@gmail.com',
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
