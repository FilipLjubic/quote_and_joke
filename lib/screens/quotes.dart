import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

class Quotes extends StatefulWidget {
  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> with SingleTickerProviderStateMixin {
  final List<String> quotes = [
    'The size of the sword doesn\'t matter. It\'s the size of the thought that counts!',
    'NOT A QUOTE 2'
  ];
  AnimationController _animationController;
  int _index = 0;
  double y = pi / 2;
  bool _canBeDragged = false;
  int _maxSlide = -100;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
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

  void _onDragStart(DragStartDetails details) {
    bool isDragFromLeft =
        _animationController.isDismissed && details.globalPosition.dx > 200;
    print(details.globalPosition.dx);
    _canBeDragged = isDragFromLeft;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / (_maxSlide * 1.5);
      print(details.primaryDelta);
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity =
          details.velocity.pixelsPerSecond.dx / SizeConfig.screenHeight;
      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value > 0.3) {
      _animationController.forward(from: _animationController.value);
    } else if (_animationController.value <= 0.3) {
      _animationController.reverse(from: _animationController.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              double slide = _maxSlide * _animationController.value;
              double angleY = y * _animationController.value;

              return Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..rotateZ(angleY),
                child: Text(
                  quotes[_index],
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black
                        .withOpacity(1 - _animationController.value),
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
