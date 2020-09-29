import 'package:flutter/material.dart';

class Quotes extends StatefulWidget {
  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> with SingleTickerProviderStateMixin {
  final List<String> quotes = ['Quote1', 'NOT A QUOTE 2'];
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
    );
    _animation =
        CurvedAnimation(curve: Curves.easeInExpo, parent: _animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return GestureDetector(
      onTap: () => setState(() {
        _index++;
        if (_index == quotes.length) {
          _index = 0;
        }
      }),
      child: Center(
        child: Container(
          child: Text(
            quotes[_index],
            style: TextStyle(fontSize: 30.0),
          ),
        ),
      ),
    );
  }
}
