import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quote_and_joke/state/quote_index_notifier.dart';
import 'package:quote_and_joke/utils/constants.dart';
import 'package:quote_and_joke/utils/mixins/quote_animation_mixin_fields.dart';
import 'package:quote_and_joke/widgets/quotes_screen/text/main_quote.dart';

class OnSlideQuote extends StatelessWidget {
  const OnSlideQuote({
    @required this.fields,
    @required this.quoteIndex,
    @required this.isDrag,
  });

  final QuoteAnimationMixinFields fields;
  final QuoteIndex quoteIndex;
  final bool isDrag;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: fields.animation1,
        child: MainQuote(
          index: quoteIndex.currentIndex,
        ),
        // swipe functionality
        builder: (_, child) {
          double slide = -1 * MAX_MAIN_SLIDE * fields.animation1.value;
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
        });
  }
}
