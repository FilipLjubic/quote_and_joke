import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quote_and_joke/state/visibility_helper.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

class BackgroundContainer extends HookWidget {
  const BackgroundContainer({
    @required this.animationController,
    @required this.angle,
    @required this.opacity,
    @required this.offset,
  });

  final Animation animationController;
  final double angle;
  final double opacity;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    final hideBecauseOverflow = useProvider(hideScreenProvider).state;

    return AnimatedBuilder(
      animation: animationController,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Color(0xFF6FD9E2), Color(0xFFDBDFB8)],
          ),
        ),
        height: SizeConfig.screenHeight / 1.3,
        width: SizeConfig.screenWidth * 2,
      ),
      builder: (_, child) => Opacity(
        opacity: hideBecauseOverflow ? 0 : opacity,
        child: Transform.rotate(
          angle: angle,
          child: Transform.translate(
            offset: offset,
            child: Transform.scale(
              scale: 1 - 0.15 * math.sin(math.pi * animationController.value),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
