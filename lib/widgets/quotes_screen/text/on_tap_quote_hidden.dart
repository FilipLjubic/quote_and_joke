import 'package:flutter/material.dart';
import 'package:quote_and_joke/state/quote_index_notifier.dart';
import 'package:quote_and_joke/utils/mixins/quote/quote_animation_mixin_fields.dart';
import 'package:quote_and_joke/widgets/quotes_screen/text/main_quote.dart';

class OnTapQuoteHidden extends StatelessWidget {
  const OnTapQuoteHidden({
    @required this.fields,
    @required this.quoteIndex,
  });

  final QuoteAnimationMixinFields fields;
  final QuoteIndex quoteIndex;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: fields.animation3pt2,
      child: MainQuote(
        index: quoteIndex.currentIndex + 1,
      ),
      builder: (_, child) => Opacity(
        opacity: fields.animation3pt2.value,
        child: Transform.scale(
          scale: 0.75 + (0.25 * fields.animation3pt2.value),
          child: child,
        ),
      ),
    );
  }
}
