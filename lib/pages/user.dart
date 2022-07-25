import 'package:flutter/material.dart';

import 'package:trail_buddies/user.dart';
import 'package:trail_buddies/widgets/common/custom_appbar.dart';

class UserPage extends StatefulWidget {
  final String id;

  const UserPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  User? user;
  bool loading = true;

  Future<void> fetchUser() async {
    final user = await User.fetch(widget.id);
    setState(() {
      this.user = user;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mounted && user == null) {
      fetchUser();
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('User'),
      ),
      body: RefreshIndicator(
        onRefresh: fetchUser,
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  if (loading)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else if (user == null)
                    const Center(
                      child: Text('No user found'),
                    )
                  else
                    const Center(
                      child: Text('User page'),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
