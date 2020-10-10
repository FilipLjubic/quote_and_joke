import 'dart:math' as math;
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quote_and_joke/locator.dart';
import 'package:quote_and_joke/services/quotes_service.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

class Quotes extends StatefulWidget {
  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> with TickerProviderStateMixin {
  List<String> quotes = [];
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
  double _maxSecondarySlideX = SizeConfig.safeBlockHorizontal * 96.4;
  double _maxSecondarySlideY = SizeConfig.safeBlockVertical * -33.5;
  double ctrl3 = 0.0;

  @override
  void initState() {
    super.initState();
    quotes = getIt<QuoteService>().getQuotes();

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
      //TODO: delete ifs
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
      } else {
        _isSwipe = false;
      }
      // makes dragging smooth instead of linear and awkward
      double delta = -details.primaryDelta /
          (-_maxMainSlide * 1.5 * math.log(-_maxMainSlide));
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    // if quote is over "half" screen
    bool isDismissedOrSwiped = _animationController.value > 0.25 || _isSwipe;
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
          // text of quote shown at start
          // fades out depending on whether it's being slided or tapped
          // if tapped it also scales down a bit to make the other text seem to pop out
          // in builder is swipe functionality
          Opacity(
            opacity: 1 - ctrl3,
            child: Transform.scale(
              scale: 1 - (0.3 * ctrl3),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, _) {
                  double slide = _maxMainSlide * _animationController.value;
                  double angleY = (math.pi / 2) * _animationController.value;

                  return Transform(
                    transform: Matrix4.identity()
                      ..translate(slide)
                      ..rotateZ(angleY),
                    child: MainQuote(
                      quotes: quotes,
                      index: _index,
                      isUnconstrained: false,
                      color: Colors.black
                          .withOpacity(1 - _animationController.value),
                    ),
                  );
                },
              ),
            ),
          ),
          // quote following the first one, basically is just invisible till it's needed
          Opacity(
            opacity: ctrl3,
            child: Transform.scale(
              scale: 0.9 + (0.1 * ctrl3),
              child: MainQuote(
                quotes: quotes,
                index: _nextIndex,
                color: Colors.black.withOpacity(ctrl3),
                isUnconstrained: false,
              ),
            ),
          ),
          // blur activated when quote is tapped
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 2 * math.sin(math.pi * ctrl3).abs(),
              sigmaY: 2 * math.sin(math.pi * ctrl3).abs(),
            ),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          // next quote that is rendered outside of screen so that when you swipe it comes out flying
          AnimatedBuilder(
              animation: _animationController2,
              builder: (context, _) {
                double slideX = _maxSecondarySlideX * _animation2.value;
                double slideY = _maxSecondarySlideY * _animation2.value;
                double angleY = (math.pi / 2) * _animation2.value;
                //  * _animation2.value;
                return Transform(
                  transform: Matrix4.identity()
                    ..translate(slideX, slideY)
                    ..rotateZ(angleY),
                  child: Transform.translate(
                    offset: Offset(SizeConfig.safeBlockVertical * 50,
                        SizeConfig.safeBlockHorizontal * -35),
                    child: Transform.rotate(
                      angle: -math.pi / 2,
                      child: MainQuote(
                        index: _nextIndex,
                        quotes: quotes,
                        isUnconstrained: true,
                        color: Colors.black.withOpacity(_animation2.value),
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
  const MainQuote(
      {@required this.quotes,
      @required this.index,
      @required this.isUnconstrained,
      @required this.color});
  //TODO: Load quotes through get_it
  final List<String> quotes;
  final int index;
  final bool isUnconstrained;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.safeBlockHorizontal * 10,
          top: SizeConfig.safeBlockVertical * 12),
      child: SizedBox(
        width: SizeConfig.screenWidth * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              quotes[index],
              maxLines: 5,
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 9.5,
                color: color,
              ),
              textAlign: TextAlign.left,
            ),
            AutoSizeText(
              "KING",
              maxLines: 1,
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                color: color.withOpacity(0.5),
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
