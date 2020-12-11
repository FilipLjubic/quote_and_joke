import 'package:flutter/material.dart';

class ThemedCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Theme.of(context).primaryColor,
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
    );
  }
}
