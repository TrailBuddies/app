import 'package:flutter/material.dart';
import 'package:decorated_icon/decorated_icon.dart';
import 'package:ionicons/ionicons.dart';

class PageTab {
  IoniconsData icon;
  IoniconsData iconActive;

  PageTab({
    required this.icon,
    required this.iconActive,
  });
}

class GlobalLayout extends StatefulWidget {
  final Widget child;

  const GlobalLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<GlobalLayout> createState() => _GlobalLayoutState();
}

class _GlobalLayoutState extends State<GlobalLayout> {
  int selected = 0;

  final List<PageTab> pages = [
    PageTab(icon: Ionicons.home_outline, iconActive: Ionicons.home),
    PageTab(icon: Ionicons.person_outline, iconActive: Ionicons.person),
    PageTab(icon: Ionicons.pin_outline, iconActive: Ionicons.pin),
    PageTab(icon: Ionicons.chatbox_outline, iconActive: Ionicons.chatbox),
  ];

  void onPagePressed(int i) {
    setState(() {
      selected = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 251, 226),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 50,
            child: Container(
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
          ),
          // widget.child,
        ],
      ),
    );
  }
}
