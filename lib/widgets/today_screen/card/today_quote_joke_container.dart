import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quote_and_joke/state/visibility_helper.dart';
import 'package:quote_and_joke/state/qod_notifier.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';
import 'package:quote_and_joke/widgets/themed_circular_progress_indicator.dart';
import 'package:quote_and_joke/widgets/today_screen/card/joke_text.dart';
import 'package:quote_and_joke/widgets/today_screen/card/quote_text.dart';
import 'package:quote_and_joke/widgets/today_screen/card/save.dart';

class TodayQuoteJokeContainer extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final showQod = useProvider(showQodProvider).state;
    final qod = useProvider(qodNotifierProvider.state);

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockHorizontal * 2,
          vertical: SizeConfig.safeBlockVertical),
      child: Material(
        elevation: 1.0,
        child: AnimatedCrossFade(
          firstChild: qod.when(
            data: (qod) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                QuoteText(qod: qod),
                Save(),
              ],
            ),
            loading: () => Center(
              child: ThemedCircularProgressIndicator(),
            ),
            error: (s, t) => Container(
              padding: EdgeInsets.fromLTRB(
                  SizeConfig.safeBlockVertical * 5,
                  SizeConfig.safeBlockVertical * 5,
                  SizeConfig.safeBlockVertical * 5,
                  0),
              child: AutoSizeText(
                "There seems to be a problem with your connection",
                style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 5.7,
                    color: Colors.black87),
                maxLines: 10,
              ),
            ),
          ),
          secondChild: JokeText(),
          crossFadeState:
              showQod ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 150),
          firstCurve: Curves.ease,
          secondCurve: Curves.ease,
        ),
      ),
    );
  }
}
