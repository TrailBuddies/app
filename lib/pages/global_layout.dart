import 'package:flutter/material.dart';
import 'package:decorated_icon/decorated_icon.dart';
import 'package:ionicons/ionicons.dart';

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
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 87, 122, 59),
                boxShadow: [
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
                  IconButton(
                    icon: DecoratedIcon(
                      selected == 0 ? Ionicons.home : Ionicons.home_outline,
                      size: 30,
                    ),
                    onPressed: () => onPagePressed(0),
                  ),
                  IconButton(
                    icon: DecoratedIcon(
                      selected == 1 ? Ionicons.person : Ionicons.person_outline,
                      size: 30,
                    ),
                    onPressed: () => onPagePressed(1),
                  ),
                  IconButton(
                    icon: DecoratedIcon(
                      selected == 2 ? Ionicons.folder : Ionicons.folder_outline,
                      size: 30,
                    ),
                    onPressed: () => onPagePressed(2),
                  ),
                  IconButton(
                    icon: DecoratedIcon(
                      selected == 3
                          ? Ionicons.chatbox
                          : Ionicons.chatbox_outline,
                      size: 30,
                    ),
                    onPressed: () => onPagePressed(3),
                  ),
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
