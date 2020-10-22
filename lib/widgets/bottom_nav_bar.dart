import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    @required this.currentIndex,
    @required this.onTap,
  });

  final int currentIndex;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      elevation: 7.0,
      unselectedItemColor: Colors.black38,
      showUnselectedLabels: false,
      selectedItemColor: Colors.orange,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Today",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.format_quote),
          label: "Quotes",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.tag_faces),
          label: "Jokes",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: "Add",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.collections_bookmark),
          label: "Bookmarks",
        )
      ],
      onTap: onTap,
    );
  }
}
