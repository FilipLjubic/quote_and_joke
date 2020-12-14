import 'package:flutter/material.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

class TodayHeadline extends StatelessWidget {
  const TodayHeadline();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 3,
          top: SizeConfig.safeBlockVertical * 3),
      child: Text(
        "Today's",
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 7,
          color: Colors.black87,
          letterSpacing: SizeConfig.safeBlockHorizontal * 0.2,
        ),
      ),
    );
  }
}
