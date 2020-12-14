import 'package:flutter/material.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

class TodayTitle extends StatelessWidget {
  const TodayTitle();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        "Quote & Joke",
        style: TextStyle(
            color: Colors.black54,
            fontSize: SizeConfig.safeBlockHorizontal * 5),
      ),
    );
  }
}
