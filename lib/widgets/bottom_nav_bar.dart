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
          title: Text("Today"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.format_quote),
          title: Text("Quotes"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.tag_faces),
          title: Text("Jokes"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          title: Text("Add"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.collections_bookmark),
          title: Text("Bookmarks"),
        )
      ],
      onTap: onTap,
    );
  }
}
