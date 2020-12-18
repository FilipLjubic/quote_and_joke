import 'package:flutter/material.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';
import 'package:quote_and_joke/widgets/jokes_screen/draw_idle_clipper.dart';

class WobblyContainer extends StatelessWidget {
  const WobblyContainer({
    @required this.animationController,
    this.opacity,
    @required this.begin,
    @required this.end,
    @required this.height,
  });

  final AnimationController animationController;
  final begin;
  final end;
  final double opacity;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: Opacity(
        opacity: opacity,
        child: Container(
          height: SizeConfig.screenHeight * height,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: begin, end: end, colors: [
              Theme.of(context).primaryColor.withOpacity(0.8),
              Theme.of(context).accentColor.withOpacity(0.8),
            ]),
          ),
        ),
      ),
      builder: (_, child) => ClipPath(
        clipper: DrawIdleClipper(animationController.value),
        child: child,
      ),
    );
  }
}
