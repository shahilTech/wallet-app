import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomNavigationBarView extends StatelessWidget {
  final int pageIndex;
  void Function(int)? onTabTapped;

  BottomNavigationBarView({
    Key? key,
    required this.pageIndex,
    this.onTabTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      currentIndex: pageIndex,
      onTap: onTabTapped,
      selectedItemColor: const Color.fromARGB(255, 112, 140, 163),
      unselectedItemColor: Colors.black,
      selectedIconTheme:
          const IconThemeData(color: Color.fromARGB(255, 77, 25, 190)),
      unselectedIconTheme: const IconThemeData(color: Colors.grey),
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(
            icon: Container(
                width: 42,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: pageIndex == 0
                          ? const Color.fromARGB(255, 112, 140, 163)
                          : Colors.white,
                      width: 3,
                    ),
                  ),
                ),
                child: const Icon(Icons.home)),
            label: ''),
        BottomNavigationBarItem(
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: pageIndex == 1
                        ? const Color.fromARGB(255, 112, 140, 163)
                        : Colors.white,
                    width: 3,
                  ),
                ),
              ),
              child: const Icon(
                Icons.person,
              ),
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: pageIndex == 2
                        ? const Color.fromARGB(255, 112, 140, 163)
                        : Colors.white,
                    width: 3,
                  ),
                ),
              ),
              child: const Icon(
                Icons.settings,
              ),
            ),
            label: ''),
      ],
    );
  }
}
