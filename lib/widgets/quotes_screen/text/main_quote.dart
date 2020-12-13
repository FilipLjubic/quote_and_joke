import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quote_and_joke/state/quotes_notifier.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

class MainQuote extends HookWidget {
  const MainQuote({this.index});
  final index;

  @override
  Widget build(BuildContext context) {
    final quotes = useProvider(quotesNotifierProvider.state);

    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.safeBlockHorizontal * 5,
          top: SizeConfig.safeBlockVertical * 12),
      child: SizedBox(
          width: SizeConfig.screenWidth * 0.9,
          child: quotes.when(
            data: (quotes) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  quotes[index].quote,
                  maxLines: 5,
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 9.5,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                AutoSizeText(
                  quotes[index].authorShort,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            error: (e, st) => Container(),
            loading: () => Container(),
          )),
    );
  }
}
