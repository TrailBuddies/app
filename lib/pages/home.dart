import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trail_buddies/pages/feed.dart';
import 'package:trail_buddies/pages/me.dart';

class PageTab {
  IoniconsData icon;
  IoniconsData iconActive;
  Widget widget;

  PageTab({
    required this.icon,
    required this.iconActive,
    required this.widget,
  });
}

class HomePage extends StatefulWidget {
  final int? selectedPage;

  const HomePage({
    Key? key,
    this.selectedPage,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 0;
  final List<PageTab> pages = [
    PageTab(
      icon: Ionicons.home_outline,
      iconActive: Ionicons.home,
      widget: const FeedPage(),
    ),
    PageTab(
      icon: Ionicons.person_outline,
      iconActive: Ionicons.person,
      widget: const MePage(),
    ),
    PageTab(
      icon: Ionicons.pin_outline,
      iconActive: Ionicons.pin,
      widget: const Text("saved hikes"),
    ),
    PageTab(
      icon: Ionicons.chatbox_outline,
      iconActive: Ionicons.chatbox,
      widget: const Text("messages"),
    ),
  ];

  @override
  void initState() {
    selected = widget.selectedPage ?? 0;
    super.initState();
  }

  void onPagePressed(int i) {
    setState(() {
      selected = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade500,
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(0, -3),
              blurRadius: 5,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...pages.map((p) {
              int i = pages.indexOf(p);
              return InkWell(
                onTap: () => onPagePressed(i),
                child: SizedBox(
                  height: 50,
                  width: 95,
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 255, 245, 180),
                        blurRadius: 2,
                        spreadRadius: selected == i ? 1 : 2,
                      ),
                    ]),
                    child: Icon(
                      selected == i ? p.iconActive : p.icon,
                      size: 30,
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 251, 226),
      body: pages[selected].widget,
    );
  }
}
