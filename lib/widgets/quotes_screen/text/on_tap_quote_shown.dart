import 'package:flutter/material.dart';
import 'package:quote_and_joke/state/quote/quote_index_notifier.dart';
import 'package:quote_and_joke/utils/mixins/quote/quote_animation_mixin_fields.dart';
import 'package:quote_and_joke/widgets/quotes_screen/text/main_quote.dart';

class OnTapQuoteShown extends StatelessWidget {
  const OnTapQuoteShown({
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
        });
  }
}
