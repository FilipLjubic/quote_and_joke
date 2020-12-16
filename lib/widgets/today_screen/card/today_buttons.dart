import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quote_and_joke/state/visibility_helper.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';
import 'package:quote_and_joke/widgets/today_screen/card/button_type.dart';
import 'package:quote_and_joke/widgets/today_screen/card/x_of_day_button.dart';

class TodayButtons extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final showQod = useProvider(showQodProvider).state;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockHorizontal * 2,
          vertical: SizeConfig.safeBlockVertical),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: XOfDayButton(showQod: showQod, type: ButtonType.quote),
          ),
          SizedBox(
            width: SizeConfig.safeBlockHorizontal,
          ),
          Expanded(
              child: XOfDayButton(showQod: !showQod, type: ButtonType.joke)),
        ],
      ),
    );
  }
}
