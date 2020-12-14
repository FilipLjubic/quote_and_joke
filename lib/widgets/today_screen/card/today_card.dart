import 'package:flutter/material.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';
import 'package:quote_and_joke/widgets/today_screen/card/today_buttons.dart';
import 'package:quote_and_joke/widgets/today_screen/card/today_quote_joke_container.dart';

class TodayCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockHorizontal * 5,
          vertical: SizeConfig.safeBlockVertical * 3),
      child: Material(
        elevation: 5.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 5, child: TodayQuoteJokeContainer()),
            Expanded(flex: 1, child: TodayButtons()),
          ],
        ),
      ),
    );
  }
}
