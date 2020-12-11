import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:quote_and_joke/services/visibility_helper.dart';
import 'package:quote_and_joke/utils/constants.dart';
import 'package:quote_and_joke/utils/mixins/quote_animation_mixin.dart';
import 'package:quote_and_joke/utils/mixins/quote_animation_mixin_fields.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';
import 'package:quote_and_joke/widgets/main_quote.dart';

// ignore: must_be_immutable
class QuotesScreen extends HookWidget with QuoteAnimationMixin {
  // to slide off screen
  // to get to position of main quote
  double _maxSecondarySlideX = SizeConfig.safeBlockHorizontal * 106.4;
  double _maxSecondarySlideY = SizeConfig.safeBlockVertical * -25.6;

  void _addListeners() {
    fields.animation2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        nextPage();
      }
    });
    fields.animationContainerTap4.addStatusListener((status) {
      if (status == AnimationStatus.completed) nextPage();
    });
  }

  void _initializeFields() {
    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 700));
    final animationController2 =
        useAnimationController(duration: const Duration(milliseconds: 450));
    final animationController3 =
        useAnimationController(duration: const Duration(milliseconds: 900));

    fields = useMemoized(() => QuoteAnimationMixinFields(
        animationController, animationController2, animationController3));
  }

  void _runAnimationHooks() {
    _initializeFields();
    _addListeners();
  }

  @override
  Widget build(BuildContext context) {
    final quoteIndex = useProvider(quoteIndexProvider);
    final isDrag = useProvider(isDragProvider).state;
    final hideBecauseOverflow = useProvider(hideScreenProvider).state;
    final isLoading = useProvider(isLoadingProvider).state;
    _runAnimationHooks();

    return isLoading
        ? GestureDetector(
            onTap: onTap,
            onHorizontalDragStart: onDragStart,
            onHorizontalDragUpdate: onDragUpdate,
            onHorizontalDragEnd: onDragEnd,
            behavior: HitTestBehavior.opaque,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                // Drag containers are shown when text is being slided, otherwise they're hidden
                // this one had to be done manually because it has different function for translation
                AnimatedBuilder(
                    animation: fields.animationContainerDrag1,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [Color(0xFF6FD9E2), Color(0xFFDBDFB8)]),
                      ),
                      height: SizeConfig.screenHeight / 1.3,
                      width: SizeConfig.screenWidth * 2,
                    ),
                    builder: (_, child) {
                      double opacity = isDrag ? 1 : 0;
                      double angleOffset = (math.pi / 5 - math.pi / 6.2) / 2;
                      double returnEffect = math
                          .sin(fields.animationContainerDrag1.value * math.pi);
                      return Opacity(
                        opacity: hideBecauseOverflow ? 0 : opacity,
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
                    animation: fields.animationContainerDrag1,
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
                      double opacity =
                          isDrag && fields.animationContainerDrag1.value >= 0.5
                              ? fields.animationContainerDrag1.value * 0.6
                              : 0;
                      double angleOffset = math.pi / 5 - math.pi / 6.2;

                      return Opacity(
                        opacity: hideBecauseOverflow ? 0 : opacity,
                        child: Transform.rotate(
                          angle: -math.pi / 5 +
                              angleOffset *
                                  fields.animationContainerDrag1.value,
                          child: Transform.translate(
                            offset: Offset(SizeConfig.safeBlockHorizontal * 31,
                                    SizeConfig.safeBlockVertical * 10) +
                                Offset(SizeConfig.safeBlockHorizontal * 1,
                                        SizeConfig.safeBlockVertical * -4) *
                                    fields.animationContainerDrag1.value,
                            child: child,
                          ),
                        ),
                      );
                    }),
                BackgroundContainerDrag(
                  animationController: fields.animationContainerDrag2,
                  angle: -math.pi / 6.2,
                  angleEnd: -math.pi / 7.6,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 32,
                      SizeConfig.safeBlockVertical * 6),
                  translation: Offset(SizeConfig.safeBlockHorizontal * -1,
                      SizeConfig.safeBlockVertical * -4),
                  opacity: isDrag ? 0.6 : 0,
                  opacityReduction: 0.1,
                ),
                BackgroundContainerDrag(
                  animationController: fields.animationContainerDrag3,
                  angle: -math.pi / 7.6,
                  angleEnd: -math.pi / 10,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 31,
                      SizeConfig.safeBlockVertical * 2),
                  translation: Offset(SizeConfig.safeBlockHorizontal * -1,
                      SizeConfig.safeBlockVertical * -3),
                  opacity: isDrag ? 0.5 : 0,
                  opacityReduction: 0.1,
                ),
                BackgroundContainerDrag(
                  animationController: fields.animationContainerDrag4,
                  angle: -math.pi / 10,
                  angleEnd: -math.pi / 13,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 30,
                      SizeConfig.safeBlockVertical * -1),
                  translation: Offset(SizeConfig.safeBlockHorizontal * -2,
                      SizeConfig.safeBlockVertical * -4),
                  opacity: isDrag ? 0.4 : 0,
                  opacityReduction: 0.4,
                ),
                BackgroundContainer(
                  animationController: fields.animationContainerTap1,
                  angle: -math.pi / 5,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 31,
                      SizeConfig.safeBlockVertical * 10),
                  opacity: isDrag ? 0 : 1,
                ),
                BackgroundContainer(
                  animationController: fields.animationContainerTap2,
                  angle: -math.pi / 6.2,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 32,
                      SizeConfig.safeBlockVertical * 6),
                  opacity: isDrag ? 0 : 0.6,
                ),
                BackgroundContainer(
                  animationController: fields.animationContainerTap3,
                  angle: -math.pi / 7.6,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 31,
                      SizeConfig.safeBlockVertical * 2),
                  opacity: isDrag ? 0 : 0.5,
                ),
                BackgroundContainer(
                  animationController: fields.animationContainerTap4,
                  angle: -math.pi / 10,
                  offset: Offset(SizeConfig.safeBlockHorizontal * 30,
                      SizeConfig.safeBlockVertical * -1),
                  opacity: isDrag ? 0 : 0.4,
                ),
                // text of quote shown at start (there's 2 at same spot)
                // this one can be slided
                AnimatedBuilder(
                    animation: fields.animation1,
                    child: MainQuote(
                      index: quoteIndex.currentIndex,
                    ),
                    // swipe functionality
                    builder: (_, child) {
                      double slide =
                          -1 * MAX_MAIN_SLIDE * fields.animation1.value;
                      double angleY = (math.pi / 2) * fields.animation1.value;

                      return Opacity(
                        opacity: isDrag ? 1 : 0,
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
                    animation: fields.animation3pt1,
                    child: MainQuote(
                      index: quoteIndex.currentIndex,
                    ),
                    builder: (_, child) {
                      return Opacity(
                        opacity: isDrag ? 0 : 1 - fields.animation3pt1.value,
                        child: Transform.scale(
                          scale: 1 - (0.25 * fields.animation3pt1.value),
                          child: child,
                        ),
                      );
                    }),

                // quote that's after the first one, basically is just invisible till it's needed
                AnimatedBuilder(
                  animation: fields.animation3pt2,
                  child: MainQuote(
                    index: quoteIndex.currentIndex,
                  ),
                  builder: (_, child) => Opacity(
                    opacity: fields.animation3pt2.value,
                    child: Transform.scale(
                      scale: 0.75 + (0.25 * fields.animation3pt2.value),
                      child: child,
                    ),
                  ),
                ),
                // blur activated when quote is tapped
                AnimatedBuilder(
                  animation: fields.animation3,
                  builder: (_, __) => BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 1.5 * math.sin(math.pi * fields.animation3.value),
                      sigmaY: 1.5 * math.sin(math.pi * fields.animation3.value),
                    ),
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                // next quote that is rendered outside of screen so that when you swipe it comes out flying
                AnimatedBuilder(
                    animation: fields.animationController2,
                    child: Transform.translate(
                      offset: Offset(SizeConfig.safeBlockVertical * 50,
                          SizeConfig.safeBlockHorizontal * -35),
                      child: Transform.rotate(
                        angle: -math.pi / 2,
                        child: MainQuote(
                          index: quoteIndex.currentIndex + 1,
                        ),
                      ),
                    ),
                    builder: (context, child) {
                      double slideX =
                          _maxSecondarySlideX * fields.animation2.value;
                      double slideY =
                          _maxSecondarySlideY * fields.animation2.value;
                      double angleY = (math.pi / 2) * fields.animation2.value;
                      return Opacity(
                        opacity: fields.animation2.value,
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
                backgroundColor: Theme.of(context).primaryColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).accentColor),
              ),
            ],
          );
  }
}

class BackgroundContainer extends HookWidget {
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
  Widget build(BuildContext context) {
    final hideBecauseOverflow = useProvider(hideScreenProvider).state;
    return AnimatedBuilder(
      animation: animationController,
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
        opacity: hideBecauseOverflow ? 0 : opacity,
        child: Transform.rotate(
          angle: angle,
          child: Transform.translate(
            offset: offset,
            child: Transform.scale(
              scale: 1 - 0.15 * math.sin(math.pi * animationController.value),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class BackgroundContainerDrag extends HookWidget {
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
  Widget build(BuildContext context) {
    final angleOffset = useMemoized(() => -angle + angleEnd);
    final hideBecauseOverflow = useProvider(hideScreenProvider).state;
    return AnimatedBuilder(
      animation: animationController,
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
        opacity: hideBecauseOverflow
            ? 0
            : opacity - opacityReduction * animationController.value,
        child: Transform.rotate(
          angle: angle + angleOffset * animationController.value,
          child: Transform.translate(
            offset: offset + translation * animationController.value,
            child: child,
          ),
        ),
      ),
    );
  }
}
