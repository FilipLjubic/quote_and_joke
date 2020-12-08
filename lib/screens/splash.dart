import 'package:flutter/material.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

class SplashScreen extends StatelessWidget {
  // TODO: fetch quotes & jokes (daily and lists)
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
