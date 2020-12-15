import 'package:flutter/material.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

class Jokes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: SizeConfig.screenHeight * 0.5,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topCenter,
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.8),
                  Theme.of(context).accentColor.withOpacity(0.8),
                ]),
          ),
        ),
        Positioned(
          left: SizeConfig.blockSizeHorizontal * 3,
          top: SizeConfig.screenHeight * 0.3,
          child: SizedBox(
            width: SizeConfig.screenWidth * 0.95,
            child: Text(
              "What's a chicken with 3 legs called?",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.blockSizeHorizontal * 7.5),
            ),
          ),
        ),
        Positioned(
          bottom: SizeConfig.screenHeight * 0.25,
          left: SizeConfig.blockSizeHorizontal * 3,
          child: Text(
            "ur mom lol",
            style: TextStyle(
              fontSize: SizeConfig.blockSizeHorizontal * 7.5,
              color: Colors.black87,
            ),
          ),
        )
      ],
    );
  }
}
