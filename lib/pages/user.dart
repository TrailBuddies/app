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
    final user = await User.fetch(widget.id, true);
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
                    Container(
                      margin: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user!.username,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          if (user!.verified == true)
                            RichText(
                              text: TextSpan(
                                text: 'Verified ',
                                style: Theme.of(context).textTheme.bodyText1,
                                children: const [
                                  WidgetSpan(
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/verified-icon.png'),
                                      height: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (user!.admin == true)
                            RichText(
                              text: TextSpan(
                                text: 'Admin ',
                                style: Theme.of(context).textTheme.bodyText1,
                                children: const [
                                  WidgetSpan(
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/admin-icon.png'),
                                      height: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
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
