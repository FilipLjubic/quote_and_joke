import 'package:after_init/after_init.dart';
import 'package:flutter/material.dart';
import 'package:quote_and_joke/screen_size_config.dart';
import 'package:quote_and_joke/screens/jokes.dart';
import 'package:quote_and_joke/screens/quotes.dart';
import 'package:quote_and_joke/screens/camera.dart';
import 'package:quote_and_joke/screens/today.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AfterInitMixin<Home> {
  final List<Widget> _screens = [Today(), Quotes(), Jokes(), Camera()];
  int _currentIndex = 0;
  PageController _pageController;
  MediaQueryData mediaQueryData;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void didInitState() {
    // since there's only portrait mode
    SizeConfig().init(context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2),
          child: Text(
            "Quote & Joke",
            style: TextStyle(
                color: Colors.black54,
                fontSize: SizeConfig.safeBlockHorizontal * 5),
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: PageView(
        controller: _pageController,
        children: _screens,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
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
            icon: Icon(Icons.camera_alt),
            title: Text("Camera"),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 600),
              curve: Curves.fastLinearToSlowEaseIn);
        },
      ),
    );
  }
}
