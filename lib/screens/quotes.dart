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
  Animation _animation1;
  Animation _animation2;
  Animation _animation3;
  Animation _animationContainerTap1;
  Animation _animationContainerTap2;
  Animation _animationContainerTap3;
  Animation _animationContainerTap4;
  Animation _animationContainerDrag1;
  Animation _animationContainerDrag2;
  Animation _animationContainerDrag3;
  Animation _animationContainerDrag4;
  int _index = 0;
  bool _leftDrag = false;
  bool _isSwipe = false;
  bool _inAnimation = false;
  // to slide off screen
  int _maxMainSlide = -100;
  // to get to position of main quote
  double _maxSecondarySlideX = SizeConfig.safeBlockHorizontal * 106.4;
  double _maxSecondarySlideY = SizeConfig.safeBlockVertical * -25.6;

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
      duration: const Duration(milliseconds: 700),
    );
    _animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          curve: Interval(0.0, 0.875), parent: _animationController),
    );
    _animationContainerDrag1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.875, curve: Curves.easeOut),
      ),
    );
    _animationContainerDrag2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.05, 0.93, curve: Curves.easeOut),
      ),
    );
    _animationContainerDrag3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.07, 0.96, curve: Curves.easeOut),
      ),
    );
    _animationContainerDrag4 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.1, 1.0, curve: Curves.easeOut),
      ),
    );

    _animationController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _animation2 = CurvedAnimation(
        curve: Curves.easeOutCubic, parent: _animationController2)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _nextPage();
        }
      });

    _animationController3 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          curve: Interval(0.0, 0.75, curve: Curves.easeOut),
          parent: _animationController3),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) _nextPage();
        },
      );
    _animationContainerTap1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          curve: Interval(0.0, 0.75, curve: Curves.easeOutCubic),
          parent: _animationController3),
    );
    _animationContainerTap2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          curve: Interval(0.05, 0.8, curve: Curves.easeOutCubic),
          parent: _animationController3),
    );
    _animationContainerTap3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          curve: Interval(0.08, 0.9, curve: Curves.easeOutCubic),
          parent: _animationController3),
    );
    _animationContainerTap4 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          curve: Interval(0.12, 1, curve: Curves.easeOutCubic),
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
      _inAnimation = true;
    });
    getIt<QuoteService>().setDrag(false);
  }

  void _nextPage() {
    setState(() {
      _index++;
      _animationController.value = 0;
      _animationController2.value = 0;
      _animationController3.value = 0;
      _inAnimation = false;
      if (_index + 1 == getIt<QuoteService>().quotes.length - 2) {
        _index = 0;
        getIt<QuoteService>().fetchQuotes();
      }
    });
  }

  void _onDragStart(DragStartDetails details) {
    if (!_inAnimation) {
      _leftDrag =
          _animationController.isDismissed && details.globalPosition.dx > 200;
      getIt<QuoteService>().setDrag(true);
    }
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_leftDrag && !_inAnimation) {
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
    // if quote is over "half" of screen
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
                // Drag containers are shown when text is being slided, otherwise they're hidden
                // this one had to be done manually because it has different function for translation
                AnimatedBuilder(
                    animation: _animationContainerDrag1,
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
                    builder: (_, child) {
                      double opacity = getIt<QuoteService>().isDrag ? 1 : 0;
                      double angleOffset = (math.pi / 5 - math.pi / 6.2) / 2;
                      double returnEffect =
                          math.sin(_animationContainerDrag1.value * math.pi);
                      return Opacity(
                        opacity: getIt<QuoteService>().show ? opacity : 0,
                        child: Transform.rotate(
                          angle: -math.pi / 5 + angleOffset * returnEffect,
                          child: Transform.translate(
                            offset: Offset(SizeConfig.safeBlockHorizontal * 31,
                                    SizeConfig.safeBlockVertical * 10) +
                                Offset(SizeConfig.safeBlockHorizontal * 0.5,
                                        SizeConfig.safeBlockVertical * -2) *
                                    returnEffect,
                            child: child,
                          ),
                        ),
                      );
                    }),
                // this one is hidden until the first container gets to half its needed distance
                // has the effect of being summoned out of nowhere
                AnimatedBuilder(
                    animation: _animationContainerDrag1,
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
                    builder: (_, child) {
                      double opacity = getIt<QuoteService>().isDrag &&
                              _animationContainerDrag1.value >= 0.5
                          ? _animationContainerDrag1.value * 0.6
                          : 0;
                      double angleOffset = math.pi / 5 - math.pi / 6.2;

                      return Opacity(
                        opacity: getIt<QuoteService>().show ? opacity : 0,
                        child: Transform.rotate(
                          angle: -math.pi / 5 +
                              angleOffset * _animationContainerDrag1.value,
                          child: Transform.translate(
                            offset: Offset(SizeConfig.safeBlockHorizontal * 31,
                                    SizeConfig.safeBlockVertical * 10) +
                                Offset(SizeConfig.safeBlockHorizontal * 1,
                                        SizeConfig.safeBlockVertical * -4) *
                                    _animationContainerDrag1.value,
                            child: child,
                          ),
                        ),
                      );
                    }),
                BackgroundContainerDrag(
                  animationController: _animationContainerDrag2,
                  angle: -math.pi / 6.2,
                  angleEnd: -math.pi / 7.6,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 32,
                      SizeConfig.safeBlockVertical * 6),
                  translation: Offset(SizeConfig.safeBlockHorizontal * -1,
                      SizeConfig.safeBlockVertical * -4),
                  opacity: getIt<QuoteService>().isDrag ? 0.6 : 0,
                  opacityReduction: 0.1,
                ),
                BackgroundContainerDrag(
                  animationController: _animationContainerDrag3,
                  angle: -math.pi / 7.6,
                  angleEnd: -math.pi / 10,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 31,
                      SizeConfig.safeBlockVertical * 2),
                  translation: Offset(SizeConfig.safeBlockHorizontal * -1,
                      SizeConfig.safeBlockVertical * -3),
                  opacity: getIt<QuoteService>().isDrag ? 0.5 : 0,
                  opacityReduction: 0.1,
                ),
                BackgroundContainerDrag(
                  animationController: _animationContainerDrag4,
                  angle: -math.pi / 10,
                  angleEnd: -math.pi / 13,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 30,
                      SizeConfig.safeBlockVertical * -1),
                  translation: Offset(SizeConfig.safeBlockHorizontal * -2,
                      SizeConfig.safeBlockVertical * -4),
                  opacity: getIt<QuoteService>().isDrag ? 0.4 : 0,
                  opacityReduction: 0.4,
                ),
                BackgroundContainer(
                  animationController: _animationContainerTap1,
                  angle: -math.pi / 5,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 31,
                      SizeConfig.safeBlockVertical * 10),
                  opacity: getIt<QuoteService>().isDrag ? 0 : 1,
                ),
                BackgroundContainer(
                  animationController: _animationContainerTap2,
                  angle: -math.pi / 6.2,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 32,
                      SizeConfig.safeBlockVertical * 6),
                  opacity: getIt<QuoteService>().isDrag ? 0 : 0.6,
                ),
                BackgroundContainer(
                  animationController: _animationContainerTap3,
                  angle: -math.pi / 7.6,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 31,
                      SizeConfig.safeBlockVertical * 2),
                  opacity: getIt<QuoteService>().isDrag ? 0 : 0.5,
                ),

                BackgroundContainer(
                  animationController: _animationContainerTap4,
                  angle: -math.pi / 10,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 30,
                      SizeConfig.safeBlockVertical * -1),
                  opacity: getIt<QuoteService>().isDrag ? 0 : 0.4,
                ),
                // text of quote shown at start (there's 2 at same spot)
                // this one can be slided
                AnimatedBuilder(
                    animation: _animation1,
                    child: MainQuote(
                      index: _index,
                    ),
                    // swipe functionality
                    builder: (_, child) {
                      double slide = _maxMainSlide * _animation1.value;
                      double angleY = (math.pi / 2) * _animation1.value;

                      return Opacity(
                        opacity: getIt<QuoteService>().isDrag ? 1 : 0,
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
                        opacity: getIt<QuoteService>().isDrag
                            ? 0
                            : 1 - _animation3.value,
                        child: Transform.scale(
                          scale: 1 - (0.2 * _animation3.value),
                          child: child,
                        ),
                      );
                    }),

                // quote following the first one, basically is just invisible till it's needed
                AnimatedBuilder(
                  animation: _animation3,
                  child: MainQuote(
                    index: _index + 1,
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
                      sigmaX: 1.5 * math.sin(math.pi * _animation3.value),
                      sigmaY: 1.5 * math.sin(math.pi * _animation3.value),
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
                          index: _index + 1,
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
      builder: (_, child) => Opacity(
        opacity: getIt<QuoteService>().show ? widget.opacity : 0,
        child: Transform.rotate(
          angle: widget.angle,
          child: Transform.translate(
            offset: widget.offset,
            child: Transform.scale(
              scale: 1 -
                  0.15 * math.sin(math.pi * widget.animationController.value),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class BackgroundContainerDrag extends StatefulWidget {
  const BackgroundContainerDrag({
    @required this.animationController,
    @required this.angle,
    @required this.angleEnd,
    @required this.opacity,
    @required this.opacityReduction,
    @required this.offset,
    @required this.translation,
  });

  final Animation animationController;
  final double angle;
  final double angleEnd;
  final double opacity;
  final double opacityReduction;
  final Offset offset;
  final Offset translation;

  @override
  _BackgroundContainerDragState createState() =>
      _BackgroundContainerDragState();
}

class _BackgroundContainerDragState extends State<BackgroundContainerDrag> {
  double angleOffset;

  @override
  void initState() {
    super.initState();
    angleOffset = -widget.angle + widget.angleEnd;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
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
      builder: (_, child) => Opacity(
        opacity: getIt<QuoteService>().show
            ? widget.opacity -
                widget.opacityReduction * widget.animationController.value
            : 0,
        child: Transform.rotate(
          angle: widget.angle + angleOffset * widget.animationController.value,
          child: Transform.translate(
            offset: widget.offset +
                widget.translation * widget.animationController.value,
            child: child,
          ),
        ),
      ),
    );
  }
}
