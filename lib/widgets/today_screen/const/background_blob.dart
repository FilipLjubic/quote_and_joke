import 'package:flutter/material.dart';

class BackgroundBlob extends StatelessWidget {
  const BackgroundBlob({
    @required this.height,
    @required this.width,
    @required this.begin,
    @required this.end,
  });

  final height;
  final width;
  final begin;
  final end;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.8),
            Theme.of(context).accentColor.withOpacity(0.8),
          ],
        ),
      ),
    );
  }
}
