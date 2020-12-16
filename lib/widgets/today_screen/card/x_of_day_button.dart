import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:quote_and_joke/state/visibility_helper.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';
import 'package:quote_and_joke/widgets/today_screen/card/button_type.dart';

class XOfDayButton extends StatelessWidget {
  const XOfDayButton({@required this.showQod, @required this.type});

  final bool showQod;
  final ButtonType type;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        color: showQod
            ? Theme.of(context).primaryColor
            : Theme.of(context).accentColor,
        elevation: 1.0,
        child: Text(
          type == ButtonType.quote ? "Today's Quote" : "Today's Joke",
          style: TextStyle(
            color: showQod ? Colors.white : Colors.black54,
            fontSize: SizeConfig.safeBlockHorizontal * 4,
          ),
        ),
        onPressed: () {
          final showQod = context.read(showQodProvider);
          type == ButtonType.quote
              ? showQod.state = true
              : showQod.state = false;
        });
  }
}
