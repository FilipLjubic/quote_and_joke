import 'dart:math' as math;
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quote_and_joke/locator.dart';
import 'package:quote_and_joke/services/quote_service.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

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
  int _index = 0;
  int _nextIndex = 1;
  bool _leftDrag = false;
  bool _isSwipe = false;
  // to slide off screen
  int _maxMainSlide = -100;
  // to get to position of last one
  double _maxSecondarySlideX = SizeConfig.safeBlockHorizontal * 108.9;
  double _maxSecondarySlideY = SizeConfig.safeBlockVertical * -26.9;
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
    _animation3 =
        CurvedAnimation(curve: Curves.decelerate, parent: _animationController3)
          ..addListener(
            () => setState(() {
              ctrl3 = _animation3.value;
              if (ctrl3 == 1) {
                _nextPage();
              }
            }),
          );
    getIt<QuoteService>().addListener(() {
      if (mounted) setState(() {});
    });
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
              overflow: Overflow.clip,
              children: [
                BackgroundContainer(
                  ctrl3: ctrl3,
                  angle: -math.pi / 5,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 30,
                      SizeConfig.safeBlockVertical * 10),
                  opacity: 1,
                ),
                BackgroundContainer(
                  ctrl3: ctrl3,
                  angle: -math.pi / 6.2,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 32,
                      SizeConfig.safeBlockVertical * 6),
                  opacity: 0.5,
                ),
                BackgroundContainer(
                  ctrl3: ctrl3,
                  angle: -math.pi / 7.6,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 32,
                      SizeConfig.safeBlockVertical * 2),
                  opacity: 0.5,
                ),
                BackgroundContainer(
                  ctrl3: ctrl3,
                  angle: -math.pi / 10,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 32,
                      SizeConfig.safeBlockVertical * -1),
                  opacity: 0.3,
                ),
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
                        double slide =
                            _maxMainSlide * _animationController.value;
                        double angleY =
                            (math.pi / 2) * _animationController.value;

                        return Transform(
                          transform: Matrix4.identity()
                            ..translate(slide)
                            ..rotateZ(angleY),
                          child: MainQuote(
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
                      return Opacity(
                        // getIt<QuoteService>().show ? 1 : 0
                        opacity: 1,
                        child: Transform(
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
                                isUnconstrained: true,
                                color: Colors.black
                                    .withOpacity(1), //_animation2.value
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.orange,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[200]),
            ),
          );
  }
}

class BackgroundContainer extends StatefulWidget {
  const BackgroundContainer({
    @required this.ctrl3,
    @required this.angle,
    @required this.opacity,
    @required this.offset,
  });

  final double ctrl3;
  final double angle;
  final double opacity;
  final Offset offset;

  @override
  _BackgroundContainerState createState() => _BackgroundContainerState();
}

class _BackgroundContainerState extends State<BackgroundContainer> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: getIt<QuoteService>().show ? widget.opacity : 0,
      child: Transform.rotate(
        angle: widget.angle,
        child: Transform.translate(
          offset: widget.offset,
          child: Transform.scale(
            scale: 1 - 0.1 * math.sin(math.pi * widget.ctrl3).abs(),
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
    );
  }
}

class MainQuote extends StatelessWidget {
  const MainQuote(
      {@required this.index,
      @required this.isUnconstrained,
      @required this.color});
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
              getIt<QuoteService>().quotes[index].quote,
              maxLines: 5,
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 9.5,
                color: color,
              ),
              textAlign: TextAlign.left,
            ),
            AutoSizeText(
              getIt<QuoteService>().quotes[index].authorShort,
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
