import 'dart:math';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

class Quotes extends StatefulWidget {
  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> with TickerProviderStateMixin {
  final List<String> quotes = [
    "It's so hard to forget pain, but it's even harder to remember sweetness.",
    'Darkness cannot drive out darkness, only light can do that.',
    "Even the smallest person can change the course of the future.",
  ];
  AnimationController _animationController;
  AnimationController _animationController2;
  AnimationController _animationController3;
  Animation _animation2;
  Animation _animation3;
  int _index = 0;
  int _nextIndex = 1;
  bool _leftDrag = false;
  bool _isSwipe = false;
  // to slide off screen
  int _maxMainSlide = -100;
  // to get to position of last one
  double _maxSecondarySlideX = SizeConfig.safeBlockHorizontal * 10.8;
  double _maxSecondarySlideY = SizeConfig.safeBlockVertical * -72.5;
  double ctrl3 = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _animationController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation2 = CurvedAnimation(
        curve: Curves.easeOutCubic, parent: _animationController2)
      ..addListener(() {
        if (_animation2.value == 1) {
          _nextPage();
        }
      });
    _animationController3 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation3 = CurvedAnimation(
        curve: Curves.easeInOutCubic, parent: _animationController3)
      ..addListener(
        () => setState(() {
          ctrl3 = _animation3.value;
          if (ctrl3 == 1) {
            _nextPage();
          }
        }),
      );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController2.dispose();
    _animationController3.dispose();
    super.dispose();
  }

  void _onTap() {
    _animationController3.forward();
  }

  void _nextPage() {
    setState(() {
      _index++;
      _nextIndex++;
      _animationController.value = 0;
      _animationController2.value = 0;
      _animationController3.value = 0;
      if (_index == quotes.length) _index = 0;
      if (_nextIndex == quotes.length) _nextIndex = 0;
    });
  }

  void _onDragStart(DragStartDetails details) {
    _leftDrag =
        _animationController.isDismissed && details.globalPosition.dx > 200;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_leftDrag) {
      if (details.primaryDelta < -11) {
        _isSwipe = true;
      }
      // makes dragging smooth instead of linear and awkward
      double delta =
          -details.primaryDelta / (-_maxMainSlide * 1.2 * log(-_maxMainSlide));
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    bool isDismissedOrSwiped = _animationController.value > 0.3 || _isSwipe;
    if (!isDismissedOrSwiped) {
      _animationController.reverse();
    } else {
      _animationController.forward();
      _animationController2.forward();
      _isSwipe = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Opacity(
            opacity: 1 - ctrl3,
            child: Transform.scale(
              scale: 1 - (0.2 * ctrl3),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, _) {
                  double slide = _maxMainSlide * _animationController.value;
                  double angleY = (pi / 2) * _animationController.value;

                  return MainQuote(
                    slide: slide,
                    angleY: angleY,
                    quotes: quotes,
                    index: _index,
                    animationController: _animationController,
                  );
                },
              ),
            ),
          ),
          Opacity(
            opacity: ctrl3,
            child: Transform.scale(
              scale: 0.9 + (0.1 * ctrl3),
              child: MainQuote(
                quotes: quotes,
                index: _nextIndex,
                animationController: _animationController,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 2 * sin(pi * ctrl3).abs(),
              sigmaY: 2 * sin(pi * ctrl3).abs(),
            ),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          AnimatedBuilder(
              animation: _animationController2,
              builder: (context, _) {
                double slideX = _maxSecondarySlideX * _animation2.value;
                double slideY = _maxSecondarySlideY * _animation2.value;
                double angleY = -(pi / 2) * _animation2.value;
                return Transform(
                  transform: Matrix4.identity()
                    ..translate(slideX, slideY)
                    ..rotateZ(-angleY),
                  child: UnconstrainedBox(
                    clipBehavior: Clip.none,
                    child: SizedBox(
                      width: SizeConfig.screenWidth * 0.9,
                      child: Transform.translate(
                        offset: Offset(SizeConfig.safeBlockHorizontal * 90,
                            SizeConfig.safeBlockVertical * -35),
                        child: Transform.rotate(
                          angle: -pi / 2,
                          child: AutoSizeText(
                            quotes[_nextIndex],
                            maxLines: 5,
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 9.5,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class MainQuote extends StatelessWidget {
  const MainQuote({
    Key key,
    @required this.quotes,
    @required int index,
    @required AnimationController animationController,
    this.slide = 0,
    this.angleY = 0,
  })  : _index = index,
        _animationController = animationController,
        super(key: key);

  final double slide;
  final double angleY;
  final List<String> quotes;
  final int _index;
  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..translate(slide)
        ..rotateZ(angleY),
      child: Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.safeBlockHorizontal * 10,
            bottom: SizeConfig.blockSizeVertical * 25),
        child: SizedBox(
          width: SizeConfig.screenWidth * 0.9,
          child: AutoSizeText(
            quotes[_index],
            maxLines: 5,
            style: TextStyle(
              fontSize: SizeConfig.blockSizeHorizontal * 9.5,
              color: Colors.black.withOpacity(1 - _animationController.value),
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
