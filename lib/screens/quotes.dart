import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:quote_and_joke/state/quote_index_notifier.dart';
import 'package:quote_and_joke/state/visibility_helper.dart';
import 'package:quote_and_joke/utils/mixins/quote/quote_animation_mixin.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';
import 'package:quote_and_joke/widgets/quotes_screen/background/background_container.dart';
import 'package:quote_and_joke/widgets/quotes_screen/background/background_container_drag.dart';
import 'package:quote_and_joke/widgets/quotes_screen/background/first_background_container.dart';
import 'package:quote_and_joke/widgets/quotes_screen/background/hidden_background_container.dart';
import 'package:quote_and_joke/widgets/quotes_screen/text/on_slide_quote.dart';
import 'package:quote_and_joke/widgets/quotes_screen/text/on_slide_quote_off_screen.dart';
import 'package:quote_and_joke/widgets/quotes_screen/text/on_tap_quote_hidden.dart';
import 'package:quote_and_joke/widgets/quotes_screen/text/on_tap_quote_shown.dart';

// FIRST MAKING THE WIDGETS WORK, THEN CHANGING THEM TO HOOKWIDGETS,
// THEN CHANGING THEIR DEPENDENCIES TO USE PROVIDER
// THEN TAKING ANOTHER LOOK AT THEIR STRUCTURE

// ignore: must_be_immutable
class QuotesScreen extends HookWidget with QuoteAnimationMixin {
  @override
  Widget build(BuildContext context) {
    final quoteIndex = useProvider(quoteIndexProvider);
    final isDrag = useProvider(isDragProvider).state;
    final hideBecauseOverflow = useProvider(hideScreenProvider).state;

    // ignore: unused_local_variable
    final inAnimation =
        useProvider(inAnimationProvider); // needed for correct rebuilding

    initializeControllers();
    useEffect(() {
      fields.animation2.addStatusListener((status) {
        if (status == AnimationStatus.completed) nextPage(context);
      });

      fields.animationContainerTap4.addStatusListener((status) {
        if (status == AnimationStatus.completed) nextPage(context);
      });
      return () {};
    }, []);

    // TODO: kada je error ne smije se moci swipeati ni tappati
    return GestureDetector(
      onTap: () => onTap(context),
      onHorizontalDragStart: (details) => onDragStart(context, details),
      onHorizontalDragUpdate: (details) => onDragUpdate(context, details),
      onHorizontalDragEnd: (details) => onDragEnd(context, details),
      behavior: HitTestBehavior.opaque,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Drag containers are shown when text is being slided, otherwise they're hidden
          // this one had to be done manually because it has different function for translation
          FirstBackgroundContainer(
              fields: fields,
              isDrag: isDrag,
              hideBecauseOverflow: hideBecauseOverflow),
          // this one is hidden until the first container gets to half its needed distance
          // has the effect of being summoned out of nowhere
          HiddenBackgroundContainer(
              fields: fields,
              isDrag: isDrag,
              hideBecauseOverflow: hideBecauseOverflow),
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
          OnSlideQuote(fields: fields, quoteIndex: quoteIndex, isDrag: isDrag),
          // same main quote, but used when tapped
          OnTapQuoteShown(
              fields: fields, quoteIndex: quoteIndex, isDrag: isDrag),

          // quote that's after the first one, basically is just invisible till it's needed
          OnTapQuoteHidden(fields: fields, quoteIndex: quoteIndex),

          // next quote that is rendered outside of screen so that when you swipe it comes out flying
          OnSlideQuoteOffScreen(
            fields: fields,
            quoteIndex: quoteIndex,
          ),
        ],
      ),
    );
    // replace one day with animation of containers swirling
  }
}
