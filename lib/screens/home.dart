import 'package:after_init/after_init.dart';
import 'package:flutter/material.dart';
import 'package:quote_and_joke/locator.dart';
import 'package:quote_and_joke/screens/bookmarks.dart';
import 'package:quote_and_joke/services/joke_service.dart';
import 'package:quote_and_joke/services/quote_service.dart';
import 'package:quote_and_joke/services/visibility_service.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';
import 'package:quote_and_joke/screens/jokes.dart';
import 'package:quote_and_joke/screens/quotes.dart';
import 'package:quote_and_joke/screens/camera.dart';
import 'package:quote_and_joke/screens/today.dart';
import 'package:quote_and_joke/widgets/bottom_nav_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AfterInitMixin<Home> {
  final List<Widget> _screens = [
    Today(),
    QuotesScreen(),
    Jokes(),
    Camera(),
    Bookmarks()
  ];
  Future<bool> _loadData;
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    getIt<QuoteService>().fetchQuotes();
    _loadData = _fetchData();
  }

  Future<bool> _fetchData() async {
    // await Future.delayed(const Duration(seconds: 1));
    await getIt<QuoteService>().generateQOD();
    await getIt<JokeService>().generateJOD();
    return true;
  }

  // called once after initState, used because I need context to get media query data
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

  void _onTap(int index) {
    index == 1
        ? getIt<VisibilityService>().showScreen(true)
        : Future.delayed(const Duration(milliseconds: 20),
            () => getIt<VisibilityService>().showScreen(false));

    if (mounted)
      setState(() {
        _currentIndex = index;
      });

    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _loadData,
          builder: (_, snapshot) {
            return snapshot.hasData
                ? PageView(
                    controller: _pageController,
                    children: _screens,
                    physics: NeverScrollableScrollPhysics(),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).accentColor),
                    ),
                  );
          }),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => _onTap(index),
      ),
    );
  }
}
