import 'package:flutter/material.dart';

class ThemedCircularProgressIndicator extends StatelessWidget {
  const ThemedCircularProgressIndicator([this.size]);
  final size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        backgroundColor: Theme.of(context).primaryColor,
        valueColor:
            AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
      ),
    );
  }
}
