import 'package:flutter/material.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

class Jokes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Positioned(
          top: 0,
          height: SizeConfig.screenHeight * 0.4,
          width: SizeConfig.screenWidth,
          child: Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.only(bottomLeft: const Radius.circular(100)),
              color: Colors.yellow,
            ),
          ),
        ),
      ],
    );
  }
}
