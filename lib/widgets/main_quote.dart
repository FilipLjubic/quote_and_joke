import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quote_and_joke/services/quote_service.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

class MainQuote extends StatelessWidget {
  const MainQuote({
    @required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.safeBlockHorizontal * 5,
          top: SizeConfig.safeBlockVertical * 12),
      child: SizedBox(
        width: SizeConfig.screenWidth * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              getIt<QuoteService>().quotes[index].quote,
              maxLines: 5,
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 9.5,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            AutoSizeText(
              getIt<QuoteService>().quotes[index].authorShort,
              maxLines: 1,
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                color: Colors.black.withOpacity(0.5),
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
