import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quote_and_joke/services/visibility_helper.dart';
import 'package:quote_and_joke/utils/mixins/quote_animation_mixin_fields.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';
import 'package:quote_and_joke/widgets/quotes_screen/text/main_quote.dart';

class OnSlideQuoteOffScreen extends HookWidget {
  const OnSlideQuoteOffScreen({
    @required this.fields,
    @required this.quoteIndex,
  });

  final QuoteAnimationMixinFields fields;
  final QuoteIndex quoteIndex;

  @override
  Widget build(BuildContext context) {
    final _maxSecondarySlideX =
        useMemoized(() => SizeConfig.safeBlockHorizontal * 106.4);
    final _maxSecondarySlideY =
        useMemoized(() => SizeConfig.safeBlockVertical * -25.6);

    return AnimatedBuilder(
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
          double slideX = _maxSecondarySlideX * fields.animation2.value;
          double slideY = _maxSecondarySlideY * fields.animation2.value;
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
        });
  }
}
