import 'package:flutter/material.dart';
import 'package:quote_and_joke/screen_size_config.dart';

class Today extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Text(
              "Today",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 10,
                  color: Colors.black87),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
              child: Text("ayy lmoa"),
            ),
          ),
        ],
      ),
    );
  }
}
