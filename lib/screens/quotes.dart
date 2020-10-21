import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:quote_and_joke/locator.dart';
import 'package:quote_and_joke/services/quote_service.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';
import 'package:quote_and_joke/widgets/main_quote.dart';

class QuotesScreen extends StatefulWidget {
  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _animationController2;
  AnimationController _animationController3;
  Animation _animation2;
  Animation _animation3;
  Animation _animationContainer1;
  Animation _animationContainer2;
  Animation _animationContainer3;
  Animation _animationContainer4;
  int _index = 0;
  int _nextIndex = 1;
  bool _leftDrag = false;
  bool _isSwipe = false;
  // to slide off screen
  int _maxMainSlide = -100;
  // to get to position of main quote
  double _maxSecondarySlideX = SizeConfig.safeBlockHorizontal * 108.9;
  double _maxSecondarySlideY = SizeConfig.safeBlockVertical * -26.9;
  bool showFirstMainQuote = true;

  @override
  void initState() {
    super.initState();
    initializeAnimationControllers();
    getIt<QuoteService>().addListener(() {
      if (mounted) setState(() {});
    });
  }

  void initializeAnimationControllers() {
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
      duration: const Duration(milliseconds: 800),
    );
    _animation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          curve: Interval(0.0, 0.80, curve: Curves.ease),
          parent: _animationController3),
      // would love to remove this part, dont forget if(.value == 1) _nextPage
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) _nextPage();
        },
      );
    _animationContainer1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          curve: Interval(0.0, 0.80, curve: Curves.decelerate),
          parent: _animationController3),
    );
    _animationContainer2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          curve: Interval(0.1, 0.85, curve: Curves.decelerate),
          parent: _animationController3),
    );
    _animationContainer3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          curve: Interval(0.15, 0.9, curve: Curves.decelerate),
          parent: _animationController3),
    );
    _animationContainer4 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          curve: Interval(0.2, 1, curve: Curves.decelerate),
          parent: _animationController3),
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
    setState(() {
      showFirstMainQuote = false;
    });
  }

  void _nextPage() {
    setState(() {
      _index++;
      _nextIndex++;
      _animationController.value = 0;
      _animationController2.value = 0;
      _animationController3.value = 0;
      if (_nextIndex == getIt<QuoteService>().quotes.length - 2) {
        setState(() {
          _index = 0;
          _nextIndex = 1;
          getIt<QuoteService>().fetchQuotes();
        });
      }
    });
  }

  void _onDragStart(DragStartDetails details) {
    _leftDrag =
        _animationController.isDismissed && details.globalPosition.dx > 200;
    setState(() {
      showFirstMainQuote = true;
    });
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
    return !getIt<QuoteService>().isLoading
        ? GestureDetector(
            onTap: _onTap,
            onHorizontalDragStart: _onDragStart,
            onHorizontalDragUpdate: _onDragUpdate,
            onHorizontalDragEnd: _onDragEnd,
            behavior: HitTestBehavior.opaque,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                BackgroundContainer(
                  animationController: _animationContainer1,
                  angle: -math.pi / 5,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 30,
                      SizeConfig.safeBlockVertical * 12),
                  opacity: 1,
                ),
                BackgroundContainer(
                  animationController: _animationContainer2,
                  angle: -math.pi / 6.2,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 32,
                      SizeConfig.safeBlockVertical * 6),
                  opacity: 0.5,
                ),
                BackgroundContainer(
                  animationController: _animationContainer3,
                  angle: -math.pi / 7.6,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 32,
                      SizeConfig.safeBlockVertical * 2),
                  opacity: 0.5,
                ),
                BackgroundContainer(
                  animationController: _animationContainer4,
                  angle: -math.pi / 10,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 32,
                      SizeConfig.safeBlockVertical * -1),
                  opacity: 0.3,
                ),
                // text of quote shown at start (there's 2 at same spot)
                // this one can be slided
                AnimatedBuilder(
                    animation: _animationController,
                    child: MainQuote(
                      index: _index,
                    ),
                    // swipe functionality
                    builder: (_, child) {
                      double slide = _maxMainSlide * _animationController.value;
                      double angleY =
                          (math.pi / 2) * _animationController.value;

                      return Opacity(
                        opacity: showFirstMainQuote ? 1 : 0,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..translate(slide)
                            ..rotateZ(angleY),
                          child: child,
                        ),
                      );
                    }),
                // same main quote as first, but used when tapped
                AnimatedBuilder(
                    animation: _animation3,
                    child: MainQuote(
                      index: _index,
                    ),
                    builder: (_, child) {
                      return Opacity(
                        opacity: showFirstMainQuote ? 0 : 1 - _animation3.value,
                        child: Transform.scale(
                          scale: 1 - (0.3 * _animation3.value),
                          child: child,
                        ),
                      );
                    }),

                // quote following the first one, basically is just invisible till it's needed
                AnimatedBuilder(
                  animation: _animation3,
                  child: MainQuote(
                    index: _nextIndex,
                  ),
                  builder: (_, child) => Opacity(
                    opacity: _animation3.value,
                    child: Transform.scale(
                      scale: 0.9 + (0.1 * _animation3.value),
                      child: child,
                    ),
                  ),
                ),
                // blur activated when quote is tapped
                AnimatedBuilder(
                  animation: _animation3,
                  builder: (_, __) => BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 2 * math.sin(math.pi * _animation3.value).abs(),
                      sigmaY: 2 * math.sin(math.pi * _animation3.value).abs(),
                    ),
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                // next quote that is rendered outside of screen so that when you swipe it comes out flying
                AnimatedBuilder(
                    animation: _animationController2,
                    child: Transform.translate(
                      offset: Offset(SizeConfig.safeBlockVertical * 50,
                          SizeConfig.safeBlockHorizontal * -35),
                      child: Transform.rotate(
                        angle: -math.pi / 2,
                        child: MainQuote(
                          index: _nextIndex,
                        ),
                      ),
                    ),
                    builder: (context, child) {
                      double slideX = _maxSecondarySlideX * _animation2.value;
                      double slideY = _maxSecondarySlideY * _animation2.value;
                      double angleY = (math.pi / 2) * _animation2.value;
                      return Opacity(
                        opacity: _animation2.value,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..translate(slideX, slideY)
                            ..rotateZ(angleY),
                          child: child,
                        ),
                      );
                    }),
              ],
            ),
          )
        // replace one day with animation of containers swirling
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Loading more quotes",
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: SizeConfig.safeBlockHorizontal * 8),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 5,
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.orange,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[200]),
              ),
            ],
          );
  }
}

class BackgroundContainer extends StatefulWidget {
  const BackgroundContainer({
    @required this.animationController,
    @required this.angle,
    @required this.opacity,
    @required this.offset,
  });

  final Animation animationController;
  final double angle;
  final double opacity;
  final Offset offset;

  @override
  _BackgroundContainerState createState() => _BackgroundContainerState();
}

class _BackgroundContainerState extends State<BackgroundContainer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (_, child) => Opacity(
        opacity: getIt<QuoteService>().show ? widget.opacity : 0,
        child: Transform.rotate(
          angle: widget.angle,
          child: Transform.translate(
            offset: widget.offset,
            child: Transform.scale(
              scale: 1 -
                  0.1 *
                      math
                          .sin(math.pi * widget.animationController.value)
                          .abs(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [Color(0xFF6FD9E2), Color(0xFFDBDFB8)],
                  ),
                ),
                height: SizeConfig.screenHeight / 1.3,
                width: SizeConfig.screenWidth * 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
