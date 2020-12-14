import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quote_and_joke/models/quote_model.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

class QuoteText extends HookWidget {
  const QuoteText({this.qod});

  final Quote qod;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          SizeConfig.safeBlockVertical * 5,
          SizeConfig.safeBlockVertical * 5,
          SizeConfig.safeBlockVertical * 5,
          0),
      child: Column(
        children: [
          AutoSizeText(
            qod.quote,
            style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 5.7,
                color: Colors.black87),
            maxLines: 7,
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 2,
          ),
          Text(
            qod.author,
            style: TextStyle(color: Colors.black45),
          ),
        ],
      ),
    );
  }
}
