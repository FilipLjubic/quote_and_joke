import 'dart:math';

import 'package:flutter/material.dart';

class Quotes extends StatefulWidget {
  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> with SingleTickerProviderStateMixin {
  final List<String> quotes = ['Quote1', 'NOT A QUOTE 2'];
  AnimationController _animationController;
  Animation _animation;
  int _index = 0;

  double x = pi / 4;
  double y = pi / 2;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation =
        CurvedAnimation(curve: Curves.easeInExpo, parent: _animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _nextPage() {
    setState(() {
      _index++;
      if (_index == quotes.length) {
        _index = 0;
      }
    });
  }

  void _toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          double slide = -100 * _animation.value;
          double angleX = x * _animation.value;
          double angleY = y * _animation.value;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 30.0,
                top: 100.0,
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(slide)
                    ..rotateZ(angleY),
                  alignment: FractionalOffset.center,
                  child: Text(
                    quotes[_index],
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black.withOpacity(1 - _animation.value),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
